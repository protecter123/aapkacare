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

class Piles extends StatefulWidget {
  const Piles({super.key});

  @override
  State<Piles> createState() => _PilesState();
}

class _PilesState extends State<Piles> {
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
                                  'Affordable Piles Treatment in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Piles surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons',
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
                                    circleCheck(text: 'Free Pick Up & Drop'),
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

                  // signs
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    child: Column(
                      children: [
                        LeftRightData(
                          rightImage: 'assets/piles/8.png',
                          heading: 'What are Piles?',
                          description: 'Piles, medically known as hemorrhoids, are a common condition that affects millions of people worldwide. These swollen blood vessels in the rectum or anus can be a source of discomfort, but they are manageable and treatable. In this comprehensive guide, we’ll explore piles, including signs and symptoms, surgical and non-surgical treatment options, the importance of seeking expert doctors, and the role of Aapkacare. We’ll also discuss prevention strategies and when to seek treatment.',
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 50 : 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              myText(
                                textName: "Identify the Signs and Symptomsof Piles",
                                size: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              Wrap(
                                spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ReasonBox(image: "assets/hernia/p4.png", headingName: "Pain and Discomfort", detailName: "Piles can cause pain, itching, and discomfort around the anal area. Some individuals may experience sharp, stabbing pain during bowel movements."),
                                  ReasonBox(image: "assets/hernia/p7.png", headingName: "Bleeding", detailName: "One of the most common symptoms is rectal bleeding, often noticed as bright red blood on toilet paper or in the toilet bowl."),
                                  ReasonBox(image: "assets/hernia/p1.png", headingName: "Swelling", detailName: "Piles can lead to lumps or swelling in the anal area."),
                                  ReasonBox(image: "assets/hernia/p2.png", headingName: "Mucous Discharge", detailName: " In some cases, piles may cause the release of mucous from the anus."),
                                  ReasonBox(image: "assets/hernia/p2.png", headingName: "Difficulty in Passing Stools:", detailName: "Individuals with piles may find it challenging to pass stools, which can lead to further discomfort."),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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
                                textName: "When to Get Treatment",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              20.heightBox,
                              myText(
                                textName: "It’s essential to seek treatment when you experience persistent or severe symptoms. Timely intervention can prevent the condition from worsening. Don’t hesitate to consult a healthcare professional or proctologist when you notice rectal bleeding, persistent pain, or significant discomfort. ",
                                size: 18,
                              ),
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Prevention",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Preventing piles involves adopting a healthy lifestyle and dietary habits:',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Consume a high-fiber diet to promote regular and soft bowel movements. ',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Stay well-hydrated to avoid constipation. ',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Engage in regular physical activity to improve circulation.',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Avoid straining during bowel movements.',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Limit the use of laxatives and alcohol.',
                                      ),
                                      myText(
                                        size: 16,
                                        textName: '– Take breaks if you have a sedentary job to reduce pressure on the rectal area.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "After Treatment",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Surgical and Non-Surgical Options:",
                                        size: 16,
                                      ),
                                      myText(
                                        textName: "Treatment for piles can be either surgical or non-surgical, depending on the severity of the condition. Surgical treatments, like hemorrhoidectomy and rubber band ligation, are typically recommended for severe cases. Non-surgical treatments often involve dietary and lifestyle modifications, medications, or minimally invasive procedures.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Expert Doctors",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Choosing an experienced proctologist or colorectal surgeon is crucial for the success of your treatment. These specialists can evaluate your condition, discuss appropriate therapies, and provide guidance throughout your recovery.",
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
                            'assets/piles/9.png',
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

                  // Causes
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
                          textName: "Understand the Causes of Piles",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "There is a wide range of factors that cause piles, both internal and external. Here are some of them. The most common causes of piles include",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/piles/6.jpg", headingName: "", detailName: "Chronic constipation that involves a struggle to pass stool putting extra strain on the blood vessel walls which can lead to piles."),
                            CausesBox(image: "assets/piles/4.jpg", headingName: "", detailName: "Too much time spent sitting down, especially while using the restroom, might result in hemorrhoids."),
                            CausesBox(image: "assets/piles/2.jpg", headingName: "", detailName: "It could be genetic as piles is a condition that certain people are prone to based on their family genes."),
                            CausesBox(image: "assets/piles/3.jpg", headingName: "", detailName: "Consuming foods deficient in fibre may make piles more likely."),
                            CausesBox(image: "assets/piles/5.jpg", headingName: "", detailName: "Lifting heavy objects repeatedly can result in the development of piles"),
                            CausesBox(image: "assets/piles/1.jpg", headingName: "", detailName: "Anal sex can result in new hemorrhoids or make existing ones worse."),
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
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Types of surgery for piles in Pune",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Internal Hemorrhoids: ',
                                        regularText: ' These are located inside the rectum and are generally painless, but they can cause bleeding during bowel movements.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'External Hemorrhoids: ',
                                        regularText: 'These form under the skin around the anus and can be painful and itchy. Sometimes, a blood clot can form within an external hemorrhoid, causing severe pain.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Recommendations after piles surgery",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Patients may be released from the hospital a day or two after having surgery for piles or hemorrhoids, which is typically performed in a day surgery center. One to two weeks after piles surgery, you can resume your normal activities, but it’s advised that you avoid strenuous activities and avoid heavy lifting at that time. To prevent pain or bleeding while passing stools until the area around the anal sphincter heals, you may be advised to take stool softeners. Here are some recovery tips:",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Keep your stools soft so they pass easily since this will help you avoid piles the best.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Consume fibre-rich meals. Eat more whole grains, fruits, and veggies. By doing this, the stool will soften and thicken, avoiding straining that could lead to piles. To avoid issues with gas, progressively incorporate more fibre into your diet.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Drink lots of water. To keep stools soft, drink six to eight glasses of water daily in addition to other liquids and avoid alcohol.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Go for fibre supplements. The average person’s diet falls short of the 20 to 30 grams of fibre per day that are advised. Studies have demonstrated that over-the-counter fibre supplements like psyllium (Metamucil) or methylcellulose (Citrucel) reduce piles symptoms all around and reduce bleeding.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Take it easy. The lower rectum’s veins are under more strain when you are trying to pass a stool while squeezing and holding your breath.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Exercise. Staying active can help prevent constipation and ease the pressure on veins that might develop from prolonged standing or sitting. Exercise can also aid in weight loss, which may aid in the treatment of your piles.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Limit your sitting time. Too much time spent sitting, especially on the toilet, might put more strain on the anal veins.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Get the right medication. Your doctor might recommend over-the-counter lotions, ointments, and suppositories if the pain from your piles is only modest. Witch hazel, hydrocortisone, and lidocaine are some of the components in these medications that temporarily ease pain and irritation. Avoid using over-the-counter steroid cream for longer than a week unless your doctor specifically instructs you to do so.',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      myText(
                                        textName: "What possible complications can you expect following piles surgery?",
                                        size: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      myText(
                                        textName: "Patients heal well from the piles operation, and the surgery is rather common. However, a few uncommon issues might be as follows:",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Infection at the location of surgery.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Discomfortable stool-passing',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Affected organs, nerves, or nearby vessels may sustain damage.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Faecal incontinence as a result of sphincter muscle weakness.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Bleeding without control.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Recurrence',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "Expert Doctors",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Complications of untreated piles",
                                        size: 16,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'Piles can lead to anemia, which is a condition in which your body lacks enough healthy red blood cells to transport oxygen to your cells. Internal hemorrhoids may become strangulated(blood supply to the area gets cut), which can be extremely painful.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• ',
                                        regularText: 'A clot may occasionally develop in the hemorrhoid (thrombosed hemorrhoid). It is not harmful, although it can be very uncomfortable and sometimes needs to be lanced and drained.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question7');
                                },
                                headingName: "Piles treatment procedures",
                              ),
                              if (questionStates['Question7']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Your doctor might suggest one of the various minimally invasive piles procedures available if you have persistent bleeding or uncomfortable hemorrhoids. These procedures can normally be carried out with an anaesthetic in your hospital emergency room or another outpatient facility.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Rubber band ligation: To stop the circulation of internal hemorrhoids, the doctor wraps one or two thin rubber bands around the base of the growth. Within a week, hemorrhoid dries out and peels off. An annoying side effect of hemorrhoid banding is bleeding, which may start two to four days after the piles treatment but is rarely severe. Sometimes, more severe issues can appear.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Injection (sclerotherapy): Your doctor shrinks the hemorrhoid tissue by injecting a chemical solution into it. Although the injection is not painful, it might not be as effective as rubber band ligation.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Coagulation (infrared, laser): The use of heat, infrared light, or lasers is a coagulation technique. They induce internal hemorrhoids that are tiny and bleeding to stiffen and shrink.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question8');
                                },
                                headingName: "Categorisation of the piles",
                              ),
                              if (questionStates['Question8']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "The grade of the piles is the criteria for providing a particular surgery. The price rises if the condition is exceedingly severe and cannot be treated with minimally invasive piles surgery. Following is an explanation of the various severity grades of piles to help you better understand how much the cost depends on this factor:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Grade I: In grade I the symptoms or causes include only bleeding, and no prolapse.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Grade II: Grade II causes include prolapse but spontaneous reduction.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Grade III: Prolapsed but has to be pushed inside.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      myText(
                                        textName: "Grade IV: In grade IV it remains prolapsed.",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/piles/7.png',
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
                          description: 'To consult our skilled surgeons for any problems or to undergo Piles surgery, visit the nearest Piles clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Piles surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for Piles are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Piles procedure in Pune.',
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
                    heading: 'Are you worried about the cost of Piles treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Piles in Pune. Even so, the exact cost is hard to pinpoint since your Piles surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
