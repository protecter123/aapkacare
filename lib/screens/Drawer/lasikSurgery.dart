import 'dart:convert';
import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Drawer/fixedWidgets.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Result%20Page/SearchPage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class LasikSurgery extends StatefulWidget {
  const LasikSurgery({super.key});

  @override
  State<LasikSurgery> createState() => _LasikSurgeryState();
}

class _LasikSurgeryState extends State<LasikSurgery> {
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
      appBar: PreferredSize(preferredSize: Size.fromHeight(s.width < 1024 ? 65.0 : 110.0), child: const NavBarBooking()),
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
                                  'Affordable Lasik Surgery in Mumbai',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through LASIK (Laser-Assisted in Situ Keratomileusis) surgery and have a clear vision at an affordable price with the best Lasik doctor in Mumbai? Get all kinds of LASIK consultations for your eye surgery. Here at Aapkacare Health we will provide the best Lasik surgeons and can restore your clear vision in 30 minutes via bladeless LASIK surgery at a reasonable price.',
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
                                    circleCheck(text: 'No Cost EMI'),
                                    circleCheck(text: 'Minimal Pain'),
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 30,
                      children: [
                        Container(
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
                            height: 300,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Image.asset('assets/lasik-desk.png')),
                        Container(
                            width: s.width < 1024 ? s.width : 600,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'What is LASIK Surgery?',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'A laser-assisted surgery is a popular and widely performed refractive eye surgery that can correct your vision problems such as nearsightedness (myopia), farsightedness (hyperopia), and astigmatism. Laser-assisted in situ keratomileusis or LASIK in which “Keratomileusis” refers to the process of correcting the shape of the cornea and the word “Situ” means in position. Throwing away your glasses was never so easy, We at Aapkacare Health assist you in discovering the true yourself with LASIK surgery. ',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Reasons
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        20.heightBox,
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
                            ReasonBox(
                              image: "assets/eye1.png",
                              headingName: "Improved Vision",
                              detailName: "LASIK can correct vision problems like myopia, hyperopia, and astigmatism very quickly",
                            ),
                            10.widthBox,
                            ReasonBox(image: "assets/eye2.png", headingName: "Cost Savings", detailName: "With Aapkacare Health you can save a lot of money and you will get the best LASIK surgeon at cost cost-effective Lasik surgery rate."),
                            10.widthBox,
                            ReasonBox(image: "assets/headache.png", headingName: "Quick Procedure", detailName: "LASIK surgery can be done in 30 minutes and they are very effective. So within less period, you can get quick and visible results"),
                            10.widthBox,
                            ReasonBox(image: "assets/road_sign.png", headingName: "High Success Rate", detailName: "LASIK has a high success rate and is considered a very safe and effective procedure when performed by a skilled and experienced surgeon."),
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
                        textName: "Understanding the Causes of Refractive Error",
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      myText(
                        textName: "Refractive error is an eye condition that is caused by an irregular cornea. LASIK surgery is performed to correct the abnormal cornea. Here are the various causes of refractive error.",
                        size: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ).px(100 * s.customWidth),
                  SizedBox(
                    height: 30,
                  ),

                  // Error
                  Container(
                    width: s.width,
                    // color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        20.heightBox,
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
                            ErrorBox(
                              image: "assets/eye3.png",
                              headingName: "Eyeball Length",
                              detailName: "The length of the eyeball is a significant factor in refractive errors. If the eyeball is too long (axial myopia) or too short (axial hyperopia), it can lead to nearsightedness or farsightedness, respectively.",
                            ),
                            10.widthBox,
                            ErrorBox(image: "assets/problematic.png", headingName: "Genetics", detailName: "Refractive errors often run in families, suggesting a genetic predisposition. If your parents or siblings have refractive errors, you may be more likely to develop them as well."),
                            10.widthBox,
                            ErrorBox(image: "assets/lense_age.png", headingName: "Medication", detailName: "Some medications, particularly steroids, can cause changes in the shape and flexibility of the lens, leading to refractive errors."),
                            10.widthBox,
                            ErrorBox(image: "assets/lense_age.png", headingName: "Age", detailName: "Aging can be one of the factors of refractive error and can cause problems in the eyes and vision."),
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
                  Questions(image: 'assets/what.jpg', heading: 'OUR EXPERTS EXPLAIN', questions: [
                    'WHY',
                    'What'
                  ], questionContents: [
                    Column(
                      children: [
                        Text(
                          'Why LASIK surgery is popular?',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Quick Results : ',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                              ),
                              TextSpan(
                                text: 'LASIK offers rapid results, with most patients experiencing improved vision within a day or two.',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Minimal Discomfort : ',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                              ),
                              TextSpan(
                                text: 'LASIK is a relatively painless procedure. Most patients experience minimal discomfort or pain during and after surgery.',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Long-Lasting Results : ',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                              ),
                              TextSpan(
                                text: 'The vision correction achieved with LASIK is typically long-lasting.',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What sort of results can you expect?',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '• Improved vision',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '• Quick recovery',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '• Improved lifestyle',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '• Minimal discomfort',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '• If you are appointing your surgery with Aapkacare Health you can expect low cost and hassle-free treatment.',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),

                  // Faqs
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
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
                            'assets/LASIKphoto.jpg',
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
                          'Well-experienced and highly qualified doctors to provide an accurate diagnosis and answerall your queries.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          leftImage: 'assets/healthcare.jpg',
                          heading: '',
                          description: 'To consult our skilled surgeons for any problems or to undergo Lasik surgery, visit the nearest Eye clinic in Mumbai with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the Opthal surgeons in Mumbai. The Mumbai Aapkacare Health multi-speciality clinics for Lasik are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Lasik procedure in Mumbai.',
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
                    heading: 'Are you worried about the cost of lasik treatment?',
                    description: 'At Aapkacare Health, we understand that cost is an important factor for our patients when it comes to seeking medical treatment, including Lasik surgery. However, we want to reassure you that we are committed to providing affordable and high-quality care to all of our patients. The cost of Lasik treatment can vary depending on a number of factors, including the patient’s medical history and more. We encourage you to speak with one of our knowledgeable and compassionate staff members to learn more about the cost',
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

class ErrorBox extends StatelessWidget {
  final bool? start;
  final double? width;
  final String image;
  final String headingName;
  final String detailName;
  const ErrorBox({
    super.key,
    required this.image,
    required this.headingName,
    required this.detailName,
    this.start, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            // height: 40,
            width: 60,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: start == true ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 10),
                myText(
                  textName: headingName,
                  size: 15,
                  fontWeight: FontWeight.bold,
                ),
                myText(
                  start: start,
                  textName: detailName,
                  fontWeight: FontWeight.w400,
                  size: 14,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class myQuestion extends StatelessWidget {
  final VoidCallback onTap;
  final String headingName;
  const myQuestion({
    super.key,
    required this.onTap,
    required this.headingName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: myText(
                textName: headingName,
                size: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
              size: 15,
            )
          ],
        ),
      ).pOnly(bottom: 15),
    );
  }
}
