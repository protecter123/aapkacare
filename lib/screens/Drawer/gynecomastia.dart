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

class Gynecomastia extends StatefulWidget {
  const Gynecomastia({super.key});

  @override
  State<Gynecomastia> createState() => _GynecomastiaState();
}

class _GynecomastiaState extends State<Gynecomastia> {
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
                                  'Affordable Gynecomastia Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Sometimes certain diseases and medications can cause the breast tissue to swell and grow larger resulting in gynecomastia. Consider a breast reduction surgery if this condition causes you to feel self-conscious. The entire goal of cosmetic surgery is to improve a patient’s aesthetic appearance. Aapkacare Health’s top cosmetic surgeons can help you go through the procedure conveniently.',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 10,
                                  children: [
                                    circleCheck(text: '45 Min Procedure'),
                                    circleCheck(text: 'Advanced Liposuction'),
                                    circleCheck(text: 'Free Pick Up & Drop'),
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
                    height: 20,
                  ),

                  // what
                  LeftRightData(
                    rightImage: 'assets/gynecomastia/4.png',
                    heading: 'What is Gynecomastia?',
                    description: 'Gynecomastia is a medical condition characterized by the enlargement of breast tissue in males. It can occur in one or both breasts and often results in a more feminine appearance of the chest. Gynecomastia is relatively common and can affect males of all ages, from infants to adults.',
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
                          textName: "Identify the Signs of Gynecomastia",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/gynecomastia/1.png", headingName: "Swollen or Enlarged Breasts", detailName: "Gynecomastia typically involves the development of glandular breast tissue beneath the nipple area."),
                            ReasonBox(image: "assets/gynecomastia/8.png", headingName: "Tenderness or Pain", detailName: "Some individuals with Gynecomastia may experience tenderness or discomfort in the affected breast tissue."),
                            ReasonBox(image: "assets/gynecomastia/3.png", headingName: "Uneven Breast Growth", detailName: "Gynecomastia can affect one or both breasts and sometimes, there may be uneven growth, with one breast more affected than the other."),
                            ReasonBox(image: "assets/gynecomastia/6.png", headingName: "Nipple Changes", detailName: " Gynecomastia can cause changes in the nipples."),
                            ReasonBox(image: "assets/gynecomastia/7.png", headingName: "Psychological Impact", detailName: " Gynecomastia can have a psychological impact, causing distress, self-esteem issues, and body image concerns, especially in adolescents and young adults."),
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
                                textName: "Identify the Signs of Gynecomastia",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Hormone imbalance",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Hormonal changes are one of the most common causes of Gynecomastia. During puberty, the hormonal balance shifts, and it can result in temporary breast tissue enlargement. Hormonal imbalances in adult men can also occur due to aging, leading to similar changes.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Obesity",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Excess body fat can lead to increased levels of estrogen in the body because fat tissue can convert testosterone to estrogen. This hormonal imbalance can contribute to Gynecomastia in obese individuals.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Medications",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Several medications can cause Gynecomastia as a side effect. These may include certain antipsychotic drugs, anti-androgens (used in prostate cancer treatment), some antibiotics, anti-ulcer medications (such as cimetidine), and certain cardiovascular medications.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Pubertal Gynecomastia",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "Gynecomastia is relatively common during puberty due to hormonal fluctuations. It typically resolves on its own as hormonal balance stabilizes.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Aging",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        textName: " As men age, there is a natural decline in testosterone levels, which can contribute to an increased risk of developing Gynecomastia.",
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
                            'assets/gynecomastia/2.png',
                            width: s.width / (s.width < 1024 ? 1.2 : 3),
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
                          'How is Gynecomastia treated?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Here are some common approaches to treating Gynecomastia:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Medication : ',
                          regularText: ' In some cases, especially if hormonal imbalances cause Gynecomastia, medication may be prescribed. The most commonly used medication for Gynecomastia is tamoxifen, which can help reduce breast tissue growth.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Surgery: ',
                          regularText: 'Surgery is often the most effective treatment for moderate to severe Gynecomastia. There are two main surgical procedures',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '-  Liposuction: ',
                          regularText: 'Liposuction is used to remove excess fat from the breast area. It is particularly effective for cases where Gynecomastia is primarily due to excess fat.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '– Surgical excision: ',
                          regularText: 'Surgical excision is necessary for cases involving excess breast tissue and epithelial growth. This procedure involves making an incision and removing the excess tissue. Depending on the extent of the surgery, scarring may be minimal to more noticeable.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Combination therapy: ',
                          regularText: ' In some cases, a combination of liposuction and surgical excision may be performed to achieve the best results.',
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // sings
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
                          textName: "What happens when Gynecomastia is left untreated?",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        20.heightBox,
                        myText(
                          textName: "Gynecomastia, when left untreated, can result in various physical and psychological consequences. The impact of untreated Gynecomastia can vary depending on the underlying cause, the severity of the condition, and individual factors. Here are some potential implications of leaving Gynecomastia untreated",
                          size: 18,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(headingName: "Physical discomfort", detailName: "Enlarged breast tissue can be physically uncomfortable or painful, particularly if it becomes tender or sensitive. This discomfort may persist or worsen if Gynecomastia is not addressed."),
                            ReasonBox(headingName: "Worsening of the condition", detailName: " In some cases, Gynecomastia may progress and become more pronounced over time. The state may become more severe if the underlying cause is not addressed."),
                            ReasonBox(headingName: "Complications from the underlying cause", detailName: "Gynecomastia can sometimes be a sign of an underlying medical condition, such as hormonal imbalances or certain medications. If these underlying causes are not addressed, they may lead to further health issues."),
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
                          'Diagnosis',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The diagnosis of Gynecomastia typically involves a combination of medical history, physical examination, and sometimes additional tests. Here’s how Gynecomastia is diagnosed:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Medical History: ',
                          regularText: 'Aapkacare Healthcare  will start by taking a detailed medical history. They will ask about your symptoms, how long you’ve had them, any medications you’re taking, any underlying medical conditions, and your family history. It’s essential to be honest and provide as much information as possible.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  Physical Examination: ',
                          regularText: 'The next step is a physical examination. During this examination, the healthcare provider will assess your breast tissue, looking for signs of Gynecomastia. They will examine the size, shape, and consistency of the breast tissue to differentiate it from other conditions. Gynecomastia is typically characterized by firm, rubbery, or nodular tissue beneath the nipple.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Differential Diagnosis: ',
                          regularText: 'Gynecomastia must be distinguished from other conditions that can cause breast enlargement. This may include pseudogynecomastia (enlarged breasts due to excess fat, not glandular tissue) and other breast disorders, including breast cancer.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  Blood Tests: ',
                          regularText: 'In some cases, blood tests may be ordered to assess hormone levels. Gynecomastia is often associated with hormonal imbalances, and blood tests can help determine if there are elevated levels of estrogen (female hormone) or reduced levels of testosterone (male hormone).',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Imaging Studies: ',
                          regularText: ' In certain situations, imaging studies like mammography, ultrasound, or magnetic resonance imaging (MRI) may be recommended.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  Biopsy: ',
                          regularText: ' If there are concerns about breast cancer or the diagnosis remains unclear, a biopsy may be performed.',
                        ),
                        SizedBox(height: 20),
                      ],
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
                                  toggle('Question6');
                                },
                                headingName: "Types of Gynecomastia Surgeries",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'Hormonal changes are one of the most common causes of Gynecomastia. During puberty, the hormonal balance shifts, and it can result in temporary breast tissue enlargement. Hormonal imbalances in adult men can also occur due to aging, leading to similar changes.',
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Liposuction: ',
                                        regularText: 'Liposuction is a common technique for treating Gynecomastia when the breast enlargement is primarily due to excess fat without significant glandular tissue. It involves making small incisions in inconspicuous locations, such as around the areola or in the underarm area, and then using a thin tube (cannula) to suction out the excess fat. This technique is less invasive and typically results in minimal scarring.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Excision Surgery: ',
                                        regularText: ' Excision surgery is performed when there is a substantial amount of glandular breast tissue that needs to be removed. This technique is often necessary for more severe cases of Gynecomastia. It involves making incisions around the areola or in other discreet locations and removing the excess glandular tissue. Excision surgery may also include resizing or repositioning the areola if necessary.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Combination Surgery: ',
                                        regularText: ' In many cases, a combination of liposuction and excision surgery is used to address both the excess fat and glandular tissue. This approach is customized to each patient’s specific needs and aims to achieve a more balanced and natural appearance.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question7');
                                },
                                headingName: "Recommendations after gynecomastia surgery",
                              ),
                              if (questionStates['Question7']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "After undergoing gynecomastia surgery, it’s essential to follow your surgeon’s post-operative care instructions for a safe and successful recovery. Here are some general guidelines for what to expect and how to care for yourself after gynecomastia surgery",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Dressings and Compression Garments :',
                                        regularText: ' You will likely have dressings and compression garments applied to the surgical site.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Rest and Recovery: ',
                                        regularText: ' It’s essential to get plenty of rest during the initial recovery period. Avoid strenuous activities and exercise for the first few weeks. Our surgeons will provide guidelines for when you can gradually resume normal activities.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Swelling and Bruising: ',
                                        regularText: ' Swelling and bruising are common after gynecomastia surgery. These side effects will gradually subside over time.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Incision Care: ',
                                        regularText: ' If you have sutures, they may need to be removed at a follow-up appointment. Proper care of incisions is crucial to minimize scarring. Follow your surgeon’s instructions for cleaning and caring for your incisions. ',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Dietary Considerations: ',
                                        regularText: ' Maintain a healthy diet and stay well-hydrated to support the healing process. Avoid alcohol and tobacco, as they can interfere with healing.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Follow-Up Appointments: ',
                                        regularText: ' You will have follow-up appointments with your surgeon to monitor your progress and ensure that the healing process is proceeding as expected. Aapkacare Health will provide you with all kinds of follow-up advice from the best surgeons in Pune. ',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Sun Protection: ',
                                        regularText: ' Protect the surgical area from direct sun exposure, as excessive sun exposure can worsen the appearance of scars. Use sunscreen or cover the area with clothing when outdoors.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question8');
                                },
                                headingName: "Benefits of Gynecomastia Surgery",
                              ),
                              if (questionStates['Question8']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "As the physical appearance is hampered by swollen breasts, a majority of the male population that experiences this problem lacks confidence.Additionally, most of the time, exercising does not help to improve this graded condition.According to a gynecomastia surgeon in Chennai, gynecomastia surgery is the only treatment option that may easily fulfill the desire to have a flawless male physique.The following is a list of a few additional clear advantages of gynecomastia treatment in \$ Pune:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Self Enhancement: ',
                                        regularText: 'Gynecomastia has a number of adverse effects.Depression caused by mental trauma is one of these negative effects.Gynecomastia surgery, on the other hand, can remodel the figure and increase their confidence. ',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Reduces back discomfort: ',
                                        regularText: 'Breast expansion puts more pressure on the back muscles, which causes sharp back pain.The spine can become malformed and permanently scarred as gynecomastia becomes more severe.Gynecomastia treatment thereby reduces back pain and also minimises the possibility of spinal problems.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Numerous clothing possibilities: ',
                                        regularText: 'Due to fitting concerns, most gynecomastia sufferers avoid shopping and have few options for attire.However, after gynecomastia therapy, people can easily fit into better clothing and feel more at ease.Furthermore, only one day of dressing is needed because there are sores that need to heal.The healing process at the gynecomastia surgery site is accelerated by laser energy as well.It just takes a few days to recuperate from laser surgery for gynecomastia. ',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Recovery time:  ',
                                        regularText: 'The adoption of affordable and advanced cutting – edge techniques guarantees a secure simple and quick recovery.Although minor bruising and swelling may be seen during the first few days after surgery, there is no pain right away.This naturally decreases when the body heals itself.Daily routines can be resumed the following day, whereas desk jobs can be resumed three days later.The adoption of affordable and advanced cutting – edge techniques guarantees a secure simple and quick recovery.Although minor bruising and swelling may be seen during the first few days after surgery, there is no pain right away.This naturally decreases when the body heals itself.Daily routines can be resumed the following day, whereas desk jobs can be resumed three days later.After two weeks, you can resume weightlifting and other strenuous exercises after visiting your gynecomastia doctor.Your body will be back to “normal” by the end of 6 to 8 weeks, and you can resume most of your activities after consulting with your gynecomastia surgeon.Patients must adhere to all pre – and post – operative instructions given by their gynecomastia surgeon in order to recover fully from any operation.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question9');
                                },
                                headingName: "Growing age",
                              ),
                              if (questionStates['Question9']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "When growing older, men start producing less testosterone and gain more body fat, resulting in enhanced production of oestrogen, thereby, gynecomastia. Hormonal imbalance from falling levels of testosterone and rising oestrogen levels Extra weight can lead to increased levels of oestrogen and cause breast tissue to grow Exposure to the mother ‘s oestrogen can cause breast development in newborns Irregular variation in hormonal levels during puberty Decreased production of testosterone with growing age Side – effects of certain drugs",
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
                            'assets/gynecomastia/5.png',
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
                          description: 'To consult our skilled surgeons for any problems or to undergo gynecomastia surgery, visit the nearest gynecomastia clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top gynecomastia surgeons in Pune. The Pune Aapkacare Health multi-speciality clinics for gynecomastia surgery are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced gynecomastia surgery procedure in Pune.',
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
                    heading: 'Are you worried about the cost of Gynecomastia treatment?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Gynecomastia in Pune. Even so, the exact cost is hard to pinpoint since your Gynecomastia surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
