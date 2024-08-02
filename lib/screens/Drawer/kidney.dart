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

class Kidney extends StatefulWidget {
  const Kidney({super.key});

  @override
  State<Kidney> createState() => _KidneyState();
}

class _KidneyState extends State<Kidney> {
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
                                  'Affordable Kidney stone Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Kidney stones are one of the most painful health conditions that people experience. In India, 5 out of 10 people suffer from kidney stones. So, treating this medical condition has to be affordable and hassle-free. Here at Aapkacare Health, we will take off your kidney stone treatments. We will provide you with the best doctors and surgeons near you at an affordable price. For more information on your condition, book an appointment today and get the best treatment with Aapkacare Health.',
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
                    rightImage: 'assets/kidney/13.png',
                    heading: 'What are Kidney Stones?',
                    description: 'Kidney stones, also known as renal calculi or nephrolithiasis, are hard, crystalline kidney deposits. These stones can vary in size and composition and may develop in one or both kidneys. Kidney stones can be quite painful and can cause various symptoms and complications. Kidney stones are made up of different substances. The most common types include calcium oxalate, calcium phosphate, uric acid, and struvite stones. The composition of the stones can influence its treatment and prevention.',
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
                            ReasonBox(image: "assets/kidney/9.png", headingName: "Severe Pain", detailName: "Kidney stones are often associated with intense pain, commonly called renal colic."),
                            ReasonBox(image: "assets/kidney/1.png", headingName: "Blood in Urine", detailName: "Kidney stones can cause blood to appear in the urine."),
                            ReasonBox(image: "assets/kidney/3.png", headingName: "Painful Urination", detailName: "ome people with kidney stones may experience discomfort or pain while urinating."),
                            ReasonBox(image: "assets/kidney/11.png", headingName: "Nausea and Vomiting ", detailName: "Nausea and vomiting can be experienced if a person has kidney stone"),
                            ReasonBox(image: "assets/kidney/7.png", headingName: "Painful Flank", detailName: "Pain from kidney stones can be felt on one side of the body, often in the lower back or side."),
                            ReasonBox(image: "assets/kidney/7.png", headingName: "Fever and Chills", detailName: "Kidney stones can lead to infection, which may result in fever and chills."),
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
                        textName: "Understanding the causes of Kidney Stone",
                        size: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      myText(
                        textName: "When the volume of hazardous waste in the urine exceeds the volume of fluid in the bladder, pelvic ureteric junction and ureter, kidney stones develop.",
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        myText(
                          textName: "Here are some factors that increase the risk of kidney stones: ",
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
                            ErrorBox(width: 300, start: true, image: "assets/kidney/6.png", headingName: "Dietary Factors", detailName: "Consuming too much calcium through diet or supplements can lead to the formation of calcium-based kidney stones, particularly calcium oxalate stones."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/5.png", headingName: "Inadequate Hydration", detailName: "Low fluid intake can result in concentrated urine, making it more likely that substances in the urine will crystallize and form stones."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/10.png", headingName: "Medical Conditions", detailName: "A condition characterized by elevated calcium levels in the urine can increase the risk of calcium-based stones."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/8.png", headingName: "Family History", detailName: "A family history of kidney stones can increase an individual’s susceptibility to stone formation. "),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/2.png", headingName: "Obesity", detailName: "Obesity is associated with several factors that can increase the risk of kidney stones, including dietary habits and metabolic changes."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/4.png", headingName: "Urinary Tract Abnormalities", detailName: "Structural abnormalities in the urinary tract, such as narrow ureters, can slow the urine flow, allowing crystals to accumulate and form stones."),
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
                                headingName: "Calcium Oxalate Stones",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                    child: myText(
                                  textName: 'These are the most common type of kidney stones, primarily composed of calcium oxalate. High levels of dietary oxalate or an overproduction of oxalate by the body can contribute to the formation of these stones. They can occur in individuals with hypercalciuria (excessive calcium excretion) or primary hyperoxaluria (a genetic disorder).',
                                  size: 14,
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Calcium Phosphate Stones",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                    child: myText(
                                  textName: 'These stones primarily comprise calcium phosphate. They can form in conditions with elevated urine pH (alkaline urine) and are less common than calcium oxalate stones. Some medical conditions and medications can increase the risk of calcium phosphate stones.',
                                  size: 14,
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Struvite Stones",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                    child: myText(
                                  textName: 'Struvite stones, also known as infection stones, typically comprise magnesium ammonium phosphate. They are associated with urinary tract infections (UTIs) caused by bacteria that produce ammonia. These stones can increase and may cause blockages in the urinary tract.',
                                  size: 14,
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Uric Acid Stones",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                    child: myText(
                                  textName: 'Uric acid stones more frequently occur in men than in women who don ‘t drink enough water or who consume a lot of animal proteins.Additionally, they are more likely to develop in patients with gout, who have a family history of these kidney stones, or who have undergone chemotherapy.',
                                  size: 14,
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Cystine Stones",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                    child: myText(
                                  textName: 'Uric acid stones are composed of uric acid crystals and can form in individuals with high uric acid levels in their urine. Conditions like gout, certain metabolic disorders, and a high-purine diet can increase the risk of uric acid stone formation.',
                                  size: 14,
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "Other Stones",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          myText(textName: "If you are suffering from persistent refractive error-related discomfort in your eyes and having issues related to your vision. Then Aapkacare Health is here to help you. We will appoint you with the best surgeons near you and will make your LASIK surgery a hassle-free one. Your care will be arranged before, during, and after the procedure by our eye surgeons at an affordable price.", size: 14),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomRichText(
                                            regularSize: 14,
                                            boldSize: 14,
                                            boldText: "• Xanthine Stones: ",
                                            regularText: "These stones are made of xanthine, a substance produced by specific metabolic processes. They are rare.",
                                          ),
                                          CustomRichText(
                                            regularSize: 14,
                                            boldSize: 14,
                                            boldText: "• Drug-Induced Stones:  ",
                                            regularText: " Some medications can lead to the formation of kidney stones, particularly when they alter the composition of urine.",
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/kidney/12.png',
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
                          ),
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
                    heading: 'Identify the Signs of Hernia',
                    questions: [
                      'What',
                      'When'
                    ],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What happens if Kidney Stones are left untreated?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Leaving a kidney stone untreated can lead to various complications and health problems. The specific consequences of not addressing a kidney stone depend on factors such as the size and location of the rock, the individual\'s overall health, and any underlying conditions. Here are some potential complications of untreated kidney stones:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '1.Pain and Discomfort: ',
                            regularText: ' Kidney stones, commonly called renal colic, can cause severe and excruciating pain.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '2.Urinary Tract Infections (UTIs): ',
                            regularText: ' Kidney stones can obstruct the urinary tract, creating stagnant urine and providing a breeding ground for bacteria. ',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '3. Blockage and Hydronephrosis:',
                            regularText: '  Larger kidney stones or stones lodged in the urinary tract can obstruct urine flow.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '4.Kidney Damage:',
                            regularText: ' If a stone remains untreated and continues obstructing the urinary tract, it can cause kidney damage. Prolonged obstruction can impair kidney function and potentially lead to chronic kidney disease (CKD) or kidney failure.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '5. Complications from Infection Stones (Struvite Stones):',
                            regularText: ' Struvite stones are associated with urinary tract infections. If left untreated, these stones can increase and cause severe complications, including kidney abscesses or sepsis (a potentially life-threatening condition that can spread throughout the body).',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '6. Spread of Infection: ',
                            regularText: ' Infection stones and associated urinary tract infections can spread disease to other parts of the urinary system and, in severe cases, to the bloodstream.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '7. Scarring and Permanent Damage: ',
                            regularText: ' Prolonged irritation and obstruction caused by kidney stones can lead to scarring in the urinary tract, potentially causing long-term issues with urine flow and kidney function.',
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
                            ' When to consult a kidney stones doctor?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Severe Pain:  ',
                            regularText: 'Kidney stones are often associated with intense pain, commonly called renal colic.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Painful Urination: ',
                            regularText: 'Some people with kidney stones may experience discomfort or pain while urinating.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Blood in Urine: ',
                            regularText: 'Kidney stones can cause blood to appear in the urine.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Nausea and Vomiting:',
                            regularText: '  Nausea and vomiting can be experienced if a person has kidney stones.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Painful Flank:  ',
                            regularText: 'Pain from kidney stones can be felt on one side of the body, often in the lower back or side.',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Fever and Chills: ',
                            regularText: 'Kidney stones can lead to infection, which may result in fever and chills.',
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
                                  toggle('Question7');
                                },
                                headingName: "Types of Kidney Stone Surgeries We Provide",
                              ),
                              if (questionStates['Question7']!)
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    myText(
                                      textName: 'Aapkacare Health is committed to providing hassle – free kidney stone removal surgeries in the best facilities with individualized care.It is a patient – centered, technology – driven healthcare service provider.Consult our skilled urology surgeons to choose a stress – free, cost – effective, highly advanced kidney stone removal technique before it worsens.',
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    myText(
                                      textName: 'Retrograde Intrarenal Surgery:',
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    myText(
                                      textName: 'The cutting – edge procedure known as RIRS(Retrograde Intrarenal Surgery) is used to treat kidney stones that are 8 mm to 15 mm in size.The anaesthesia professional will first administer a spinal or general anaesthetic based on the patient ‘s request for kidney stone painless treatment.Under spinal anaesthesia, the patient is numb below the waist while undergoing kidney stone surgery.While under general anaesthesia, the patient is fully unconscious.',
                                      size: 14,
                                    ),
                                    myText(
                                      textName: 'The urologist then uses an endoscope that is flexible and thin with a tiny laser on the other end.The kidney stone surgeon navigates the patient ‘s body to find the stones using imaging methods.The stones are extracted with forceps, and after being divided into smaller pieces with microscopic lasers, they are removed.Following that, the stone particles are eliminated by the urine.',
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    myText(
                                      textName: 'Extracorporeal Shockwave Lithotripsy:',
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    myText(
                                      textName: 'Extracorporeal Shockwave Lithotripsy, often known as ESWL, is a type of shockwave lithotripsy.The doctor uses external shock waves to break down the kidney stone into tiny bits during this minimally invasive technique.A spinal anaesthetic is administered to the patient to lessen the pain after the stones are expelled from the body.It may take several sessions of the conventional technique, ESWL, to completely remove the stones.',
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    myText(
                                      textName: 'Percutaneous Nephrolithotomy:',
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    myText(
                                      textName: 'A minimally invasive treatment for treating kidney stones greater than 15 mm in diameter is called Percutaneous Nephrolithotomy(PCNL).It is sometimes known as “tunnel surgery ” because of the microscopic incisions. Before the surgery, the anesthesiologist administers a general anaesthetic to ensure a pain – free procedure.',
                                      size: 14,
                                    ),
                                    myText(
                                      textName: 'The patient will not be conscious during the surgery.The kidney stone surgeon will then make a 1 cm incision on the flank(lower back area).The kidney stone surgeon locates the stones and breaks them up using a nephroscope.The stone can either be flushed out in its whole or, if it is too large, it can be broken up into smaller pieces.',
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    myText(
                                      textName: 'Ureteroscopic Lithotripsy:',
                                      size: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    myText(
                                      textName: 'The patient receives a spinal or general anaesthetic during URSL(Ureteroscopic Lithotripsy).A ureteroscope, a small tube with a camera and laser on the other end, is then inserted into the ureter by the kidney stone surgeon.The stones are located by the camera, and the laser then breaks them into smaller pieces.These are then flushed out while urinating.The urologist inserts stents into the ureter to widen the ureter opening and make it easier for stones to flow through.',
                                      size: 14,
                                    ),
                                  ],
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question8');
                                },
                                headingName: "Prepare for your kidney stone surgery",
                              ),
                              if (questionStates['Question8']!)
                                Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    myText(
                                      textName: 'Uric acid stones are composed of uric acid crystals and can form in individuals with high uric acid levels in their urine. Conditions like gout, certain metabolic disorders, and a high-purine diet can increase the risk of uric acid stone formation.',
                                      size: 14,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomRichText(
                                      boldText: '• ',
                                      regularText: 'Blood tests',
                                      boldSize: 16,
                                    ),
                                    CustomRichText(
                                      boldText: '• ',
                                      regularText: 'KUB X – ray(Kidney, ureter, bladder)',
                                      boldSize: 16,
                                    ),
                                    CustomRichText(
                                      boldText: '• ',
                                      regularText: 'Ultrasonography',
                                      boldSize: 16,
                                    ),
                                    CustomRichText(
                                      boldText: '• ',
                                      regularText: 'A CT scan or MRI gives a clear picture of the abdomen and pelvictissues.',
                                      boldSize: 16,
                                    ),
                                  ],
                                )).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question9');
                                },
                                headingName: "Kidney Stone Facts",
                              ),
                              if (questionStates['Question9']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          CustomRichText(
                                            boldText: '• ',
                                            regularText: 'People between the ages of 20 and 50 are most susceptible to kidney stones.',
                                            boldSize: 16,
                                          ),
                                          CustomRichText(
                                            boldText: '• ',
                                            regularText: 'The National Institute of Diabetes and Digestive and Kidney Diseases(NIDDK) states that men are more likely than women to develop kidney stones.',
                                            boldSize: 16,
                                          ),
                                          CustomRichText(
                                            boldText: '• ',
                                            regularText: 'Due to the fact that kidney stone occurrence runs in families, genetics may potentially be a factor.',
                                            boldSize: 16,
                                          ),
                                          CustomRichText(
                                            boldText: '• ',
                                            regularText: 'Dehydration, obesity, a diet high in protein, salt, or glucose, hyperparathyroidism, gastric bypass surgery, inflammatory bowel illnesses that enhance calcium absorption, and taking certain medications are some of the additional risk factors.',
                                            boldSize: 16,
                                          ),
                                          CustomRichText(
                                            boldText: '• ',
                                            regularText: 'Consumption of medication such as triamterene diuretics, antiseizure drugs, and calcium – based antacids increases inflammatory bowel diseases.',
                                            boldSize: 16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/circumcision/Benefits.jpg',
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
