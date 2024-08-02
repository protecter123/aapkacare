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

class Hernia extends StatefulWidget {
  const Hernia({super.key});

  @override
  State<Hernia> createState() => _HerniaState();
}

class _HerniaState extends State<Hernia> {
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
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
                                  'Affordable Hernia Treatment in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Hernia is one of India’s most common medical conditions, affecting almost 12% of our adult population. But thanks to Aapkacare Health, you now have access to advanced treatments from expert surgeons, insurance support, personalised care and much more at the most affordable prices. Read further to learn more about hernia, how to get the best treatment, and why Aapkacare Health is your go-to healthcare partner.',
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
                                    circleCheck(text: 'Complete Insurance Surgery'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
                                    circleCheck(text: 'Post Surgery Assistance'),
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

                  // Eyes
                  LeftRightData(
                    rightImage: 'assets/hernia/hernia.png',
                    heading: 'What is Hernia',
                    description: 'A hernia is when an internal organ or tissue pushes through a weak spot or tear in the muscles or connective tissues that typically hold it in place. Hernias can develop in any part of the body, but most commonly, they occur in the abdominal area. Hernias can appear as painful bulges that gradually grow in size.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Reasons
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
                          textName: "Identify the Signs of Hernia",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/hernia/p4.png", headingName: "Visible Bulge", detailName: "A visible bulge or lump in the affected area"),
                            ReasonBox(image: "assets/hernia/p7.png", headingName: "Pain or Discomfort", detailName: "Eyes become more sensitive towards bright lights including sunlight, car headlights, or indoor lighting."),
                            ReasonBox(image: "assets/hernia/p1.png", headingName: "Gastrointestinal Symptoms", detailName: "Hiatal hernias can lead to heartburn, acid reflux, chest pain, and difficulty swallowing."),
                            ReasonBox(image: "assets/hernia/p2.png", headingName: "Bowel Habits", detailName: "Hernias involving the intestines can affect bowel movements, leading to constipation, diarrhea, or changes in stool consistency."),
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

                  Column(
                    children: [
                      myText(
                        textName: "Understand the causes of Hernia",
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      myText(
                        textName: "Hernias develop when a combination of muscle weakness and increased pressure on the abdominal wall. The specific causes of hernias can vary depending on the type of hernias. Some common causes of Hernia include ",
                        size: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ).px(100 * s.customWidth),
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
                          textName: "These are the most typical causes of muscle weaknesses that lead to hernia: ",
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
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p5.jpg", headingName: "Chronic Straining", detailName: "Chronic straining, such as chronic constipation or chronic obstructive pulmonary disease (COPD), can increase the risk of hernias."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p3.jpg", headingName: "Weakness in the Muscles", detailName: "Muscles and connective tissues in the body can weaken over time due to aging, injury, or genetic predisposition."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p8.jpg", headingName: "Congenital Factors", detailName: "Some people may have natural weakness in their abdominal or groin muscles from birth, which makes them more vulnerable to hernias."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p6.jpg", headingName: "Previous Surgical Incisions", detailName: "Surgical incisions can create weakness in the abdominal wall, making Hernia more likely to occur at or near these incisions."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p10.jpg", headingName: "Chronic Straining", detailName: "Chronic straining, such as chronic constipation or chronic obstructive pulmonary disease (COPD), can increase the risk of hernias."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p9.jpg", headingName: "Obesity", detailName: "Excess body weight can strain the abdominal muscles and increase the risk of hernia development."),
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
                    heading: 'Identify the Signs of Hernia',
                    questions: [
                      'How',
                      'What',
                    ],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How can Hernia be prevented?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: 'Maintain a Healthy Weight: ',
                            regularText: 'Excess body weight can strain your abdominal muscles and increase the risk of hernia development. ',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: 'Avoid Straining:  ',
                            regularText: 'Chronic straining during bowel movements due to constipation can increase abdominal pressure and the risk of hernias.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: 'Quit Smoking: ',
                            regularText: 'Smoking has been linked to an increased risk of hernia development. ',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: 'Strengthen Your Core: ',
                            regularText: 'Engage in exercises that strengthen your core muscles.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: 'Balanced Diet: ',
                            regularText: 'A proper diet can help you prevent the development of Hernia.',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What happens if Hernia is left untreated?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Left untreated, Hernia can lead to various complications and potentially become a medical emergency. The severity of these complications potentially depends on the type of Hernia and individual factors, but here are some potential consequences of untreated hernias:',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Increased Pain and Discomfort: ',
                            regularText: 'Initially, a hernia may cause discomfort or mild pain. The pain and discomfort can worsen without treatment, making it increasingly difficult to perform daily activities.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Enlargement of the Hernia: ',
                            regularText: ' Hernias tend to get more prominent and more noticeable over time. As the hernia sac continues to protrude through the weak area in the muscle or tissue, it can become more apparent and cause more significant bulging or swelling.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Strangulation: ',
                            regularText: 'One of the most severe complications of a hernia is strangulation, which occurs when the blood supply to the trapped organ is. This can lead to tissue damage and necrosis (tissue death), a medical emergency.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Obstruction: ',
                            regularText: ' In some cases, a hernia can become obstructed, which traps a portion of the intestine or other abdominal contents.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Infections: ',
                            regularText: ' Hernias can sometimes become infected, mainly if they involve an organ or tissue that has pushed through the abdominal wall.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Compromised Organ Function: ',
                            regularText: 'If a hernia involves an organ, such as the intestine, and is left untreated, it can eventually lead to impaired organ function.',
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

                  // About Us
                  Container(
                    width: double.infinity,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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

                  // cost
                  LeftRightData(
                    rightImage: 'assets/patient.jpg',
                    heading: 'Are you worried about the cost of cataract treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Cataract in Pune. Even so, the exact cost is hard to pinpoint since your Cataract surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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

class CausesBox extends StatelessWidget {
  final String image;
  final String headingName;
  final String detailName;
  const CausesBox({
    super.key,
    required this.image,
    required this.headingName,
    required this.detailName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          myText(
            textName: headingName,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
          myText(
            textName: detailName,
            fontWeight: FontWeight.w400,
            size: 16,
          )
        ],
      ),
    );
  }
}
