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

class Fistula extends StatefulWidget {
  const Fistula({super.key});

  @override
  State<Fistula> createState() => _FistulaState();
}

class _FistulaState extends State<Fistula> {
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
                                  'Laser Surgery for Fistula in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Laser Fistula surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to Aapkacare’s comprehensive guide on fistula surgery. In this informative article, we will explore everything you need to know about fistulas, including their signs, various treatment options, types of surgery available, the benefits of laser surgery, and preventive measures to maintain your health.',
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
                                    circleCheck(text: 'Complete Insurance Support'),
                                    circleCheck(text: 'No Cost EMI'),
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
                    height: 30,
                  ),

                  LeftRightData(
                    rightImage: 'assets/piles/8.png',
                    heading: 'What is an Anal Fistula?',
                    description: 'A fistula is an abnormal connection or passageway between two organs or vessels within the body. In fistula surgery, we primarily focus on anorectal fistulas, which connect the anal canal to the skin near the anus.',
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
                          textName: "Identify the Signs of Fistula",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        10.heightBox,
                        myText(
                          textName: "Common signs of anorectal fistulas include",
                          size: 18,
                        ),
                        20.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/f/1.png", headingName: "Pain and Discomfort", detailName: "Piles can cause pain, itching, and discomfort around the anal area. Some individuals may experience sharp, stabbing pain during bowel movements."),
                            ReasonBox(image: "assets/f/10.jpg", headingName: "Bleeding", detailName: "One of the most common symptoms is rectal bleeding, often noticed as bright red blood on toilet paper or in the toilet bowl."),
                            ReasonBox(image: "assets/f/11.jpg", headingName: "Swelling", detailName: "Piles can lead to lumps or swelling in the anal area."),
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
                          textName: "Understand the Causes of Fistula",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "A majority of anal fistulas occur due to an infection that starts in an anal gland. This infection forms an abscess that either drains on its own or is drained surgically through the skin next to the anus",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/f/1.png", headingName: "", detailName: "Previously drained anal abscess"),
                            CausesBox(image: "assets/f/2.png", headingName: "", detailName: "Trauma or constant pressure to the anal area"),
                            CausesBox(image: "assets/f/4.png", headingName: "", detailName: "Crohn’s disease or other inflammatory bowel diseases"),
                            CausesBox(image: "assets/f/3.png", headingName: "", detailName: "Infections of the anal area from STDs"),
                            CausesBox(image: "assets/f/6.png", headingName: "", detailName: "Surgery or radiation for treatment of anal cancer"),
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
                                textName: "Different kinds of Fistula",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Anal",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'There could be three different types of fistula development around the anus.',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'An anorectal fistula is the medical term for a fistula that develops between the anal canal and the skin around the anal entrance.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'A rectovaginal or anovaginal fistula refers to a hole that forms between the rectum or anus and the vagina.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'A fistula between the vagina and colon can develop occasionally.The term for this is colovaginal fistula.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Intestines",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "An enteroenteric fistula occurs when a connection develops between two segments of the intestine.Sometimes a fistula can develop between the skin and the small intestine or the skin and the colon.The following are some signs of intestinal fistulas:",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Either abdominal pain or discomfort between the genitals and the anus.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Urinary tract infections that recur.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Severe diarrhoea or gas.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Stomach, bladder, or intestinal gas.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Loss of weight.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Urinary tract",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A fistula between the uterus and the bladder is also possible.The urethra and the vagina may occasionally form a hole, as well as urinary bladder and the vagina.The following are signs of urinary tract fistula:",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Discomfort while urinating.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Frequent urination.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Hazy and odorous urine.',
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
                            'assets/f/8.png',
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
                                textName: "When to Treat a Fistula",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Types of Fistula Surgery",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "There are several surgical options to treat fistulas",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Seton Placement: ',
                                        regularText: 'It involves placing a suture (seton) through the fistula to help it drain and heal gradually.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: ' Fistulotomy: ',
                                        regularText: 'A procedure involves cutting the fistula open to allow it to heal from the inside out.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Advancement Flap Repair: ',
                                        regularText: 'A surgical technique where healthy tissue covers the fistula, promoting healing. ',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Laser Surgery: ',
                                        regularText: 'A modern, minimally invasive approach that offers numerous benefits is discussed in the next.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Importance of Timely Treatment",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Prompt treatment of a fistula is crucial to prevent complications and alleviate discomfort. Delaying treatment may lead to chronic infections, increased pain, and the risk of abscess formation.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "Risks of Delayed Treatment",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "If left untreated, fistulas can worsen over time and result in severe consequences such as incontinence and the need for more complex surgeries.",
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
                            'assets/f/12.jpg',
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
                                'Preventing Fistulas',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Maintaining Good Hygiene: ',
                                regularText: 'Regular cleaning of the anal area is essential to prevent infections that can lead to fistulas.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Dietary and Lifestyle Factors: ',
                                regularText: 'A healthy diet and lifestyle can reduce the risk of conditions that may cause fistulas, such as Crohn’s disease or diverticulitis.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Prompt Treatment of Infections: ',
                                regularText: 'Infections in the anal area should be treated promptly to prevent them from progressing to fistulas.',
                              ),
                              Text(
                                'Knowledge is your greatest ally whether you are considering treatment options or seeking to prevent fistulas. For personalized advice and treatment, consult a healthcare professional or visit Aapkacare for expert guidance and support.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Image.asset('assets/w2.jpg'),
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

                  // cost
                  LeftRightData(
                    rightImage: 'assets/patient.jpg',
                    heading: 'Are you worried about the cost of Fistula treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Fistula in Pune. Even so, the exact cost is hard to pinpoint since your Fistula surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
