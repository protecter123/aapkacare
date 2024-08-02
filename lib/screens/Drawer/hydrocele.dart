import 'dart:convert';
import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Drawer/fixedWidgets.dart';
import 'package:aapkacare/screens/Drawer/lasikSurgery.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Result%20Page/SearchPage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Hydrocele extends StatefulWidget {
  const Hydrocele({super.key});

  @override
  State<Hydrocele> createState() => _HydroceleState();
}

class _HydroceleState extends State<Hydrocele> {
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
                            width: s.width / (s.width < 1024 ? 1.2 : 2),
                            // height: 300,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Affordable Hydrocole Treatment in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Hydrocele surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of bariatric-related consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons. Welcome to Aapkacare’s comprehensive guide on Hydrocele – a condition affecting the male reproductive system. We’ll explore the causes, signs, treatment options, and surgery for Hydrocele. Understanding this condition is crucial to making informed decisions about when and how to treat it and the benefits of surgery.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: '40 Min Procedure'),
                                    circleCheck(text: 'Keyhole Surgery'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
                                    circleCheck(text: 'Post Surgery Assistance'),
                                    circleCheck(text: 'Complete Insurance Support'),
                                  ],
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
                    height: 20,
                  ),

                  // what
                  LeftRightData(
                    rightImage: 'assets/hydrocele/1.jpg',
                    heading: 'What are Hydrocele?',
                    description: 'Hydrocele is a common medical condition in men, characterized by fluid accumulation in the scrotum, leading to swelling and discomfort. It can affect men of all ages, from newborns to older people. You’re not alone if you or a loved one is facing this issue. Aapkacare is here to provide you with the information you need.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // signs
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        myText(
                          textName: "Identifying the signs of Hydrocele",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/kidney/9.png", headingName: "Scrotal Swelling", detailName: " The most noticeable sign of a hydrocele is swelling in the scrotum. It can range from mild to severe, and the size may change throughout the day."),
                            ReasonBox(image: "assets/kidney/1.png", headingName: " Discomfort or Pain", detailName: "While hydroceles are generally not painful, some individuals may experience discomfort or a sense of heaviness due to the swelling."),
                            ReasonBox(image: "assets/kidney/1.png", headingName: "Transillumination", detailName: "A healthcare professional can shine a light through the scrotum to confirm the presence of fluid."),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // Cause
                  Container(
                    width: s.width,
                    // color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Understanding the causes of Hydrocele ",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 50 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ErrorBox(width: 300, start: true, image: "assets/kidney/6.png", headingName: " Congenital Hydrocele", detailName: "Present at birth, this type of Hydrocele occurs when a connection between the abdominal cavity and the scrotum fails to close."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/5.png", headingName: "Acquired Hydrocele", detailName: "This type is usually caused by inflammation, infection, or trauma to the scrotum, which disrupts the average fluid balance."),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Explain
                  Questions(
                    image: 'assets/what.jpg',
                    heading: 'Our Experts Explain',
                    questions: [
                      'How',
                      'When',
                    ],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How to prevent ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Here are some steps to reduce the risk of acquired Hydrocele:',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '1. Practice Safe Sex: ',
                            regularText: 'Some sexually transmitted infections (STIs) can lead to infections that might cause Hydrocele. Practicing safe sex by using condoms can reduce the risk of these infections.',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '2. Hygiene: ',
                            regularText: ' Maintaining good personal hygiene in the genital area can help prevent infections that might lead to Hydrocele. Regularly clean the area and avoid using harsh soaps or chemicals that could irritate the skin.',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '3. Prevent Injury: ',
                            regularText: 'Take precautions to avoid injuries to the scrotum. Wear protective gear during sports or activities where damage to the groin area is possible.',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '4. Manage Infections:',
                            regularText: 'Promptly treat any infections or inflammations in the genital area, such as epididymitis or orchitis.',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '5. Seek Prompt Medical Attention: ',
                            regularText: 'If you notice any scrotal swelling or discomfort, seek medical attention promptly.',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '6. Understand Risk Factors: ',
                            regularText: 'Some medical conditions and surgeries may increase the risk of Hydrocele.',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'When to Seek Treatment',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'It\'s crucial to consult a healthcare professional if you notice any signs of Hydrocele. While some cases may resolve independently, ruling out any severe underlying conditions is essential. Early diagnosis and treatment can prevent complications.',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Treatment',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The treatment of Hydrocele varies depending on the severity and discomfort it causes. In some cases, conservative management and observation are sufficient. However, surgical intervention may be necessary in more severe or persistent cases.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Diagnosis',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'At Aapka Care, the doctors are well trained in diagnosing the hydrocele with modern equipment and perform a physical examination to detect the root cause. The doctor may check for tenderness in the scrotum while putting slight pressure around the scrotum and lower abdominal region. If the fluid is present, the scrotum will allow light transmission. The doctor may also ask you to cough to check whether you experience pain in the scrotum region. There are a few diagnostic tests the doctor may recommend to find the underlying cause: – Blood test – Urine culture',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Image.asset('assets/hydrocele/4.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LeftRightData(
                      rightImage: 'assets/hydrocele/2.jpg',
                      heading: 'Procedure',
                      description: 'Open hydrocelectomy: This is a surgical procedure that is usually performed under the influence of general anesthesia. During this procedure, the surgeon makes a cut in the scrotum or groin area and drains out the fluid via suction. The surgeon then closes the communication to the canal between the abdominal cavity and the scrotum, before removing the hydrocele sac and closing the incisions with sutures or surgical strips.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benefits of undergoing Hydrocelectomy at Aapka Care in Pune',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Aapka Care strives to provide an efficient, care-filled, and hassle-free surgical experience for every patient. Following are the benefits of choosing our clinics and hospitals for the treatment of your hydrocele:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Most effective hydrocele treatment',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Confidential consultations',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Most experienced urologists in Pune',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'No cuts or incisions',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Painless surgery',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'No upfront payment',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: '45-minute procedure',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'All insurances covered',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'COVID safe clinics and hospitals',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Day-care procedure',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Fast and pain-free recovery',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'No risks of recurrence of the hydrocele',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'No side-effects or complications',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'No running after insurance authorities',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Lifestyle changes that can help in getting relief from hydroceles',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Stay hydrated by drinking lots of fluids',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Avoid wearing tight-fitted clothes',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Practice yoga asanas like Vajrasana, Gomukhasana, Garudasana',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Avoid alcohol and smoking',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Avoid large meals in the evening or at night',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Refrain from putting pressure on the groin area',
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // why
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What complications can arise if hydrocele is left untreated?',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Severe cases of hydrocele can cause serious complications. Some of the potential complications are listed below: ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'If the size of the hydrocele continues growing, it can lead to obstruction in the blood flow. And when the blood flow is not proper in the testicles, it will further give rise to testicular atrophy causing degeneration of the testicular cells.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Another complication that can arise if hydrocele is rupture. Due to the large volume of fluid accumulation in the scrotum, the hydrocele may rupture due to minimal spontaneous trauma.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The hydrocele may transform into a haematocele if there is bleeding in the sac. And if the haematocele is not drained, a clotted haematocele will form as a result.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Calcification of the sac is also a potential complication of leaving hydrocele untreated.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The hydrocele may become infected during aspiration which will increase the swelling and inflammation.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Infected hydroceles can also cause pyocele, accumulation of pus in the scrotum.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Normally, these complications can be identified during diagnosis before the treatment method is selected. All these complications are observed for at least 24-48 hours before proceeding with the treatment. ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // About Us
                  Container(
                    width: double.infinity,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    // color: Colors.blue[50],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'About our Doctors & Hospitals',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'At Aapkacare Health we provide well-experienced and highly qualified doctors to give you the most accurate diagnosis and health care advice.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          leftImage: 'assets/healthcare.jpg',
                          heading: '',
                          description: 'To consult our skilled surgeons for any problems or to undergo cataract surgery, visit the nearest Eye clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the Eye surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for Opthal are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced cataract procedure in Pune.',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Prevention of Hydrocele',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'There is no assured way to prevent hydrocele in a baby. However, in adults, hydrocele usually occurs due to some infection, inflammation, or injury that can be avoided. Here are some preventative tips that will help: ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Proper prenatal care',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Try to avoid being injured, follow the safety & protection rules like wearing athletic cups or support while playing sports.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Practice safe sex to reduce the chances of contracting sexually transmitted infections (STIs).',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Avoid pressure activities like horse riding that can put pressure on the scrotum.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Treat cough properly as recurrent and chronic cough creates intra abdominal pressure and puts strain on the scrotum.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Address constipation as soon as possible.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Appropriate care should be taken to prevent hernia and if you already have it, get proper treatment to reduce the chances of hydrocele development.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Severe cases of hydrocele can cause serious complications. Some of the potential complications are listed below: ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

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
