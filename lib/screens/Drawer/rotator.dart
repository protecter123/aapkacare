import 'dart:convert';
import 'package:aapkacare/screens/Drawer/cataract.dart';
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

class Rotator extends StatefulWidget {
  const Rotator({super.key});

  @override
  State<Rotator> createState() => _RotatorState();
}

class _RotatorState extends State<Rotator> {
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

  Map<String, bool> questionStates = {
    'Question1': false,
    'Question2': false,
    'Question3': false,
    'Question4': false,
    'Question5': false,
    'Question6': false,
    'Question7': false,
    'Question8': false,
    'Question9': false,
    'Question10': false,
    'Question11': false,
    'Question12': false,
  };

  void toggle(String questionKey) {
    setState(() {
      questionStates[questionKey] = !questionStates[questionKey]!;
    });
  }

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
                                  'Affordable Rotator Cuff Repair Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Rotator Cuff surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of bariatric-related consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to Aapkacare’s comprehensive guide on Rotator Cuff Repair. Whether you’re experiencing shoulder pain discomfort or seeking to understand your treatment options, we’re here to provide valuable information. In this guide, we’ll explore the signs, various treatment options, types of surgery, and the benefits of Rotator Cuff Repair. Let’s delve into this topic step by step.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
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

                  // treatment
                  Container(
                    width: double.infinity,
                    // color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
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
                                'What is Rotator Cuff Repair?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Arthroscopic rotator cuff repair is a procedure for fixing a rotator cuff tear, from shaving bone spurs or repairing torn tendons and muscles in the shoulder. If the patient’s injury extends beyond the rotator cuff, then the surgeon can perform modified rotator cuff surgery with bicep repair to correct the injury.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'The rotator cuff comprises a group of muscles and tendons surrounding the shoulder joint. It is responsible for supporting the shoulder joint and keeping the head of the arm within the joint socket. Rotator cuff surgeries are performed for rotator cuff injuries. Rotator cuff damage is very common in people who have jobs that require repeated overhead motions or in athletes due to sudden jerking motions.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 300 : 400,
                          child: Image.asset(
                            'assets/kidney/21.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
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
                          textName: "Signs of Rotator Cuff Issues",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        20.heightBox,
                        myText(
                          textName: "The rotator cuff is a group of muscles and tendons surrounding the shoulder joint, allowing you to lift and rotate your arm. When this complex structure is injured or damaged, it can lead to various signs and symptoms, including:",
                          size: 18,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/hernia/p4.png", headingName: "Pain", detailName: "You may experience persistent pain in your shoulder, especially when lifting or reaching overhead."),
                            ReasonBox(image: "assets/hernia/p7.png", headingName: "Weakness", detailName: "A weakened shoulder can limit your ability to perform routine tasks."),
                            ReasonBox(image: "assets/hernia/p1.png", headingName: "Limited Range of Motion", detailName: "You might find it challenging to move your arm as freely as you used to."),
                            ReasonBox(image: "assets/hernia/p2.png", headingName: "Clicking or Popping", detailName: "Some individuals report unusual noises when moving their shoulders."),
                            ReasonBox(image: "assets/hernia/p2.png", headingName: "Night Pain", detailName: "Discomfort during the night can be a common sign."),
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

                  // Causes
                  Container(
                    width: s.width,
                    // color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        myText(
                          textName: "Understand the causes of Rotator Cuff injury",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Rotator cuff injuries can result from various causes, including acute trauma and chronic wear and tear. Here are some common causes of rotator cuff injuries:",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/hernia/p5.jpg", headingName: "Aging", detailName: "As we age, the tendons of the rotator cuff can degenerate and become more prone to injury. This is a common cause of rotator cuff injuries in older adults."),
                            CausesBox(image: "assets/hernia/p3.jpg", headingName: "Overuse and Repetitive Motion", detailName: "Engaging in activities that require repetitive overhead arm movements, such as pitching in baseball, swimming, or painting, can lead to overuse injuries in the rotator cuff tendons."),
                            CausesBox(image: "assets/hernia/p8.jpg", headingName: "Trauma or Acute Injury", detailName: "A sudden and forceful impact to the shoulder, such as a fall, car accident, or sports-related injury, can cause immediate damage to the rotator cuff tendons or muscles."),
                            CausesBox(image: "assets/hernia/p6.jpg", headingName: "Heavy Lifting", detailName: "Lifting heavy objects, especially with poor lifting techniques or without proper conditioning, can strain the rotator cuff and lead to injury."),
                            CausesBox(image: "assets/hernia/p10.jpg", headingName: "Poor Posture", detailName: "Prolonged periods of poor posture, such as slouching or hunching over a computer, can put additional stress on the shoulder and contribute to rotator cuff problems."),
                            CausesBox(image: "assets/hernia/p9.jpg", headingName: "Muscle Imbalances", detailName: "Imbalances in the muscles surrounding the shoulder joint can place uneven stress on the rotator cuff, increasing the risk of injury."),
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

                  // treatment
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
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
                                'When to Seek Treatment',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'If you’re experiencing any of these signs, it’s essential to consult a healthcare professional, such as those at Aapkacare, to evaluate your condition. Early diagnosis and treatment can prevent further damage and improve overall quality of life.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Treatment Options',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The treatment of rotator cuff issues depends on the severity of the injury. Non-surgical approaches may include rest, physical therapy, and anti-inflammatory medications. However, for more severe cases, surgery may be necessary.',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 400 : 500,
                          child: Image.asset(
                            'assets/kidney/24.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LeftRightData(
                      leftImage: 'assets/kidney/22.jpg',
                      heading: 'How Rotator Cuff Repair Works',
                      description: 'During surgery, the torn tendon is reattached to the bone. Depending on the type of surgery, various techniques may be employed to ensure a stable and robust repair. Your healthcare provider will determine the surgery choice based on your injury’s severity.',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  LeftRightData(
                    rightImage: 'assets/kidney/25.jpg',
                    heading: 'After Treatment',
                    description: 'Following rotator cuff repair surgery, rehabilitation is crucial to regain strength and range of motion in your shoulder. Your healthcare team will provide a tailored plan to guide you through recovery.',
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  //
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'What happens during knee arthroscopy?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Before the surgery, the orthopaedic surgeon will perform a thorough diagnosis. Diagnosis before knee arthroscopy entails physical examination, along with imaging tests like X-rays, shoulder CT scans, MRI, etc. ',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'On the day of the surgery, the surgeon may also perform a blood panel, chest x-ray, electrocardiogram, etc., to assess your vital signs and make sure you can safely undergo the surgery. Following this, the anesthesia will be administered and you will be moved to the operation theater for the surgery. Knee arthroscopy can be performed under general, regional, or local anesthesia.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The surgeon will make a few tiny incisions, called portals, over the knee joint to fill the joint with a sterile solution to improve visibility. Then an arthroscope is inserted to visualize the internal structures. Finally, with the help of the arthroscope, the surgeon will insert the surgical instruments and perform the surgery. After the surgery, the incisions will be closed and bandaged.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The surgery usually lasts less than an hour and then the patient is moved to a recovery room for post-surgery observation to ensure there are no postoperative complications.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Faqs
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                          width: s.width < 1024 ? s.width : 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(
                                textName: "Types of Surgery",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              myText(
                                textName: "There are several surgical procedures available for rotator cuff repair, including:",
                                size: 18,
                              ),
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Arthroscopic Repair",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'A minimally invasive procedure that uses small incisions and a tiny camera to guide the surgeon in reattaching the torn tendon.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Open Surgery",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A larger incision may sometimes be required to repair the rotator cuff.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Mini-Open Repair",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "This combines arthroscopic and open surgery elements, offering the advantages of both approaches.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/acd/1.png',
                            fit: BoxFit.fill,
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
                            height: s.width < 720 ? 200 : 350,
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
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 300 : 400,
                          child: Image.asset(
                            'assets/w2.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'How is arthroscopic rotator cuff operation performed?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The surgery is performed in the following steps:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 18,
                                regularSize: 18,
                                boldText: '• ',
                                regularText: 'Depending on several factors, such as the severity of the symptoms, the patient’s condition, the surgeon’s preference, etc., the surgery may be performed under general or local anaesthesia.',
                              ),
                              CustomRichText(
                                boldSize: 18,
                                regularSize: 18,
                                boldText: '• ',
                                regularText: 'The surgeon creates a couple of tiny incisions. An arthroscope is inserted through the first incision through which the surgeon inspects all the rotator cuff tissues and damage to the tissue.',
                              ),
                              CustomRichText(
                                boldSize: 18,
                                regularSize: 18,
                                boldText: '• ',
                                regularText: 'Through the second incision, the surgeon inserts operative instruments to bring the tendons’ edges together and attach them together using small rivets or sutures called anchors to attach the tendons to the bone.',
                              ),
                              CustomRichText(
                                boldSize: 18,
                                regularSize: 18,
                                boldText: '• ',
                                regularText: 'The rotator cuff repair anchors are made of either metal or plastic and do not need to be removed after the surgery.',
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

                  //
                  Container(
                    width: double.infinity,
                    // color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Minimally invasive arthroscopic shoulder repair at Aapka Care',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Aapka Care is associated with the best orthopedic surgeons in Pune who have ample experience in performing arthroscopic rotator cuff surgery without any complications. Arthroscopic rotator cuff surgery is a minimally invasive surgery that does not involve any significant trauma to the surrounding tissues. The procedure is usually performed for rotator cuff injuries due to : ',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Aging',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Muscular degeneration due to repetitive motions',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Sudden jerking motion like falling down on the outstretched arm',
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // treatment
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      children: [
                        Wrap(
                          spacing: s.width < 1024 ? 0 : 50,
                          runSpacing: 20,
                          children: [
                            Container(
                              width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                              height: s.width < 720 ? 300 : 400,
                              child: Image.asset(
                                'assets/w3.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              width: s.width < 1024 ? s.width : 600,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Benefits of Rotator Cuff Surgery',
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Rotator cuff repair surgery can offer numerous advantages, including:',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 20),
                                  CustomRichText(
                                    boldSize: 18,
                                    regularSize: 18,
                                    boldText: '1. Pain Relief: ',
                                    regularText: 'Surgery can alleviate persistent pain.',
                                  ),
                                  CustomRichText(
                                    boldSize: 18,
                                    regularSize: 18,
                                    boldText: '2. Improved Function: ',
                                    regularText: 'Restored shoulder function can help you return to daily activities.',
                                  ),
                                  CustomRichText(
                                    boldSize: 18,
                                    regularSize: 18,
                                    boldText: '3. Prevention of Further Damage:',
                                    regularText: ' Surgery can prevent the worsening of the injury.',
                                  ),
                                  CustomRichText(
                                    boldSize: 18,
                                    regularSize: 18,
                                    boldText: '4. Enhanced Quality of Life: ',
                                    regularText: ' Regaining your shoulder’s strength and mobility can significantly improve overall well-being.',
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Rotator Cuff Repair is a viable solution for those suffering from shoulder pain and limited mobility due to rotator cuff issues. If you’re considering this procedure or seeking treatment for your condition, Aapkacare’s experienced healthcare providers are here to guide you through every step. Don’t let shoulder pain hold you back – explore your options and regain your shoulder health today.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Why get arthroscopic rotator cuff repair at Aapka Care?',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Aapka Care is a leading arthroscopic surgery provider in Pune for rotator cuff repair. Our patient’s care and comfort are our biggest priority, and to ensure maximum care and comfort for all patients, we provide patient-care facilities like: ',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'Treatment by expert orthopedic surgeons: We are associated with the best rotator cuff surgeons in Pune who have ample experience in providing complication-free treatment for rotator cuff repair.',
                            ),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'Dedicated care coordinator: We assign a dedicated care coordinator to each patient who is in charge of documentation and admission to the hospital, ensuring that all patients have a pleasant treatment experience.',
                            ),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'Insurance assistance: We work with all major insurance companies and can assist all patients with insurance assistance, including documentation and claim recovery. No-cost EMI: If patients are unable to pay for treatment, we provide financial assistance in the form of no-cost EMI payment plans.',
                            ),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'Free cab and food service: On the day of surgery, we give free cab and meal service to all patients and their attendants.',
                            ),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'Free follow-up: We provide free follow-up to all patients within the first week after surgery to ensure proper recovery.',
                            ),
                            CustomRichText(
                              boldSize: 18,
                              regularSize: 18,
                              boldText: '• ',
                              regularText: 'COVID-19 safety criteria are strict: To protect our patients from the COVID virus, we adhere to strict hygiene standards, which include the use of PPE kits, masks, sanitisers, and other measures.',
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
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
