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

class Mole extends StatefulWidget {
  const Mole({super.key});

  @override
  State<Mole> createState() => _MoleState();
}

class _MoleState extends State<Mole> {
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
                                  'Affordable Mole Removal Surgery In Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Mole removal surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Moles are common skin growths that vary in size, shape, and color. While most moles are harmless, some may require removal for cosmetic reasons or due to potential health concerns. Mole removal surgery is a standard and effective procedure to address these issues. In this article, we will discuss the signs that indicate the need for mole removal surgery, the types of moles, the treatment process, and what to expect after the procedure.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: '30 Min Procedure'),
                                    circleCheck(text: 'Laser Treatment'),
                                    circleCheck(text: 'Minimal cuts'),
                                    circleCheck(text: 'No cost EMI'),
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

                  // what
                  LeftRightData(
                    rightImage: 'assets/mole/5.png',
                    heading: 'What is a Mole?',
                    description: 'The clusters of pigment-forming cells known as moles or nevi are harmless, non-contagious, and non-cancerous growths that can arise anywhere on your face, body, or skin. Moles occur in a variety of colours, including brown, black. Moles can be round, oval, or even smaller. Moles are caused by the body’s overactive melanocytes, which create excessive melanin. Contact Aapkacare Health and talk to an expert for the best course of action for affordable mole removal surgery in Pune.',
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
                          textName: "Signs That May Require Mole Removal Surgery",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/mole/1.png", headingName: "Change in Appearance", detailName: "If you notice a mole changing in size, shape, color, or texture, it could be a sign of a potentially dangerous mole."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Pain or Itching", detailName: "Moles that cause discomfort or itchiness may need medical attention."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Multiple Colors", detailName: "Moles with multiple colors within them might be a concern."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Pain or Itching", detailName: "Moles that cause discomfort or itchiness may need medical attention."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Bleeding or Crusting", detailName: "Moles that bleed or crust over without an apparent reason should be examined by a dermatologist."),
                            ReasonBox(image: "assets/mole/1.png", headingName: "Irregular Borders", detailName: "Moles with uneven or irregular borders may indicate a problem."),
                            ReasonBox(image: "assets/mole/7.png", headingName: "Multiple Colors", detailName: "Moles with multiple colors within them might be a concern."),
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
                                textName: "Reasons You May Need Mole Removal",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Congenital Moles",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Moles present at birth or shortly after are known as congenital moles.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Acquired Moles",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "These are moles that develop over time and are the most common type",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Atypical Moles (Dysplastic Nevi)",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "These moles have irregular features and are more likely to become cancerous.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Junctional, Intradermal, or Compound Moles",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "These terms describe where the mole cells are located in the skin layers.",
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
                            'assets/mole/4.png',
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

                  // what
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LeftRightData(
                      leftImage: 'assets/what.jpg',
                      heading: 'Treatment with Aapkacare',
                      description: 'At Aapkacare, we provide comprehensive mole removal surgery services. Our experienced dermatologists will thoroughly evaluate and offer the most suitable treatment options tailored to your needs. We ensure a safe and efficient mole removal procedure.',
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
                              myQuestion(
                                onTap: () {
                                  toggle('Question8');
                                },
                                headingName: "Types of Moles",
                              ),
                              if (questionStates['Question8']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "There are various types of moles, including:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Congenital Moles:  ',
                                        regularText: 'Moles present at birth or shortly after are known as congenital moles.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Acquired Moles:  ',
                                        regularText: 'These are moles that develop over time and are the most common type.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Atypical Moles (Dysplastic Nevi):  ',
                                        regularText: 'These moles have irregular features and are more likely to become cancerous.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '•  Junctional, Intradermal, or Compound Moles:  ',
                                        regularText: 'These terms describe where the mole cells are located in the skin layers.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question9');
                                },
                                headingName: "Surgical Excision",
                              ),
                              if (questionStates['Question9']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Excision, also known as open mole removal surgery, is the conventional method used for mole removal.Your doctor will first clean and numb the area before using a scalpel to cut the mole away from the surrounding skin.Depending on the mole ‘s nature, a margin of healthy skin will be removed to make sure all of the abnormal cells are gone.After grasping the portion with forceps, they move the mole out of the way.Bleeding is common during open mole removal surgery.Your doctor may cauterise(burn) the region or apply pressure to stop the bleeding before stitching the wounds securely next to each other.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question10');
                                },
                                headingName: "Mole Removal Surgery - When to Treat",
                              ),
                              if (questionStates['Question10']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Not all moles require removal, but you must consult a dermatologist if you observe any of the signs mentioned earlier. Your dermatologist will assess the mole and recommend removal if it poses a risk or if you desire it for cosmetic reasons.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question11');
                                },
                                headingName: "Advantages of Laser Mole Removal",
                              ),
                              if (questionStates['Question11']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Permanent Results: ',
                                        regularText: 'Prevents the spread of cancerous and precancerous cells',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Clear skin: ',
                                        regularText: 'Skin irritation is less likely to occur with smooth, clear skin.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Fast recovery: ',
                                        regularText: ' Laser mole removal heals in a shorter period of time.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Low probabilities of infection:',
                                        regularText: 'There is a minimal chance of infection.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Non-invasive method:',
                                        regularText: ' This mole removal procedure does not require inserting an instrument through the skin or into a body opening.',
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
                            'assets/mole/6.png',
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

                  //
                  Container(
                    width: double.infinity,
                    // color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'After Mole Removal Treatment',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'After undergoing mole removal surgery, you can expect the following',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Recovery Period: ',
                          regularText: 'Depending on the size and type of mole, recovery can take a few days to a few weeks.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Pain and Discomfort: ',
                          regularText: 'Mild pain and discomfort may be experienced but can be managed with over-the-counter pain relievers. ',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Scarring: ',
                          regularText: 'There may be minimal scarring, but it typically fades over time.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Follow-Up Care: ',
                          regularText: 'You must follow your dermatologist’s post-operative care instructions to ensure proper healing.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Skin Protection: ',
                          regularText: ' Protect the treated area from the sun to prevent darkening or complications.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Mole removal surgery is a safe and effective way to address concerning or unwanted moles. If you notice any signs of mole irregularity or are considering mole removal for cosmetic reasons, consult with a dermatologist at Aapkacare for a professional evaluation and personalized treatment plan. Your skin’s health and appearance are our top priorities.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
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
                          description: 'To consult our skilled surgeons for any problems or to undergo Mole Removal surgery, visit the nearest Mole Removal clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Mole Removal surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for Mole Removal are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Mole Removal procedure in Pune.',
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
                    heading: 'Worried about the cost of mole removal treatment in Pune?',
                    description: 'Aapkacare Health finds you the most affordable prices for your mole removal in Pune. Even so, the exact cost is hard to pinpoint since your mole removal surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
