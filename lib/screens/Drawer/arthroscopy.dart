import 'dart:convert';
import 'package:aapkacare/screens/Drawer/cataract.dart';
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

class Arthroscopy extends StatefulWidget {
  const Arthroscopy({super.key});

  @override
  State<Arthroscopy> createState() => _ArthroscopyState();
}

class _ArthroscopyState extends State<Arthroscopy> {
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
                                  'Affordable Knee Arthroscopy Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Knee Arthroscopy and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of bariatric-related consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons. ',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to Aapkacare’s comprehensive guide on knee arthroscopy, the minimally invasive surgical procedure that can help you overcome knee pain and discomfort. In this informative resource, we’ll delve into the treatment, signs that may indicate you need surgery, what to expect after the procedure, when to consider treatment, the types of knee arthroscopy surgery available, how the surgery is performed, and the numerous benefits it can offer. Let’s begin your journey to a healthier, pain-free knee.',
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
                                'What is knee arthroscopy?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Knee arthroscopy is a minimally invasive procedure performed to diagnose and treat knee joint injury and other similar issues. During arthroscopy surgery, the surgeon makes 2-3 tiny incisions over the knee joint to insert an arthroscope and surgical instruments. ',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'The arthroscope has a camera and light attached to it and helps the surgeon visualize internal structures to avoid soft tissue damage. Since the surgery involves minimal incisions, it usually promises a shorter and easier recovery period compared to open surgery.',
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
                            'assets/kidney/23.jpg',
                            fit: BoxFit.fill,
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
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LeftRightData(
                      leftImage: 'assets/gallbladder/i3.jpg',
                      heading: 'Signs You May Need Knee Arthroscopy',
                      description: 'Common signs that may indicate you require knee arthroscopy include persistent knee pain, swelling, limited range of motion, or instability in the joint. If you are experiencing any of these symptoms, it’s essential to consult with a healthcare professional for a proper evaluation.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                          textName: "Understanding the causes of Lipoma",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Lipomas are likely inherited, so if someone in your family has a lipoma, you are more likely to get one yourself. Multiple lipomas can occur on the body as a result of certain conditions. These conditions include:",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Injury", detailName: "Traumatic injuries, such as sports-related injuries, car accidents, or falls, can damage the knee joint, including torn ligaments (such as the anterior cruciate ligament or ACL), meniscus tears, or fractures."),
                            CausesBox(image: "assets/lipoma/5.png", headingName: "Osteoarthritis", detailName: "This degenerative joint condition causes the cartilage in the knee joint to wear down over time. When conservative treatments like physical therapy and medication are no longer effective, knee surgery may be recommended to alleviate pain and improve joint function."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Rheumatoid Arthritis", detailName: "Inflammatory conditions like rheumatoid arthritis can lead to chronic inflammation in the knee joint, causing pain, swelling, and eventual joint damage. Surgery may be considered in severe cases."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Tendon or Ligament Tears", detailName: " Tears in tendons (like the patellar tendon) or ligaments (such as the ACL or PCL) may require surgical intervention, especially when the damage is significant or affects joint stability."),
                            CausesBox(image: "assets/lipoma/5.png", headingName: "Meniscus Tears", detailName: "The meniscus is a wedge-shaped cartilage in the knee that can tear due to injury or degeneration. Depending on the location and severity of the tear, surgery may be needed to repair or remove the damaged tissue."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Cartilage Defects", detailName: "Conditions like osteochondritis dissecans or chondromalacia patellae can cause damage to the knee’s cartilage. Surgery, such as microfracture or cartilage restoration procedures, may be recommended to repair or regenerate the damaged tissue."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Synovitis or Plica Syndrome", detailName: "Inflammation of the synovial lining or irritation of the synovial plica can lead to pain and limited range of motion in the knee. Surgical intervention may be necessary to address these issues."),
                            CausesBox(image: "assets/lipoma/5.png", headingName: "Bursitis", detailName: "Bursitis in the knee can cause pain and swelling due to inflammation of the bursa sac. In some cases, surgical removal of the inflamed bursa may be required."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Deformities", detailName: "Congenital or acquired deformities due to injuries may necessitate corrective surgery to realign the knee joint and improve function."),
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Cysts and Tumors", detailName: "In rare cases, the presence of cysts or tumors in or around the knee joint may require surgical removal."),
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

                  LeftRightData(
                    rightImage: 'assets/w2.jpg',
                    heading: 'When to Consider Knee Arthroscopy:',
                    description: 'Determining when to undergo knee arthroscopy is a crucial decision. Your healthcare provider will assess your condition and discuss whether this minimally invasive procedure is proper for you. The severity of your knee problems and overall health often influences the timing of the surgery.',
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
                                'Aapka Care - Best orthopaedic center for orthopaedic surgery',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Aapka Care is one of the best surgery care providers in India for orthopaedic surgeries, including knee arthroscopy. We specialize in advanced arthroscopic surgery with help from our panel of expert and experienced orthopaedic surgeons. If you have joint pain or stiffness and have trouble performing your day-to-day activities, you should get in touch with us for US FDA-approved advanced arthroscopic surgery. ',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'In addition to advanced treatment, we also provide other auxiliary services to the patient- such as documentation support, insurance assistance, free cab services for pickup and dropoff, complimentary meals, etc. ',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          height: s.width < 720 ? 400 : 500,
                          child: Image.asset(
                            'assets/w3.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  LeftRightData(
                    leftImage: 'assets/kidney/15.jpg',
                    heading: 'When to Consider Knee Arthroscopy:',
                    description: 'Determining when to undergo knee arthroscopy is a crucial decision. Your healthcare provider will assess your condition and discuss whether this minimally invasive procedure is proper for you. The severity of your knee problems and overall health often influences the timing of the surgery.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LeftRightData(
                      leftImage: 'assets/kidney/14.png',
                      heading: 'Types of knee arthroscopy',
                      description: 'There are various knee arthroscopy surgeries, each tailored to specific knee issues. These include meniscus repair, ligament reconstruction, cartilage restoration, and synovial tissue removal. Your orthopedic surgeon will recommend the most appropriate type based on your diagnosis.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LeftRightData(
                    rightImage: 'assets/appendicitis/woman.jpg',
                    heading: 'How Knee Arthroscopy is Performed',
                    description: 'During knee arthroscopy, a small incision is made near the knee joint, and a tiny camera (arthroscope) is inserted to provide a clear view of the interior. This allows the surgeon to identify and address the problem precisely. Surgical instruments are inserted through additional small incisions to repair or remove damaged tissue. The procedure’s minimally invasive nature often results in less pain, minimal scarring, and a shorter recovery period.',
                  ),
                  SizedBox(
                    height: 20,
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

                  LeftRightData(
                    rightImage: 'assets/gallbladder/i.png',
                    heading: 'What to expect after knee arthroscopy?',
                    description: 'The recovery process is a crucial aspect of knee arthroscopy. It’s essential to follow post-surgery instructions provided by your healthcare team, including physical therapy and rehabilitation exercises. The recovery time varies depending on the type and extent of the surgery, but most patients can return to their daily activities within a few weeks to a couple of months.',
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
                            'assets/gallbladder/i4.jpg',
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
                                'What are the benefits of knee arthroscopy?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Knee arthroscopy offers several advantages, such as quicker recovery, reduced post-operative pain, and minimal scarring. It is often performed on an outpatient basis, allowing you to return home the same day. Moreover, the procedure can significantly improve the quality of life by relieving knee pain and restoring function.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'At Aapkacare, we understand the importance of knee health and are here to assist you throughout your knee arthroscopy journey. If you have any questions or concerns about knee arthroscopy or would like to schedule a consultation with a qualified orthopedic specialist, please don’t hesitate to reach out. Your path to a pain-free and healthy knee starts here.',
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

                  //
                  Container(
                    width: double.infinity,
                    // color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'What are the risks associated with knee arthroscopy?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Knee arthroscopy is generally very safe and chances of complications is incredibly low, however, in rare cases, there is risk of certain complications like:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Infection',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Hemorrhage with accumulation of blood in the knee',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Blood clot formation',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Stiffness of the knee joint',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Injury to the soft tissues, blood vessels, nerves, etc., surrounding the operative site',
                        ),
                        CustomRichText(
                          boldSize: 18,
                          regularSize: 18,
                          boldText: '• ',
                          regularText: 'Unexplained bruising or swelling near the operative site',
                        ),
                        SizedBox(height: 20),
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
