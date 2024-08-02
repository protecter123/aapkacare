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

class Fissure extends StatefulWidget {
  const Fissure({super.key});

  @override
  State<Fissure> createState() => _FissureState();
}

class _FissureState extends State<Fissure> {
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
                                  'Affordable Fissure Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Mole removal surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: 'Laser Treatment'),
                                    circleCheck(text: '30 Min Procedure'),
                                    circleCheck(text: 'No Cost EMI'),
                                    circleCheck(text: 'Complete Insurance Support'),
                                    circleCheck(text: 'Minimal Pain'),
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

                  //
                  LeftRightData(
                    rightImage: 'assets/f/7.png',
                    heading: 'What is an Anal Fissure?',
                    description: 'Fissures are painful, often distressing conditions that can significantly impact one’s quality of life. This article discusses fissure treatment options, signs to look for, types of fissure surgery, and the benefits of laser surgery. If you’re seeking relief from this condition, you’ve come to the right place.',
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
                          textName: "Identify the Signs of Anal Fissure",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        20.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/f/20.png", headingName: "Pain during bowel movements", detailName: "A sharp, stabbing pain while passing stool is a common symptom of an anal fissure."),
                            ReasonBox(image: "assets/f/21.png", headingName: "Bright red blood in stool or on toilet paper", detailName: "Fissures can cause bleeding during and after bowel movements."),
                            ReasonBox(image: "assets/f/14.png", headingName: "Itching and burning", detailName: "The affected area may feel itchy and uncomfortable."),
                            ReasonBox(image: "assets/f/19.png", headingName: "Feeling a lump or skin tag", detailName: "Sometimes, a small lump or skin tag may develop near the anal fissure."),
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
                          textName: "Understand the causes of Anal Fissure",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Here are some of the common causes of anal fissures",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/f/17.png", headingName: "Hard or Large Stools", detailName: " One of the most common causes of anal fissures is passing hard or large stools. This can stretch the anal canal and lead to tears in the delicate anal tissue."),
                            CausesBox(image: "assets/f/16.png", headingName: "Straining During Bowel Movements", detailName: "Excessive straining during bowel movements, often due to constipation, can increase pressure in the rectum and lead to fissures."),
                            CausesBox(image: "assets/f/15.png", headingName: "Chronic Diarrhea", detailName: "Frequent, watery bowel movements can irritate the anal area and make it more susceptible to fissures."),
                            CausesBox(image: "assets/f/18.png", headingName: "Anal Trauma", detailName: "Physical trauma to the anal area, such as from a foreign object, rough wiping, or anal intercourse, can cause fissures."),
                            CausesBox(image: "assets/f/13.png", headingName: "Inflammatory Bowel Disease (IBD)", detailName: "Conditions like Crohn’s disease and ulcerative colitis, which are forms of IBD, can lead to chronic inflammation and damage to the anal lining, increasing the risk of fissures."),
                            CausesBox(image: "assets/f/13.png", headingName: "Anal Conditions", detailName: "Certain conditions like hemorrhoids, anal polyps, or tumors can pressure the anal lining and increase the risk of fissures."),
                            CausesBox(image: "assets/f/18.png", headingName: "Spasms of the Anal Sphincter", detailName: "Abnormal or excessive spasms of the anal sphincter muscle can cause fissures or worsen existing cracks."),
                            CausesBox(image: "assets/f/13.png", headingName: "Childbirth", detailName: " In some cases, women may develop anal fissures during childbirth due to the pressure and stretching of the anal canal."),
                            CausesBox(image: "assets/f/13.png", headingName: "Age", detailName: "As people age, the anal tissue can become less elastic and more prone to injury, increasing the likelihood of fissures."),
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

                  //
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LeftRightData(
                      rightImage: 'assets/what.jpg',
                      heading: 'When to Seek Treatment',
                      description: 'If you’re experiencing any of the signs mentioned above, seeking treatment promptly is crucial. Delaying treatment can lead to the fissure becoming chronic, which is harder to manage. At Aapkacare, we offer comprehensive care for cracks, ensuring comfort and well-being throughout treatment.',
                    ),
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
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Types of Fissure Surgery",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Several surgical options are available for fissure treatment. These include:',
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '1. Lateral Internal Sphincterotomy (LIS):',
                                        regularText: 'This procedure involves cutting a small portion of the anal sphincter muscle to reduce spasms and promote healing.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '2. Advancement Flap Surgery: ',
                                        regularText: 'A portion of healthy tissue covers the fissure, promoting healing and preventing recurrence.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '3. Laser Surgery: ',
                                        regularText: 'This minimally invasive procedure is becoming increasingly popular due to its benefits, which we’ll discuss in detail.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Benefits of Laser Fissure Surgery",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Laser surgery for fissures offers several advantages, including:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '1. Minimally Invasive:',
                                        regularText: 'Laser surgery is less invasive than traditional procedures, which can lead to faster recovery times and reduced postoperative discomfort.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '2. Reduced Bleeding: ',
                                        regularText: 'Laser technology seals blood vessels during surgery, minimizing bleeding.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '3. Faster Healing: ',
                                        regularText: 'The precision of laser surgery promotes quicker healing, allowing you to return to your regular activities sooner.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '4. Lower Risk of Infection:',
                                        regularText: 'The controlled use of laser energy reduces the risk of infection.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '5. Minimal Scarring:',
                                        regularText: ' Laser surgery leaves minimal scarring, ensuring comfort and aesthetic benefits.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "After Treatment",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "After fissure surgery, it’s essential to follow your doctor’s advice closely. This may include dietary changes, proper hygiene, and taking prescribed medications. The goal is to ensure that you heal fully and avoid the recurrence of fissures.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "How to Prevent Fissures",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Preventing fissures is essential for long-term health and well-being. Some preventive measures include:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '1. Fiber-rich Diet:',
                                        regularText: 'A diet high in fiber can promote smooth bowel movements, reducing the risk of fissures.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '2. Adequate Hydration:',
                                        regularText: ' Drinking enough water is crucial for softening stool.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '3. Proper Hygiene: ',
                                        regularText: ' Keeping the anal area clean and dry can help prevent fissures.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '4. Avoid Straining: ',
                                        regularText: 'Avoid excessive straining during bowel movements.',
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "In conclusion, if you’re experiencing the signs of a fissure, don’t hesitate to seek treatment. At Aapkacare, we offer various fissure options, including advanced and minimally invasive laser surgery, to ensure your comfort and a speedy recovery. By taking preventive measures and addressing the",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Fissure Pain Management",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Anal fissures may cause pain. The sharpest part of this discomfort will come when you pass stools, and it may continue for a while after that.",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      myText(
                                        textName: "Lidocaine creams and other topical painkillers can aid with localised pain, while ibuprofen and other anti-inflammatory painkillers can help with more widespread pain symptoms.",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      myText(
                                        textName: "The anus muscles may relax and recover faster if you take warm showers frequently. Some pain symptoms may be lessened as a result.",
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
                            'assets/f/22.jpg',
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
                          'Well-experienced and highly qualified doctors to provide an accurate diagnosis and answer all your queries.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          leftImage: 'assets/healthcare.jpg',
                          heading: '',
                          description: 'To consult our skilled surgeons for any problems or to undergo Fissure surgery, visit the nearest Fissure clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Fissure surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for Fissure are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Fissure procedure in Pune.',
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
                    heading: 'Are you worried about the cost of Fissure treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Fissure in Pune. Even so, the exact cost is hard to pinpoint since your Fissure  surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
