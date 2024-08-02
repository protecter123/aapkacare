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

class KidneyTransplant extends StatefulWidget {
  const KidneyTransplant({super.key});

  @override
  State<KidneyTransplant> createState() => _KidneyTransplantState();
}

class _KidneyTransplantState extends State<KidneyTransplant> {
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
                                  'What is Kidney Transplant?',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through  Kidney Transplant surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of bariatric-related consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons. ',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome to Aapkacare’s comprehensive guide on kidney replacement. In this article, we’ll cover all aspects of kidney replacement, including treatment options, signs indicating the need for surgery, the surgical procedures involved, and the benefits of undergoing this life-changing treatment.',
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
                                    circleCheck(text: 'Free Pick Up & Drop'),
                                    circleCheck(text: 'Post Surgery Assistance'),
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

                  buildTable(),
                  SizedBox(
                    height: 30,
                  ),
                  // signs
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          rightImage: 'assets/kidney/17.jpg',
                          heading: 'Overview',
                          description: 'A Kidney Transplant is a surgical method in which a healthy kidney is transplanted in patients suffering from an end-stage renal disease with irreversible kidney damage. This procedure is also known as Renal Transplantation. The kidney transplant is a major and complex procedure that takes about 3 to 5 hours to complete and is performed under general anaesthesia. The procedure has a high success rate. ',
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        myText(
                          textName: "Identifying the signs of Kidney Transplant",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/kidney/9.png", headingName: "Persistent Fatigue", detailName: "Feeling excessively tired despite adequate rest."),
                            ReasonBox(image: "assets/kidney/1.png", headingName: "Swelling", detailName: "Noticeable swelling in the ankles, feet, or around the eyes."),
                            ReasonBox(image: "assets/kidney/3.png", headingName: "High Blood Pressure", detailName: "Uncontrolled high blood pressure that is difficult to manage."),
                            ReasonBox(image: "assets/kidney/7.png", headingName: "Decreased Urine Output", detailName: "A significant decrease in the amount of urine produced."),
                            ReasonBox(image: "assets/kidney/11.png", headingName: "Changes in Urine", detailName: "Changes in the color, odor, or frequency of urination."),
                            ReasonBox(image: "assets/kidney/11.png", headingName: "Shortness of Breath", detailName: "Difficulty breathing, especially during physical activity."),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),

                    // color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Causes of Kidney problems that can lead to replacement",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Kidney replacement, often referred to as kidney transplantation, is a medical procedure performed to replace a non-functioning or failed kidney with a healthy kidney from a living or deceased donor. The primary cause of kidney replacement is end-stage renal disease (ESRD), in which the kidneys have lost most or all of their normal function. Several common causes of ESRD can lead to the need for kidney replacement:",
                          size: 18,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 50 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ErrorBox(width: 300, start: true, image: "assets/kidney/6.png", headingName: "Chronic Kidney Disease (CKD)", detailName: "The most common cause of ESRD is the progression of chronic kidney disease. CKD can result from various underlying conditions, including diabetes, high blood pressure (hypertension), glomerulonephritis, polycystic kidney disease, and other kidney-related disorders."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/5.png", headingName: "Diabetes", detailName: "Diabetes is a leading cause of kidney disease, particularly in cases of type 1 and type 2 diabetes"),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/10.png", headingName: "Hypertension (High Blood Pressure)", detailName: "Uncontrolled high blood pressure over an extended period can cause damage to the blood vessels in the kidneys."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/8.png", headingName: "Glomerulonephritis", detailName: " Glomerulonephritis is a group of diseases that cause inflammation and damage to the tiny kidney filtering units of the glomeruli."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/2.png", headingName: "Polycystic Kidney Disease (PKD)", detailName: "PKD is a genetic disorder in which cysts form within the kidneys"),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/4.png", headingName: " Infections and Inflammation", detailName: "Severe and recurrent kidney infections or autoimmune conditions affecting the kidneys can lead to kidney damage and ESRD."),
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

