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

class Hip extends StatefulWidget {
  const Hip({super.key});

  @override
  State<Hip> createState() => _HipState();
}

class _HipState extends State<Hip> {
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
                                  'Affordable Hip replacement Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Hip replacement surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to Aapkacare, your trusted source for information about hip replacement surgery, experienced doctors, and post-treatment care. If you or a loved one is experiencing hip pain, limited mobility, and other signs and symptoms of hip problems, you’re in the right place. We’re here to provide you with valuable insights and guidance to help you make informed decisions regarding your hip health.',
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
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        LeftRightData(
                          leftImage: 'assets/what.jpg',
                          heading: 'Experienced Doctors for Hip Replacement',
                          description: 'Choosing the right surgeon is crucial for a successful hip replacement. Aapka care offers a comprehensive directory of experienced and qualified orthopedic surgeons who specialize in hip replacement surgeries. Our doctors are dedicated to providing the highest level of care, ensuring you receive the best possible treatment',
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Signs and Symptoms',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Before considering hip replacement surgery, it’s essential to recognize the signs and symptoms that may indicate a need for the procedure',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Persistent hip pain, even at rest.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Limited range of motion in the hip joint.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Difficulty in walking or bearing weight on the affected hip.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Chronic hip stiffness.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• ',
                                regularText: 'Little to no improvement with non-surgical treatments, such as physical therapy or pain medications.',
                              ),
                              SizedBox(height: 10),
                              Text(
                                'If you or a loved one are experiencing these signs and symptoms, it may be time to consult with one of our trusted doctors to discuss the possibility of hip replacement surgery.',
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

                  // treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
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
                                'Understanding Hip Replacement Surgery',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'When hip problems become severe and conservative treatments no longer provide relief, hip replacement surgery becomes a viable option. This surgical procedure involves replacing a damaged or diseased hip joint with an artificial implant, alleviating pain, and restoring mobility.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The Hip Replacement Process',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'The process of hip replacement surgery typically involves the following steps',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '1. Pre-surgery Assessment:',
                                regularText: ' Your doctor will conduct a thorough evaluation of your hip condition to determine the extent of damage and your overall health.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '2. Surgical Procedure: ',
                                regularText: 'During the surgery, the damaged joint is replaced with a prosthetic implant designed to mimic the natural hip joint.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: 'Recovery and Rehabilitation:',
                                regularText: ' After surgery, a period of rehabilitation and physical therapy is essential to regain strength and mobility.',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 400 : 600,
                          child: Image.asset(
                            'assets/appendicitis/woman.jpg',
                            fit: BoxFit.fill,
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 300 : 400,
                          child: Image.asset(
                            'assets/mole/8.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Understanding Hip Replacement Surgery',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Hip replacement surgery is usually performed to replace the damaged hip joint with artificial implants to restore joint mobility and function. An orthopedic surgeon usually recommends this surgery to patients with severe hip joint arthritis or necrosis, who’ve become bedridden due to pain and joint instability. During the surgery, only the affected parts of the joint are removed, whether it is a small portion of the entire joint.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Hip replacement surgery is also known as hip arthroplasty. The aim of the procedure is to allow you to resume daily activities and exercise without any pain.',
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

                  // About Us
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
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
                                    Text(
                                      'Post-Treatment Care',
                                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Recovery is a crucial phase in the hip replacement journey. At Aapkacare, we emphasize the importance of post-treatment care, which includes:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(height: 20),
                                    CustomRichText(
                                      boldSize: 16,
                                      regularSize: 16,
                                      boldText: '• ',
                                      regularText: 'Following your doctor’s recommendations for post-operative exercises and physical therapy.',
                                    ),
                                    CustomRichText(
                                      boldSize: 16,
                                      regularSize: 16,
                                      boldText: '• ',
                                      regularText: 'Adhering to a prescribed medication regimen.',
                                    ),
                                    CustomRichText(
                                      boldSize: 16,
                                      regularSize: 16,
                                      boldText: '• ',
                                      regularText: 'Making necessary modifications to your lifestyle and home environment to facilitate a smooth recovery.',
                                    ),
                                    CustomRichText(
                                      boldSize: 16,
                                      regularSize: 16,
                                      boldText: '• ',
                                      regularText: 'Regular follow-up appointments with your surgeon to monitor progress and address any concerns.',
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Our platform provides you with valuable resources and information to ensure a successful post-treatment journey. We are dedicated to helping you achieve optimal results and regain a pain-free, active life.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(height: 20),
                                    CustomRichText(
                                      boldSize: 18,
                                      regularSize: 18,
                                      boldText: 'Aapkacare ',
                                      regularText: ' is your go-to resource for all things related to hip replacement surgery, experienced doctors, and comprehensive aftercare guidance. We are committed to supporting you throughout your hip replacement journey, from recognizing signs and symptoms to finding the right surgeon and successfully navigating the recovery process. Your hip health is our priority, and we’re here to assist you every step of the way.',
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                                height: s.width < 720 ? 300 : 400,
                                child: Image.asset(
                                  'assets/mole/3.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          description: 'To consult our skilled surgeons for any problems or to undergo Hip replacement surgery, visit the nearest Hip replacement clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Hip replacement surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for Hip surgery are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Hip replacement procedure in Pune. Our Aim is to keep you healthy',
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
                    heading: 'Are you worried about the cost of Hip replacement treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Hip replacement in Pune. Even so, the exact cost is hard to pinpoint since your Hip replacement surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
