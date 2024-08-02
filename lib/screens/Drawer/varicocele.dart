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

class Varicocele extends StatefulWidget {
  const Varicocele({super.key});

  @override
  State<Varicocele> createState() => _VaricoceleState();
}

class _VaricoceleState extends State<Varicocele> {
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
                                  'Affordable Varicocele Treatment in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Varicocele surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons for all your healthcare  needs.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: '60 Min Procedure'),
                                    circleCheck(text: 'Keyhole Surgery'),
                                    circleCheck(text: 'Complete Insurance Support'),
                                    circleCheck(text: 'No Cost EMI'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
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

                  LeftRightData(
                    rightImage: 'assets/v/8.png',
                    heading: 'What is Varicocele?',
                    description: 'Varicocele is characterized by the enlargement of veins within the scrotum, similar to varicose veins in the legs. While many varicoceles do not cause any symptoms, they can be associated with male infertility and discomfort. Effective treatment options are available to manage this condition, with surgeries performed by skilled doctors at Aapkacare.',
                  ),

                  // signs
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 50 : 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myText(
                          textName: "Identify the Signs of Varicocele",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        10.heightBox,
                        myText(
                          textName: "Varicoceles are often discovered during a routine physical exam or fertility evaluation. However, some individuals may experience the following signs and symptoms:",
                          size: 18,
                        ),
                        20.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/v/2.png", headingName: "Dull Ache", detailName: "A persistent, dull pain or discomfort in the scrotum, which may worsen with physical activity or extended periods of standing."),
                            ReasonBox(image: "assets/v/5.png", headingName: "Infertility", detailName: "Varicoceles can interfere with sperm production and quality, potentially leading to male infertility."),
                            ReasonBox(image: "assets/v/1.png", headingName: "Testicular Atrophy", detailName: " In some cases, untreated varicoceles can result in the shrinkage of the affected testicle."),
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
                          textName: "Understand the Causes of Varicocele",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "A varicocele is an enlargement of veins inside the scrotum. The exact cause of varicoceles is not fully understood, but it is believed to occur when the valves inside the spermatic veins are not functioning properly. This can lead to a backup of blood in the veins, causing them to become enlarged and resulting in varicocele. Other potential causes of varicoceles include:",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/v/3.png", headingName: "", detailName: "Genetics"),
                            CausesBox(image: "assets/v/6.png", headingName: "", detailName: "Anatomical abnormalities"),
                            CausesBox(image: "assets/v/6.png", headingName: "", detailName: "Increased pressure in the abdomen"),
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
                                textName: "Different Types Of Varicoceles",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Grade 1 Varicocele:",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'A grade 1 varicocele is the mildest form of varicocele and is often not visible or palpable.It is detected only through imaging studies, such as ultrasound.While grade 1 varicocele may not require treatment, it is important to monitor the condition as it can progress over time.If it begins to cause pain or affect fertility, treatment options can be discussed with a healthcare provider.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Grade 2 Varicocele:",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A grade 2 varicocele is a type of varicocele that is more noticeable and can be felt during a physical exam.The veins in the scrotum are larger and more twisted than in grade 1 varicocele, and may cause some discomfort or pain.While it may not always require treatment, it can affect fertility in some cases.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Grade 3 Varicocele: ",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A grade 3 varicocele is the most severe type of varicocele, characterised by large, twisted veins that are easily visible and palpable.It can cause significant pain and discomfort, and affect fertility.The treatment options may include surgical procedures or minimally invasive techniques like embolization to redirect blood flow away from the affected veins.",
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
                            'assets/v/4.png',
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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: 500,
                          child: Image.asset(
                            'assets/what.jpg',
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
                                'Expert Doctors',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'At Aapkacare, we have a network of highly skilled doctors who specialize in treating varicocele. Our doctors are dedicated to providing personalized care tailored to your specific needs. They will work with you to determine the most appropriate treatment plan, which may include varicocele surgeries.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Contact Us Today',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'If you’re experiencing discomfort, pain, or infertility due to varicocele, don’t hesitate to seek treatment. Contact Aapkacare to connect with a knowledgeable doctor who can provide you with the right varicocele treatment plan, including varicocele surgeries. Your health and well-being are our top priorities.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Please schedule an appointment today with our expert doctors and take the first step toward a more comfortable and healthier future.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
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
                              SizedBox(height: 10),
                              Text(
                                'After Treatment',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Following varicocele treatment at Aapkacare, patients can expect improvements in their symptoms and, for those experiencing infertility, an enhanced potential for fertility. Recovery times may vary depending on the type of surgery, but our dedicated medical team will provide detailed post-operative care instructions.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Attending scheduled follow-up appointments is essential to ensure that the treatment has been effective and to monitor your progress.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'If you or someone you know is experiencing signs or symptoms of varicocele, don’t hesitate to contact Aapkacare to schedule a consultation with our skilled doctors. We are committed to providing personalized care and effective varicocele treatment options to help you regain your comfort and well-being.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Feel free to modify this content for your website, adding specific details about your medical practice and any additional services or information you’d like to provide.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: 500,
                          child: Image.asset(
                            'assets/w2.jpg',
                            fit: BoxFit.fill,
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
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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
                                textName: "Surgeries for Varicocele Treatment",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              10.heightBox,
                              myText(
                                textName: "At Aapkacare, our experienced doctors offer surgical solutions to treat varicoceles. The primary surgical options for varicocele treatment include:",
                                size: 16,
                              ),
                              20.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Varicocelectomy",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "This is the most common surgical procedure for varicocele treatment. It involves making a small incision in the groin or abdomen and using a microscope or other magnifying tools to locate and ligate the enlarged veins. This procedure redirects blood flow from the varicocele, reducing its size and symptoms.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Laparoscopic Varicocelectomy",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "In this minimally invasive procedure, tiny incisions are made to access and ligate the affected veins, minimizing scarring and reducing recovery time.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "Percutaneous Embolization",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "This non-surgical approach involves using a catheter to block off the varicocele by inserting a coil or other embolization materials.",
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
                            'assets/v/7.jpg',
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

                  // About Us
                  Container(
                    width: double.infinity,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
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
                          'Well-experienced and highly qualified doctors to provide an accurate diagnosis and answer all your queries.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          leftImage: 'assets/healthcare.jpg',
                          heading: '',
                          description: 'To consult our skilled surgeons for any problems or to undergo fistula surgery, choose from best hospitals in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top proctologists in Pune. The Pune Aapkacare Health multi-speciality clinics for Fistula treatment are well-equipped, sanitised, and COVID-safe. Book an appointment for the most advanced  fistula treatment in Pune.',
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

                  // treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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
                                'Why Choose Aapkacare for Varicocele Treatment?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Expertise: ',
                                regularText: 'Our network of doctors is highly experienced in varicocele diagnosis and treatment.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Personalized Care: ',
                                regularText: ' We understand that every patient is different, and we provide individualized treatment plans.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Advanced Surgeries: ',
                                regularText: ' Aapkacare offers state-of-the-art surgical options, ensuring the best possible outcome.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Comprehensive Support: ',
                                regularText: 'We support you at every step of your varicocele treatment journey.',
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: 500,
                          child: Image.asset(
                            'assets/kidney/14.png',
                            fit: BoxFit.fill,
                          ),
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
                    heading: 'Are you worried about the cost of Varicocele treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Varicocele in Pune. Even so, the exact cost is hard to pinpoint since your Varicocele surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
