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

class Circumcision extends StatefulWidget {
  const Circumcision({super.key});

  @override
  State<Circumcision> createState() => _CircumcisionState();
}

class _CircumcisionState extends State<Circumcision> {
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
                                  'Affordable Circumcision Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'New studies and cultural shifts have encouraged us to take a deeper look at the practice of circumcision in recent decades. Dedicated to providing hassle-free laser circumcision surgery at the best facilities with individualised care, Aapkacare Health is a patient-centered, technology-driven healthcare service provider. Meet with Aapkacare Health’s skilled surgeons and opt for a highly advanced circumcision surgery at affordable rates.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: '15 Min Procedure'),
                                    circleCheck(text: 'No Stitches'),
                                    circleCheck(text: 'Minimal Pain'),
                                    circleCheck(text: 'Complete Insurance Surgery'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
                                    circleCheck(text: 'Post Surgery Assistance'),
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
                    rightImage: 'assets/circumcision/6.png',
                    heading: 'What is Circumcision (Sunnath)?',
                    description: 'Circumcision is a surgical procedure that involves the removal of the foreskin, which is the fold of skin that covers the head of the penis. It is typically performed on males, and the practice has been carried out for centuries for various cultural, religious, and medical reasons. It’s important to note that opinions about circumcision vary widely, and deciding to have a circumcision is personal. It should be made after carefully considering all relevant factors, including medical advice, cultural and religious beliefs, and personal preferences',
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
                          textName: "Identify the Signs of Hernia",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SignBox(image: "assets/circumcision/1.png", detailName: "Inability to pull the foreskin back"),
                            10.widthBox,
                            SignBox(image: "assets/circumcision/2.png", detailName: "The foreskin is trapped behind the glans"),
                            10.widthBox,
                            SignBox(image: "assets/circumcision/3.png", detailName: "Painful and swollen penis"),
                            10.widthBox,
                            SignBox(image: "assets/circumcision/4.png", detailName: "Not being able to clean under the foreskin"),
                            10.widthBox,
                            SignBox(image: "assets/circumcision/5.png", detailName: "Infections of the foreskin"),
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
                        textName: "Understand the causes of Hernia",
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      myText(
                        textName: "Hernias develop when a combination of muscle weakness and increased pressure on the abdominal wall. The specific causes of hernias can vary depending on the type of hernias. Some common causes of Hernia include ",
                        size: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ).px(100 * s.customWidth),
                  SizedBox(
                    height: 30,
                  ),

                  // Cause
                  Container(
                    width: s.width,
                    // color: Colors.blue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "These are the most typical causes of muscle weaknesses that lead to hernia: ",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: 50 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(width: 350, image: "assets/circumcision/8.png", headingName: "Hygiene", detailName: "Circumcision may make it easier to clean the penis, as there is no foreskin to retract and clean underneath. This can reduce the risk of infections and the buildup of smegma, a substance that can accumulate under the foreskin."),
                            ReasonBox(width: 350, image: "assets/circumcision/9.png", headingName: "Reduced Risk of Urinary Tract Infections (UTIs)", detailName: "Some studies have suggested that circumcised males may have a lower risk of UTIs, particularly in infancy. However, the overall risk of UTIs in males is relatively low, and the protective effect of circumcision is not considered a compelling reason for the procedure."),
                            ReasonBox(width: 350, image: "assets/circumcision/10.png", headingName: "Lower Risk of Sexually Transmitted Infections (STIs)", detailName: "Research has indicated that circumcision may reduce the risk of certain STIs, including HIV, herpes, and HPV, in males. It is important to note that circumcision is not a substitute for safe sexual practices and condom use."),
                            ReasonBox(width: 350, image: "assets/circumcision/8.png", headingName: "Decreased Risk of Penile Cancer", detailName: "Circumcision has been associated with a reduced risk of penile cancer. However, penile cancer is rare, and the risk reduction is relatively small. Other factors, such as smoking and HPV infection, play a more significant role in penile cancer risk.."),
                            ReasonBox(width: 350, image: "assets/circumcision/9.png", headingName: "Prevention of Phimosis", detailName: "Circumcision can prevent or treat phimosis, a condition in which the foreskin becomes too tight to retract over the head of the penis. Phimosis can be painful and may lead to other health issues."),
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
                  Questions(
                    image: 'assets/what.jpg',
                    heading: '',
                    questions: [
                      'How',
                      'What',
                    ],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How should a circumcised penis be taken care of ?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '•  Keep It Clean',
                            regularText: 'Cleanliness is crucial during the healing process.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Gentle Patting',
                            regularText: 'Gently pat the penis dry with a clean, soft cloth after washing.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Avoid Aggressive Cleaning',
                            regularText: 'Do not try to forcibly retract the remaining foreskin if it hasn\'t fully separated from the head of the penis. This may lead to unwanted injury.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Apply Ointment',
                            regularText: 'Follow your healthcare provider\'s instructions regarding ointment use.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Avoid Tight Clothing',
                            regularText: 'Dress your child in loose-fitting clothing to prevent friction and irritation against the healing area.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Change Diapers',
                            regularText: 'If the child is in diapers, change them regularly to keep the area clean and dry',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '•  Avoid Bathing in Soapy Water',
                            regularText: 'While the circumcision site is healing, it\'s advisable to avoid bathing in soapy water, especially in a bathtub. Instead, gentle showers prevent the incision from soaking in potentially irritating substances.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Follow Post-Operative Instructions',
                            regularText: 'If the circumcision was performed on an adult or older child, it\'s crucial to follow the specific post-operative instructions provided by the healthcare provider',
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
                            'What are some medical issues that may require circumcision?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Phimosis',
                            regularText: 'Phimosis is when the foreskin is too tight and cannot be retracted over the head of the penis.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Paraphimosis',
                            regularText: ' Paraphimosis occurs when the foreskin is retracted behind the head of the penis and becomes trapped, causing swelling and constriction of blood flow.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Recurrent Balanitis',
                            regularText: ' Balanitis is the inflammation of the glans (head) of the penis, often due to infection or irritation.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Frenulum Breve',
                            regularText: 'Frenulum breve is a condition in which the frenulum (a band of tissue on the underside of the penis) is too short and restricts the movement of the foreskin.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Chronic Urinary Tract Infections (UTIs)',
                            regularText: ' In some cases, individuals who experience chronic UTIs may be advised to undergo circumcision, as it has been suggested that circumcision may reduce the risk of UTIs.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Penile Cancer',
                            regularText: 'While penile cancer is rare, but more common in uncircumcised men',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Balanitis Xerotica Obliterans (BXO)',
                            regularText: ' BXO is a condition that causes the foreskin to become thickened and scarred, often leading to phimosis.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '•  Recurrent Foreskin Infections',
                            regularText: ' In some cases, individuals may experience recurrent infections of the foreskin or glans, which do not respond to conservative treatments.',
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
                          'Well-experienced and highly qualified doctors to provide an accurate diagnosis and answer all your queries.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 50 : 100),
                        SizedBox(
                          height: 20,
                        ),
                        LeftRightData(
                          leftImage: 'assets/healthcare.jpg',
                          heading: '',
                          description: 'To consult our skilled surgeons for any problems or to undergo Circumcision surgery, visit the nearest Circumcision hospital in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top General surgeons in Pune. The Pune Aapkacare Health multi-speciality hospital for Circumcision are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced laparo Circumcision procedure in Pune.',
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

class SignBox extends StatelessWidget {
  final String image;
  final String detailName;
  const SignBox({
    super.key,
    required this.image,
    required this.detailName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
            textName: detailName,
            fontWeight: FontWeight.w400,
            size: 14,
          )
        ],
      ),
    );
  }
}