                  // Prevention
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
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
                            )),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'What to expect before and on the day of Kidney Transplant surgery?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The donor needs to register himself/herself for donating his/her organs. The donor may choose to donate organs, such as eyes, kidneys, or liver, before or after his/her death.',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Before the Kidney Transplant',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Before the surgery, the patient is evaluated by a transplant centre team. Tests are done to ensure that the patient is healthy enough to undergo transplant surgery. The following tests are done before surgery:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'A blood test is done to rule out the presence of any infection.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Blood typing and tissue typing ensure that the body will not reject the transplanted kidney.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Heart tests like echocardiogram, cardiac catheterisation, and EKG are also done.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Tests are also performed to determine the presence of any cancer.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Doctors may advise the patient to stop smoking and drinking until he/she waits for transplantation to prevent delayed healing and improve outcomes after transplant surgery.',
                              ),
                              SizedBox(height: 20),
                              Text(
                                'On the day of the Kidney Transplant',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'The patient should leave all valuable items at home.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'The patient needs to reach the transplant centre before the scheduled time.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'The patient will be asked to sign the consent form in the presence of his/her family.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'After reaching the transplant centre, the staff will ask the patient to change and wear a gown provided by the centre.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Before the procedure, the staff will ask the name and treatment type the patient undergoes. It is done to avoid mismatch and confusion in the transplantation.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'The patient’s blood pressure, breathing rate, and heart rate are also monitored before starting the procedure.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'The patient will then be shifted to the operation theatre.',
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

                  // Faqs
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 50 : 100),
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
                                headingName: "Types of Kidney Transplant",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        textName: "Patients may undergo any of the following types of kidney transplant:",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Living donor: ",
                                        regularText: "The patient receives the kidney from a living donor. The living donor may be parents, relatives, neighbours or friends.",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Deceased donor: ",
                                        regularText: "The patient receives the kidney from a deceased person who himself or his immediate relative chooses to donate kidneys after his death. ",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "Swap exchange (paired exchange): ",
                                        regularText: "In this type of kidney transplant, if the donor’s kidney is incompatible with the recipient, he may exchange the kidney with another pair of donors and the recipient. There is a simultaneous kidney transplant in two recipients",
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "ABO incompatibility:",
                                        regularText: "Earlier, in the absence of advanced techniques, if the blood type of donor and recipient were incompatible, there was a rejection of the kidney by the immune system. However, with the availability of new techniques, a blood-type incompatible kidney transplant is possible. The patient has to undergo treatment before and after the kidney transplant surgery to reduce the risk of rejection. The doctor may inject immunoglobulins to reduce the risk of infection, perform plasmapheresis to eliminate antibodies and administer advanced medicines to reduce rejection risk.",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Anatomy and Physiology of the Kidney",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "The kidneys are one of the most important organs of the human body. They are bean-shaped, reddish-brown paired organs in the renal system that are normally located high in the abdominal cavity and against its back wall, lying on each side of the vertebral column and surrounded by adipose tissue. The right kidney is usually slightly inferior compared to the left kidney, probably because of its relationship to the liver.",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "The kidneys are highly complex organs with many parts. The main parts of the kidney are:",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      10.heightBox,
                                      myText(
                                        textName: "Kidney capsule (renal capsule): It is made of three layers of connective tissue or fat that protect the kidney from injury, increase its stability and connect the kidneys to surrounding tissues.",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      20.heightBox,
                                      myText(
                                        textName: "The kidney performs some of the vital functions of the body, including:",
                                        size: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Maintaining the overall body fluid balance",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Regulating and filtering the minerals from the blood",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Filtering the waste products from food, medications and toxic substance",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Creating hormones that help produce red blood cells, promote bone health, and regulate blood pressure",
                                      ),
                                      10.heightBox,
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Conditions treated with Kidney Transplant",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "The doctor also evaluates whether the patient is eligible for a kidney transplant. Several conditions are treated by kidney transplants. Some of them are:",
                                        size: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Kidney damage due to persistent high blood sugar levels (diabetes) or uncontrolled high blood pressure",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Glomerulonephritis is characterised by inflammation of the filtering unit of the kidneys",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Haemolytic uremic syndrome",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Urinary tract obstructions",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Interstitial nephritis causes inflammation in the kidney tubules",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Poisoning due to heavy metals, such as cadmium, mercury, cobalt, and arsenic",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Excessive consumption of medicines, such as aspirin, ibuprofen, and naproxen",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Lupus and other types of immune diseases",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Repeated urinary infection",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Polycystic kidney disease",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Who needs Kidney Transplant?",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A kidney transplant is not for everyone. Patients with advanced age, recently treated or active cancer, drug and alcohol abuse, and several cardiovascular diseases are generally not eligible for a kidney transplant. In general, a candidate should have the following to be a kidney transplant recipient.",
                                        size: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      10.heightBox,
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "End-stage renal failure and on dialysis.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Late-stage chronic kidney disease, approaching the need for dialysis.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "A life expectancy of at least five years.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "A full understanding of postoperative instructions and care.",
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "How is Kidney Transplant performed?",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        textName: "Kidney transplantation involves placing a healthy kidney into the body where it can perform all the functions that a failed kidney cannot perform. The new kidney is placed on the lower right or left side of the abdomen where it’s surgically connected to the nearby blood vessels. The whole procedure takes about 3 to 5 hours to complete and is performed under general anaesthesia by a specialised team of anaesthetists, transplant surgeons (nephrologists), and other medical staff. The procedure of kidney transplant surgery is done in the following ways.",
                                        size: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      20.heightBox,
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The paramedical staff monitors heart rate, blood pressure, and blood oxygen level throughout the surgical procedure of both the donor and recipient.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The procedure starts with the surgery of the donor",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The donor’s kidney is removed, and then surgery for the recipient starts.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "After administering the anaesthesia to the recipient, a minute cut is made in the pelvis area. The cut is made just above the waistline on the side where the kidney is to be transplanted.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The original kidney is not removed in most cases. It is removed only if the original kidney is causing pain or any issue in blood circulation. ",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The donor’s kidney is placed in the lower abdomen.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Blood vessels are attached, and the ureter is also connected to the newly transplanted kidney.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The newly transplanted kidney is sewn in its place. The transplanted kidney starts forming urine and blood filtering within minutes after being attached.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The surgeon places a stent in the ureter to help in urinating. It is removed after 6-12 weeks.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "Then the cuts are closed using stitches, special glue or stapled.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "After this, it is dressed using a sterile surgical bandage.",
                                      ),
                                      CustomRichText(
                                        boldText: "• ",
                                        regularText: "The patient will then be shifted to a recovery room to monitor vitals and post-operative recovery.",
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
                            'assets/kidney/18.png',
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
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
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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
                                'Benefits of Kidney Transplant',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'A kidney transplant is generally the best treatment for kidney failure in a patient who fits the transplantation procedure. A successful kidney transplant procedure provides several benefits such as:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Increases life expectancy or survival rate',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Improves the quality of life',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Cost-effective when compared to multiple dialyses',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Higher energy levels ',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Fewer restrictions on what an individual can eat and drink',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Helps improve sex life and fertility ',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Allows to resume daily activities',
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
                                'assets/w3.jpg',
                                fit: BoxFit.fill,
                              ),
                            )),
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
                                'assets/gallbladder/i.png',
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
                                'Risks and complication of Kidney Transplant',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'A kidney transplant is a major and complex procedure that can cause problems for some patients. The main risks and complications of kidney transplant include:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'an allergic reaction to general anaesthesia',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'bleeding',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'blood clots',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'leakage from the ureter',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'a blockage of the ureter',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'an infection',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'rejection of the donated kidney',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'failure of the donated kidney',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'a heart attack',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'a stroke',
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
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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
                                'When is consultation with the doctor needed?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The patient can visit the doctor if he/she is facing any kind of discomfort, such as:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Pain in the abdominal area',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Inflammation or swelling',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Infection in the incision area',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Bleeding',
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
                                'assets/gallbladder/i3.jpg',
                                fit: BoxFit.fill,
                              ),
                            )),
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
                                'assets/kidney/15.jpg',
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
                                'Risks of delayed Kidney Transplant',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'If a patient suffering from an end-stage renal disease delays a kidney transplant, it can cause life-threatening complications. The common risks of delayed kidney transplant are:',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Anaemia',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Bone weakness',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Fluid retention',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Heart disease',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Hyperkalemia',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Urinary tract obstruction',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Blood toxicity',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Uncontrolled systemic disease (heart or liver disease)',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Multiple organ failure',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  ',
                                regularText: 'Death',
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
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    color: Colors.blue[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cost of Kidney Transplant',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The cost of a kidney transplant ranges from ₹4,00,000 to ₹10,00,000. The cost of the surgery varies based on the following factors: ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Age of the patient',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The type of procedure done',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Relationship to the kidney donor',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The medical condition of the patient',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'Post-surgical complications that are involved',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  ',
                          regularText: 'The type of hospital facility availed – individual room or shared.',
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

  Widget buildTable() {
    return Container(
      width: 800,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SURGERY NAME',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('KIDNEY TRANSPLANT'),
            ),
          ]),
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ALTERNATIVE NAME',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('RENAL TRANSPLANTATION'),
            ),
          ]),
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'DISEASE TREATED',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('END-RENAL DISEASE, URINARY TRACT OBSTRUCTION, LUPUS, REPEATED URINARY INFECTION, POLYCYSTIC KIDNEY DISEASE'),
            ),
          ]),
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'BENEFITS OF THE SURGERY',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('INCREASES LIFE EXPACTANCY OR SURVIVAL RATE, IMPROVES THE QUALITY OF LIFE, COST-EFFECTIVE, ALLOW TO RESUME DAILLY ACTIVITIES'),
            ),
          ]),
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TREATED BY',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('NEPHROLOGIST'),
            ),
          ]),
        ],
      ),
    );
  }
}
