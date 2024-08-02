import 'dart:convert';
import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Drawer/fixedWidgets.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Result%20Page/SearchPage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Baritric extends StatefulWidget {
  const Baritric({super.key});

  @override
  State<Baritric> createState() => _BaritricState();
}

class _BaritricState extends State<Baritric> {
  String? _selectedExperience;
  bool _isListViewVisible = false;
  List<dynamic> listOfLocation = [];
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationController.addListener(_onChange);
    // fetchDataFromFirebase();
  }

  _onChange() {
    placeSuggestion(_locationController.text);
  }

  Future<void> placeSuggestion(String input) async {
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey';
    final corsProxy = 'https://api.allorigins.win/raw?url=';

    final finalUrl = corsProxy + Uri.encodeComponent(url);
    try {
      final response = await http.get(Uri.parse(finalUrl), headers: {
        "x-requested-with": "XMLHttpRequest",
      });
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['predictions'];
        });
      } else {
        print("Response.........Error ");
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  List<String> _experiences = [
    'Doctor',
    // 'Nurse',
    // 'Hospital',
    'Patient',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 110.0), child: const NavBarBooking()),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  //first
                  FirstBox(),
                  SizedBox(
                    height: 20,
                  ),

                  // Form
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                            width: s.width / (s.width < 1024 ? 1.2 : 2.2),
                            // height: 300,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'What is Bariatric Surgery?',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Bariatric surgery is a surgical option to lose weight for people who are extremely overweight and whose weight poses a health hazard.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                        Container(
                          width: s.width < 1024 ? s.width : 300,
                          child: Column(
                            children: [
                              Text(
                                'Best surgery\'s',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'AapkaCare Provide Top Doctors',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 10),
                              Theme(
                                data: ThemeData(
                                  focusColor: Colors.white,
                                  splashColor: Colors.transparent,
                                ),
                                child: Container(
                                  height: 45,
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedExperience,
                                    isExpanded: true, // Ensure the selected text is fully visible
                                    borderRadius: BorderRadius.circular(10),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedExperience = newValue;
                                      });
                                    },
                                    items: _experiences
                                        .map<DropdownMenuItem<String>>(
                                          (String value) => DropdownMenuItem<String>(
                                            alignment: AlignmentDirectional.centerStart,
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      focusColor: Colors.black,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
                                      ),
                                      hintText: 'What you need',
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12), // Adjust padding if necessary
                                    ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey.shade600, width: .4),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, top: 3),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        _isListViewVisible = value.isNotEmpty;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    controller: _locationController,
                                    showCursor: true,
                                    decoration: InputDecoration.collapsed(
                                      fillColor: Colors.black,
                                      focusColor: Colors.black,
                                      hintText: 'Enter Location',
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0,
                                        height: 3,
                                      ),
                                    ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _isListViewVisible,
                                child: Container(
                                  height: 180,
                                  // width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: listOfLocation.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                _locationController.text = listOfLocation[index]["description"];
                                                _isListViewVisible = false;
                                              });
                                            },
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.location_on_rounded,
                                                size: 20,
                                              ),
                                              title: Text(
                                                listOfLocation[index]["description"],
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                ),
                                              ).pSymmetric(v: 5),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10),
                              // _buildSearchInput('City'),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  if (_selectedExperience != null && _locationController.text.isNotEmpty) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SearchPage(
                                              profession: _selectedExperience.toString(),
                                              location: _locationController.text,
                                            )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 800),
                                        content: Text(
                                          'Please fill in all fields before searching.',
                                          style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      'Find',
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: 350,
                          child: Image.asset(
                            'assets/11.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Who Can Opt For Bariatric Surgery?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Bariatric surgery is considered a treatment option in the following cases when the patient has been unable to achieve a healthy body weight over a long period of time, even under medical supervision:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Patients between the ages of 18-65 years',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'If the patient has a body mass index (BMI) of over 37.5 kg.m 2',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'If the patient has a BMI of more than 32.5 kg/m 2 & has serious weight-related problems such as diabetes, high blood pressure, arthritis or heart disease',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    // color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What Are The Different Types Of Bariatric Surgery?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Laparoscopic Gastric Band surgery',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Gastric Bypass',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Laparoscopic Vertical Sleeve Gastrectomy',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Biliopancreatic Diversion with Duodenal Switch',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: 300,
                          child: Image.asset(
                            'assets/111.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    'Why Bariatric Surgery?',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),

                  baritric(color: true, heading: 'The preferred weight loss option…', desc: 'It is a known fact that with bariatric surgeries one can lose 80-100% of excess weight within 1 year and maintain it too for a long time, while with diet and exercises only 5-10% weight loss is possible and that too is regained within 1-3 years. Thus, in suitable person(s), bariatric surgery is the only and preferred option and not the last option.'),

                  baritric(heading: 'Keyhole surgery', desc: 'Though bariatric surgery is perceived to be interventional, due to keyhole approach most patients are discharged from the hospital within 48 hours and can resume work within a week of surgery. Bariatric surgery thus has limited downtime for the patient, leading to significant and sustained weight loss. Unlike cosmetic procedures, the weight loss after surgery is gradual, from all over the body and proportionate.'),

                  baritric(color: true, heading: 'Unlike fad diet(s)', desc: 'In fad diets a person either needs to starve for long hours or eat a particular food group, while after bariatric surgeries patients are asked to eat 3-4 balanced meals everyday leading to healthy weight loss. Most patients are closely supervised by a team of counsellor, dietitian and physician and thus all health parameters improve in patients after surgery.'),

                  baritric(heading: 'Co-morbidity resolution', desc: 'Besides weight loss, bariatric surgery has a direct impact on many associated diseases like diabetes, PCOD, sleep apnoea, cancers etc. These conditions improve directly after the surgery due to associated hormone changes even before significant weight loss is achieved.'),

                  baritric(color: true, heading: 'Diabetes', desc: 'Obesity contributes to diabetes, while bariatric surgery has a direct benefit on blood sugar control through hormonal changes and making the body’s insulin effective. Insulin injection can be stopped in almost all patients and even tablets can be stopped in most as blood sugar comes under control within 1 month. This is a major benefit as uncontrolled diabetes results in multiple complications like heart attack, stroke, kidney failures, nerve damage, eye problems etc. Bariatric surgery thus not only helps achieve better blood sugar control but also reduces the possibility of diabetes complications.'),

                  baritric(heading: 'PCOD, Infertility & Pregnancy', desc: 'In many women with obesity, due to associated hormonal changes and insulin resistance, the menstrual periods are deranged with resultant infertility in few. The impact of bariatric surgery on PCOD is similar to diabetes as improvement of insulin resistance results in normalization of hormones, regular periods and improved fertility. Most women can plan a pregnancy one year after bariatric surgery due to enhanced possibility to conceive, have safer pregnancy as blood sugar and blood pressure are likely to remain normal and are likely to deliver a healthier child through normal delivery unlike recommended caesarean section in morbidly obese before surgery. One year after surgery nutrition intake is considered adequate for both the mother and the baby.'),

                  baritric(color: true, heading: 'Fatty Liver', desc: 'Almost all bariatric patients have different grades of fatty liver on ultrasound examination, which is considered a progressive disease. Bariatric surgery results in the resolution of this disease and the possibility of progression to cirrhosis and liver failure can be halted through early intervention. There are many indirect benefits of surgery due to the mechanical advantage of gradual weight loss which include reduction in blood pressure control, joint pains, backache, mobility and breathlessness.'),

                  baritric(heading: 'Quality of life changes', desc: 'Weight loss associated with bariatric surgery is likely to result in better education access, employability, marital prospects, and job promotions. Most bariatric persons are more confident and positive in the long term.'),

                  baritric(color: true, heading: 'Increased Lifespan', desc: 'Morbid obesity results in shorter lifespan and possibility of sudden death too. A study has shown that post bariatric surgery life span increases by 5-6 years which is even more that 3-4 years after heart bypass surgery. Bariatric surgery is an effective tool producing substantial and sustained weight loss with resolution of co-morbidities and reduction of associated complications. Bariatric surgery works through change in persons’ biology and is not dependent on their will power. Thus, It is more physiological and natural than many unscientific fad diets and obesity treatments.'),

                  // last
                  LastImage(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
