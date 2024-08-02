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

class ACL extends StatefulWidget {
  const ACL({super.key});

  @override
  State<ACL> createState() => _ACLState();
}

class _ACLState extends State<ACL> {
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
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
                                  'Affordable ACL Tear Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  ACL tear surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of ACL tear surgery consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'An ACL tear, or anterior cruciate ligament tear, is a common sports injury that can significantly impact an individual’s life. Understanding the signs, treatment options, and benefits of surgery is crucial for those who have experienced this injury. Aapkacare is here to provide comprehensive information on ACL tears and guide you through the treatment process.',
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
                    height: 30,
                  ),

                  // signs
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Signs of an ACL Tear",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/mole/1.png", headingName: "Pain and Swelling", detailName: "One of the most common signs of an ACL tear is sudden and severe pain in the knee, accompanied by noticeable swelling. This can make walking and bearing weight on the affected leg extremely painful."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Instability", detailName: "Many individuals with an ACL tear report a feeling of instability in the knee as if it might “give way.” This instability can affect daily activities and physical performance."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Popping Sound", detailName: "Some people hear or feel a distinct popping sound at the time of injury, often an indicator of an ACL tear."),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 120 * s.customWidth),
                    // color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myText(
                          textName: "Causes of ACL tear",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        myText(
                          textName: "Some of the primary reasons include:",
                          size: 18,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "These are the most typical causes of muscle weaknesses that lead to hernia:",
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 50 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p5.jpg", headingName: "Sports Injuries", detailName: "Many ACL tears occur during high-impact sports and activities, such as soccer, basketball, football, skiing, and gymnastics. These sports involve rapid changes in direction, sudden stops, or pivoting motions, which can put immense stress on the ACL."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p3.jpg", headingName: "Trauma or Impact", detailName: "A direct blow or trauma to the knee, such as a car accident or a fall, can lead to an ACL tear. The ligament can be stretched or torn due to the force exerted on the knee joint."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p8.jpg", headingName: "Sudden Stops and Pivots", detailName: "Abrupt stops and changes in direction during physical activities can strain the ACL. This is common in basketball and tennis, where players frequently change direction."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p6.jpg", headingName: "Landing Incorrectly", detailName: " Athletes who land awkwardly from a jump or fall are at an increased risk of tearing their ACL. Poor landing technique can place excessive strain on the ligament."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p10.jpg", headingName: "Overextension", detailName: "Hyperextension of the knee joint, where the lower leg is forced backward beyond its normal range of motion, can lead to ACL tears."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p9.jpg", headingName: "Gender", detailName: "Women are more prone to ACL tears than men. This increased risk may be due to differences in musculature, biomechanics, and hormonal factors."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p6.jpg", headingName: "Muscle Imbalances", detailName: "Weakness or imbalances in the muscles that support the knee can increase the risk of ACL injuries. When these muscles are not adequately developed, they may not stabilize the joint sufficiently."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p10.jpg", headingName: "Previous ACL Tears", detailName: "Individuals who have previously torn their ACL are at a higher risk of re-injury, as the ligament may not be as strong or stable as before."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p9.jpg", headingName: "Genetics", detailName: "Evidence suggests that genetics may play a role in ACL tears. Some individuals may have genetic factors that make their ligaments more prone to injury."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p6.jpg", headingName: "Environmental Conditions", detailName: " Slippery or uneven playing surfaces can increase the likelihood of ACL injuries, as they can lead to uncontrolled movements and awkward landings."),
                            ErrorBox(width: 300, start: true, image: "assets/hernia/p9.jpg", headingName: "Fatigue and Overuse", detailName: "Tired muscles and overuse can reduce an individual’s ability to control their movements, making them more susceptible to ACL injuries."),
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

                  // Eyes
                  LeftRightData(
                    rightImage: 'assets/acd/2.png',
                    heading: 'What Is A ACL Tear?',
                    description: 'A tear in the anterior cruciate ligament is known as ACL tear. It is one of the major ligaments in the knee. Athletes and women who wear high heels for long hours are likely to suffer from an ACL tear often. ACL tear is commonly witnessed in players related to soccer, football, cricket, basketball etc where sudden jumping, landing and other such body movements are required. The surgery to reconstruct a torn or injured ACL is known as ACL Reconstruction.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Prevention
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          height: s.width < 720 ? 200 : 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/what.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Types of ACL Surgery',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Arthroscopic ACL Reconstruction',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'This minimally invasive surgery involves using a tiny camera and small incisions to replace the torn ACL with a graft from another part of your body or a donor.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Open Surgery',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Open surgery may be required in rare cases where a larger incision is made to repair the damaged ACL.',
                                style: TextStyle(fontSize: 18),
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

                  // Prevention
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'When to Treat an ACL Tear',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'It’s essential to address an ACL tear promptly to prevent further damage. The treatment options may vary depending on the severity and your activity level. Aapkacare recommends seeking medical attention if you suspect an ACL tear, as the healthcare professional will assess your injury and recommend an appropriate course of action.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Treatment Options',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Non-Surgical Treatment:  ',
                                regularText: 'Sometimes, a minor ACL tear can be managed without surgery. Physical therapy and rehabilitation exercises can help regain strength and stability in the knee over time.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Surgical Treatment: ',
                                regularText: 'Surgical intervention may be necessary for more severe ACL tears or individuals with high physical demands. Different types of surgery, such as arthroscopic ACL reconstruction, aim to repair the torn ligament.',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          height: s.width < 720 ? 200 : 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/appendicitis/woman.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Faqs
                  Container(
                    width: double.infinity,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/acd/5.jpg',
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
                          ),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myText(
                                textName: 'Overview',
                                size: 26,
                                fontWeight: FontWeight.bold,
                              ),
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "ACL Reconstruction Recovery",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Surgery healing takes 4 to 8 weeks.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Full recovery usually takes 4 to 9 months",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Swelling after ACL Reconstruction",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Swelling typically persists for 4 to 6 weeks.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Elevate your leg and apply ice packs to the knee, for 20-30 minutes every 2 hours.",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Most common choices of graft for ACL reconstruction",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Patellar tendon autograft",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Patellar tendon allograft",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Hamstring autograft",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Quadriceps tendon autograft",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Return to sports after ACL Reconstruction",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Athletes can return to pivoting sports after 4 to 8 weeks",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Athletes can return to regular sports after about 8 months. Make sure to take your orthopedic surgeon’s approval before returning to sports.",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
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
                    rightImage: 'assets/acd/3.jpg',
                    heading: 'ACL Tear Treatment',
                    description: 'During the physical examination, the doctor will check the swelling in the knee. The doctor may also ask you to change positions of the knee to check if the knee is functioning properly. The diagnosis, in most cases, can be done on the basis of the physical test alone, but if the injury looks severe, the doctor may ask you to take a few more tests such as – X-rays and MRI.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Eyes
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LeftRightData(
                      leftImage: 'assets/acd/4.jpg',
                      heading: 'ACL Tear Surgery',
                      description: 'Surgical intervention may be necessary for more severe ACL tears or individuals with high physical demands. Different types of surgery, such as arthroscopic ACL reconstruction, aim to repair the torn ligament.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Prevention
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    // color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Undergo less invasive and successful ACL Reconstruction Surgery In Pune',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Tears in the ACL or anterior cruciate ligament because of an injury of the knee joint is one of the most common types of injuries of the knee. ACL or the anterior cruciate ligament is one of the major ligaments of the knee joint and is responsible for the stability of the joint. If an injury is sustained, the ligament does not heal by itself. This implies that in case of ACL tear or injury, an orthopedic must be consulted to immediately know about treatment options.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'If the injury sustained by the ACL is of Grade 1, it can be treated with non-surgical methods effectively. But if Grade 2 or Grade 3 injuries are sustained, your doctor may suggest ACL Reconstruction Surgery in Pune. With its certified, trained and experienced team of surgeons and a compassionate and caring environment, Aapka Care is one of the best choices for undergoing ACL Reconstruction Surgery. The surgeons at Aapka Care use the latest technologies and high-end equipment for your reconstruction surgery, and the follow-up appointments and rehabilitation program will ensure that you are on the right track to recovery.',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: s.width < 1024 ? s.width : 500,
                            height: s.width < 720 ? 200 : 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/what.jpg',
                                fit: BoxFit.fill,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    color: Colors.blue[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How is an ACL tear treated?',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'A severe injury to the knee can result in an ACL tear. You would need a proper diagnosis after scans and physical examination to ensure that your injury is an ACL tear. Once a proper diagnosis is made, a comprehensive treatment plan can be drawn based on the following factors.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The severity and extent of the injury',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Age and skeletal development of the patient.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Type of lifestyle and activity routine of the patient.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The grading of ACL injuries is based on the extent of damage to the anterior cruciate ligament. The injuries are divided into three categories as follows.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Grade 1: A light stretch in the ligament with mild damage is a Grade 1 injury. No instability of the knee is caused.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Grade 2: Grade 2 injuries involve a strong stretch in the ACL which can make it lose. This is known as a partial tear of the anterior cruciate ligament and causes pain, inflammation, and instability.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Grade 3: A complete ligament tear occurs due to overstretching of the joint. The ligament splits into two and makes the knee joint highly unstable, inflamed, and immobile.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'If the ACL tear is mild and is caused by just a light stretch of the knee, surgical treatments will probably not be required. Nonsurgical treatment alternatives like the following can prove to be effective.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Limiting and modifying activities.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Using a brace, cast, or splint.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Rehabilitation and physiotherapy programs.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'However, in case of Grade 2 or Grade 3 injuries, an ACL Reconstruction surgery can be suggested by your orthopedic. The surgery aims to restructure the torn ligament by using a piece of tendon from another part of the knee, or a donor.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Prevention
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    // color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                            width: s.width < 1024 ? s.width : 500,
                            height: s.width < 720 ? 200 : 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/acd/1.png',
                                fit: BoxFit.fill,
                              ),
                            )),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Benefits of undergoing arthroscopic ACL tear surgery',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Stability:  ',
                                regularText: 'ACL surgery helps restore stability to the knee, allowing individuals to return to their desired level of physical activity and sports.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  Reduced Risk of Complications: ',
                                regularText: 'Surgical intervention can minimize the risk of long-term complications such as meniscus tears and cartilage damage. ',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Improved Quality of Life: ',
                                regularText: 'After successful surgery and rehabilitation, individuals can regain confidence and live a more active and pain-free life.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Aapkacare ',
                                regularText: 'is dedicated to helping you understand ACL tears and make informed decisions about your treatment options. If you suspect an ACL tear or have questions about treatment, don’t hesitate to contact our experts for guidance and support. Your health is our priority, and we’re here to assist you every step of the way.',
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
