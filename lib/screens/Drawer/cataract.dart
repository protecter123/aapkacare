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

class Cataract extends StatefulWidget {
  const Cataract({super.key});

  @override
  State<Cataract> createState() => _CataractState();
}

class _CataractState extends State<Cataract> {
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
                  // Container(
                  //   width: s.width,
                  //   color: Colors.blue[50],
                  //   child: Center(
                  //     child: Container(
                  //       width: s.width,
                  //       color: Colors.transparent,
                  //       child: isMobile
                  //           ? Column(
                  //               children: [
                  //                 buildAmberContainer(),
                  //                 buildWhiteContainer(),
                  //               ],
                  //             )
                  //           : Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Expanded(child: buildAmberContainer()),
                  //                 buildWhiteContainer(),
                  //               ],
                  //             ),
                  //     ).px((s.width < 1270 ? 50 : 250) * s.customWidth),
                  //   ),
                  // ),
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
                                  'Affordable Cataract Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Reasonable and most affordable Cataract surgery in your city, Pune, by the best ophthalmologists. With Aapkacare Health, we will make it easy for you to attain the surgery with the best femtosecond laser-assisted cataract surgery (FLACS) to remove your cataract. We will provide medical advice, clinical support, and healthcare solutions.',
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
                                    circleCheck(text: 'Same Discharge'),
                                    circleCheck(text: 'No Cost EMI'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
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

                  // Eyes
                  LeftRightData(
                    rightImage: 'assets/cataracts/cataract.png',
                    heading: 'What is a Cataract ?',
                    description: 'Cataract is a medical condition that affects the eye’s lens due to the building up of proteins, making them cloudy and opaque. Our eye’s lens is a transparent disc that allows the light to pass through it and focus on the retina. When a cataract forms, it obstructs the passage of light, which leads to blurred and distorted vision. People with cataracts often find it difficult to see at night due to unclear vision.',
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
                          textName: "Reasons to Get LASIK Surgery",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/cataracts/Signs1.png", headingName: "Blurred Vision", detailName: "One of the early signs of cataracts is gradually blurring vision."),
                            10.widthBox,
                            ReasonBox(image: "assets/cataracts/eye2.png", headingName: "Increased Sensitivity to Glare", detailName: "Eyes become more sensitive towards bright lights including sunlight, car headlights, or indoor lighting."),
                            10.widthBox,
                            ReasonBox(image: "assets/cataracts/Signs3.png", headingName: "Difficulty Seeing at Night,", detailName: "Impairment of night vision. One might find it difficult to see clearly in low-light conditions, You can also experience halos around the lights."),
                            10.widthBox,
                            ReasonBox(image: "assets/cataracts/Signs4.png", headingName: "Faded Vision", detailName: "Colors may appear less vivid or faded."),
                            10.widthBox,
                            ReasonBox(image: "assets/cataracts/Signs5.png", headingName: "Doubled Vision", detailName: "Cataracts can cause double vision or multiple image formation in one eye."),
                            10.widthBox,
                            ReasonBox(image: "assets/cataracts/Signs5.png", headingName: "Poor Depth Perception", detailName: "Due to blurring vision, the depth perception ability of the eye is affected, making it difficult to judge distances."),
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
                          textName: "Understand the Causes of Cataract",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/cataracts/causes1.png", headingName: "Aging", detailName: "Aging is the most common cause of cataracts. The proteins in your eye’s lens can clump together as you age, causing cataracts."),
                            10.widthBox,
                            CausesBox(image: "assets/cataracts/causes2.png", headingName: "Ultraviolet (UV) Radiation", detailName: "Prolonged and excessive exposure to UV radiation from the sun."),
                            10.widthBox,
                            CausesBox(image: "assets/cataracts/causes3.png", headingName: "Uveitis", detailName: "Inflammation of the uvea (the eye’s middle layer) can increase the risk of cataracts."),
                            10.widthBox,
                            CausesBox(image: "assets/cataracts/causes4.png", headingName: "Smoking", detailName: "Smoking and exposure to smoke can increase the risk of cataracts."),
                            10.widthBox,
                            CausesBox(image: "assets/cataracts/causes5.png", headingName: "Diabetes", detailName: "People with diabetes have a higher risk of developing cataracts. This is due to changes in the eye’s lens because of increased sugar levels."),
                            10.widthBox,
                            CausesBox(image: "assets/cataracts/causes6.png", headingName: "Eye Injuries", detailName: "Injuries to the eyes can increase the risk of developing cataracts."),
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

                  // Explain
                  Questions(
                    image: 'assets/what.jpg',
                    heading: 'OUR EXPERTS EXPLAIN',
                    questions: [
                      'How',
                      'What',
                      'When'
                    ],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How do cataracts form?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'We have a natural lens inside our eyes. The lens bends the light that comes into the eyes and helps us see. Cataracts develop when ageing or injury changes the tissue that makes up the eye\'s lens. Proteins and fibres in the lens break down and clump together, causing vision to become blurry or cloudy. Other eye conditions, past eye surgery, or medical conditions such as diabetes can cause cataracts.',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What is Cataract Surgery?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cataract surgery is a highly effective medical procedure to remove cataracts and cure an individual\'s vision. The blurry and cloudy (cataract-affected eyes ) lens is replaced with an artificial intraocular lens (IOL). Local anaesthesia is used to ensure that the patient is pain and discomfort-free throughout the process. The surgeon makes a small incision in the cornea; after that, the surgeon can access and treat the cataract-affected area. Cataract surgery is considered the safest and most successful surgery procedure, with a high rate of satisfaction among patients.',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'When does cataract surgery become a necessity?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cataract Surgery becomes necessary when the clouding of the eye\'s natural lens significantly impairs a person\'s vision and interferes with their daily activities and quality of life. The necessity of surgery also depends on visual Symptoms, overall patient health, and other health symptoms. If you have cataracts or are experiencing vision blurriness, it\'s essential to consult an eye doctor near you, for a comprehensive eye examination. At Aapkacare, our doctors help you with the best eye consultation to make your eye vision more clear and uncloudy.',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                                  toggle('Question1');
                                },
                                headingName: "Surgeries We Provide",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      CustomRichText(
                                        boldText: "LASIK(Laser-Assisted in Situ Keratomileusis)",
                                        regularText: "surgery is a popular and widely performed elective surgical procedure used to correct vision problems, primarily nearsightedness (myopia), farsightedness (hyperopia), and astigmatism. A specialized laser cutting laser is used during LASIK surgery to accurately alter the shape of the cornea.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Aapkacare Health",
                                        regularText: "will help you get the treatment with the best surgeons in Pune. For more information regarding the treatment book an appointment with our specialists.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "PRK (Photorefractive Keratectomy): ",
                                        regularText: "PRK is a type of laser surgery similar to LASIK surgery that is used to correct common vision problems. It is an ideal option for individuals who may not be ideal candidates for LASIK due to thinner corneas, irregular corneal shape, or other corneal issues. ",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Femto LASIK:",
                                        regularText: "It is also a type of LASIK surgery that employs femtosecond laser technology to create the corneal flap instead of using a mechanical microkeratome blade.",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Know If LASIK is the Right Procedure For You",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Know if LASIK surgery is the right procedure for you:",
                                        size: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      20.heightBox,
                                      CustomRichText(
                                        boldText: "Consultation:",
                                        regularText: " Schedule an initial consultation with an ophthalmologist who specializes in refractive surgery, including LASIK. You can consult the best ophthalmologists near you with Aapkacare Health.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Comprehensive Eye Examination:",
                                        regularText: "The eye care professional will conduct a comprehensive eye examination to assess various aspects of your eye health.",
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "Some other points are:",
                                        size: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 Age ",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 Pupil size  ",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 Corneal Thickness ",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 Medical History ",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Steps Prior to the LASIK Procedure",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "\u2022 A thorough examination is performed by an eye specialist prior to LASIK surgery to ensure that the eyes are in good condition. ",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "\u2022 There are additional examinations to gauge the cornea ‘s curvature, the size of the pupils in both light and darkness, the eyes ‘ refractive error, and the cornea’ s thickness.",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "\u2022 The patient is required to sign a consent form attesting that they are aware of the risks, advantages, and available alternatives associated with the LASIK surgery.",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "LASIK Procedure",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Here is an overview of the LASIK procedure",
                                        size: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      15.heightBox,
                                      CustomRichText(
                                        boldText: "1 ) Consultation : ",
                                        regularText: "The LASIK process begins with a consultation with an ophthalmologist or eye surgeon. During this appointment, your eye health will be evaluated, and measurements will be taken to determine if you are suitable for LASIK surgery.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(boldText: "2) Preoperative preparations : ", regularText: "If you are deemed a suitable candidate, you may be asked to stop wearing contact lenses for a specific period before the surgery, as they can affect the measurements of your eyes."),
                                      10.heightBox,
                                      CustomRichText(boldText: "3) Surgery day : ", regularText: "The LASIK procedure typically follows these steps:"),
                                      15.heightBox,
                                      myText(
                                        textName: "  \u2022 Anesthetic eye drops are applied to numb the eye, so you won’t feel pain during the surgery",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 A small corneal flap is created on the front surface of the eye. This flap can be created using a mechanical microkeratome blade or a femtosecond laser, depending on the specific LASIK technology used by the surgeon.",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 An excimer laser is used to reshape the underlying corneal tissue based on your prescription to correct your vision.",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "  \u2022 After the corneal tissue is reshaped, the corneal flap is repositioned, and it adheres naturally without the need for stitches.",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      15.heightBox,
                                      CustomRichText(
                                        boldText: "4) Recovery: ",
                                        regularText: "After LASIK, you’ll likely experience improved vision almost immediately, but it can take a few days to weeks for your vision to fully stabilise. Your surgeon will provide instructions for post-operative care, including using prescribed eye drops to facilitate healing and prevent infection.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "5) Follow-up appointments: ",
                                        regularText: "Regular post-operative check-ups are necessary to monitor the healing process and ensure that your vision is improving as expected.",
                                      ),
                                      15.heightBox,
                                      myText(
                                        textName: "LASIK surgery is generally safe and effective for many people, but it’s not suitable for everyone. Many factors like the thickness and shape of your cornea, dryness of your eyes and your overall eye health can affect your eligibility for the procedure. It’s essential to have a comprehensive consultation with an eye care professional to determine if LASIK is right for you.",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "We at, Aapkacare Health will guide you to your LASIK surgery treatment and will provide you a complete information along with one of the best after-surgery follow-ups. For more information regarding the treatment book an appointment with Aapkacare Health specialists.",
                                        size: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Recommendations after LASIK Surgery",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        textName: "After LASIK surgery, there are several important post-operative considerations and care instructions to ensure a smooth recovery and the best possible outcome. Here are some key points to keep in mind after LASIK:",
                                        size: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      20.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022 Follow Post-Operative Instructions: ",
                                        regularText: "Your surgeon will provide specific post-operative instructions that you should follow daily. These instructions may include guidelines on using prescribed eye drops, avoiding certain activities, and attending follow-up appointments.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022 Rest and Relaxation: ",
                                        regularText: "After the surgery, it’s essential to take proper rest to allow your eyes to recover. Some patients may experience mild discomfort, tearing, and light sensitivity immediately after the procedure. These symptoms usually improve within a few hours.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022  Avoid Rubbing Your Eyes: ",
                                        regularText: " It’s crucial to avoid rubbing or touching your eyes, as this can disrupt the healing process and increase the risk of infections.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022  Use Prescribed Eye Drops: ",
                                        regularText: "Your surgeon will provide you with a specific regimen for using eye drops to reduce inflammation, prevent infection, and promote healing. Follow the schedule and dosage instructions carefully.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022 Limit Strenuous Activities: ",
                                        regularText: "Avoid strenuous physical activities, including exercise, for a specified period, usually about one to two weeks, depending on your surgeon’s recommendations. This helps prevent eye strain and the risk of injury.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "\u2022 Attend Follow-Up Appointments: ",
                                        regularText: "You will have several post-operative check-up appointments with your surgeon to monitor your healing progress and assess the stability of your vision correction. Attend these appointments as scheduled. Aapka Care health specialists will help you with your follow-up appointments.",
                                      ),
                                      10.heightBox,
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "The Approach to LASIK Surgery by Aapkacare Health",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(textName: "If you are suffering from persistent refractive error-related discomfort in your eyes and having issues related to your vision. Then Aapkacare Health is here to help you. We will appoint you with the best surgeons near you and will make your LASIK surgery a hassle-free one. Your care will be arranged before, during, and after the procedure by our eye surgeons at an affordable price.", size: 13)
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/cataracts/Womans.jpeg',
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
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
