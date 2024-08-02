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

class Lipoma extends StatefulWidget {
  const Lipoma({super.key});

  @override
  State<Lipoma> createState() => _LipomaState();
}

class _LipomaState extends State<Lipoma> {
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
                                  'Affordable Lipoma Surgery',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Lipoma surgery and have a healthy life at an affordable price with the best doctors in Pune? Get all kinds of Varicocele consultations for your surgery. Here at Aapkacare Health, we will provide the best surgeons. ',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Are you seeking effective treatment for lipomas? This comprehensive guide will provide essential information on lipoma treatment, signs, surgical options, and post-treatment care. Whether dealing with your first lipoma or exploring treatment options, we’ve got you covered.',
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
                                    circleCheck(text: 'Advanced Liposuction'),
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

                  // what
                  LeftRightData(
                    rightImage: 'assets/lipoma/1.png',
                    heading: 'What is Lipoma?',
                    description: 'A lipoma is a fatty mass (bulge) between your skin and the deeper layer of muscle that is slow-growing. Although they can develop in any area of the body, lipomas usually affect the shoulders, forearms, arms, and thighs. Lipoma typically manifests as little, floppy lumps. Pressing it could make it feel doughy. Lipomas usually don’t hurt, but they can especially when they rub against surrounding nerves or have blood arteries running through them.',
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
                          textName: "Identifying the signs of Lipoma",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        20.heightBox,
                        myText(
                          textName: "Lipomas are typically small, soft, and non-cancerous growths beneath the skin. These benign tumors may not cause pain but can be uncomfortable or unsightly. Common signs and symptoms include:",
                          size: 18,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/lipoma/6.png", headingName: "", detailName: "A soft, movable lump under the skin."),
                            ReasonBox(image: "assets/lipoma/7.png", headingName: "", detailName: "Slow growth over time."),
                            ReasonBox(image: "assets/lipoma/8.png", headingName: "", detailName: "Often found on the neck, shoulders, back, or arms."),
                            ReasonBox(image: "assets/lipoma/9.png", headingName: "", detailName: "Generally painless, but discomfort may occur if pressing on nerves or muscles."),
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
                            CausesBox(image: "assets/lipoma/4.png", headingName: "Dercum ‘s disease", detailName: "Most frequently affecting the arms, legs, and chest, this uncommon condition causes painful lipomas to develop.Adiposis dolorosa and Anders ‘ syndrome are other names for it."),
                            CausesBox(image: "assets/lipoma/5.png", headingName: "Madelung ‘s disease", detailName: "Men who consume large amounts of alcohol are most likely to develop this illness.Madelung ‘s disease, also known as multiple symmetric lipomatosis, causes lipomas to develop around the shoulders and neck."),
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
                                textName: "Variety of Kidney Stones",
                                size: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              30.heightBox,
                              myQuestion(
                                onTap: () {
                                  toggle('Question1');
                                },
                                headingName: "Conventional",
                              ),
                              if (questionStates['Question1']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'White fat cells make up the most typical form of lipoma.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question2');
                                },
                                headingName: "Angiolipoma",
                              ),
                              if (questionStates['Question2']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "This kind has blood vessels and fat.Angiolipomas frequently cause pain.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question3');
                                },
                                headingName: "Fibrolipoma",
                              ),
                              if (questionStates['Question3']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "This type of lipoma is made up of fibrous tissue and fat.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question4');
                                },
                                headingName: "Hibernoma",
                              ),
                              if (questionStates['Question4']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A type of lipoma that contains brown fat.Brown fat cells produce heat and assist in controlling body temperature.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question5');
                                },
                                headingName: "Myelolipoma",
                              ),
                              if (questionStates['Question5']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        textName: "This type of lipoma contains fat as well as tissues that create blood cells.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question6');
                                },
                                headingName: "Spindle-cell",
                              ),
                              if (questionStates['Question6']!)
                                Container(
                                  child: Column(
                                    children: [
                                      myText(
                                        size: 16,
                                        textName: 'These lipomas have spindle – shaped fat cells, which are longer than they are wide.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question7');
                                },
                                headingName: "Pleomorphic",
                              ),
                              if (questionStates['Question7']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "The fat cells in these lipomas come in a variety of sizes and forms.",
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
                            'assets/lipoma/2.png',
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

                  // Explain
                  Questions(
                    image: 'assets/what.jpg',
                    heading: 'Treatment Options',
                    questions: [],
                    questionContents: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Watchful Waiting: ',
                            regularText: 'Lipomas are often harmless and can be left untreated unless they cause discomfort or cosmetic concerns. ',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Surgery: ',
                            regularText: 'Surgical removal is a standard treatment for lipomas, especially if they are large, painful, or disfiguring. This procedure is typically performed on an outpatient basis. ',
                          ),
                          CustomRichText(
                            boldSize: 16,
                            regularSize: 16,
                            boldText: '• Aapkacare: ',
                            regularText: 'Aapkacare is a leading healthcare provider specializing in lipoma treatment. They offer a range of treatment options tailored to your specific needs, including non-invasive procedures and expert surgical care.',
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
                                  toggle('Question8');
                                },
                                headingName: "Types of Lipoma Treatments We Provide in Pune",
                              ),
                              if (questionStates['Question8']!)
                                Container(
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "A lipoma normally won ‘t disappear with any kind of therapy. Your doctor might advise lipoma removal surgery if the lipoma bothers you, is painful, or is expanding.Treatments for lipomas include:",
                                        size: 16,
                                      ),
                                      SizedBox(height: 10),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• Surgical Lipoma Removal: ',
                                        regularText: 'Surgical removal of lipomas is a safe and effective method to address troublesome lipomas. The procedure involves:',
                                      ),
                                      myText(
                                        textName: "1. Local anesthesia to numb the area.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "2. An incision over the lipoma.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "3. Careful removal of the lipoma.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "4. Closure of the incision with sutures.",
                                        size: 14,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: '• After Lipoma Treatment: ',
                                        regularText: 'After a surgical procedure or alternative treatment, it’s essential to follow these guidelines for a smooth recovery:',
                                      ),
                                      myText(
                                        textName: "1. Keep the incision area clean and dry.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "2. Take prescribed medications and antibiotics as directed.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "3. Avoid strenuous activities for a specified period.",
                                        size: 14,
                                      ),
                                      myText(
                                        textName: "4. Attend follow-up appointments to monitor your healing progress.",
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question9');
                                },
                                headingName: "Different Types of Liposuctions",
                              ),
                              if (questionStates['Question9']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "The method used for your liposuction surgery will determine how it is carried out.Based on your treatment objectives, the area of your body that has to be treated, and whether you ‘ve had other liposuction operations in the past, your surgeon will choose the best technique for you.",
                                        size: 16,
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Tumescent Liposuction: ',
                                        regularText: 'This is the most popular kind of liposuction.A sterile solution containing a combination of salt water, which helps remove fat, lidocaine, an anaesthetic to decrease discomfort.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Liposuction with ultrasound assistance(UAL): ',
                                        regularText: 'Along with conventional liposuction, this kind of procedure is occasionally used.During UAL, the surgeon places a metal rod beneath your skin that emits ultrasonic energy.This causes the fat cells to burst, breaking down the fat for simpler disposal.A device that may enhance skin contouring and lessen the likelihood of skin damage is used in a new generation of UAL referred to as VASER – assisted liposuction.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Liposuction aided by laser(LAL): ',
                                        regularText: 'In order to remove fat, this procedure uses high – intensity laser light.Through a tiny skin incision, the surgeon inserts a laser fibre to emulsify fat deposits during LAL.Afterward, a cannula is used to remove the fat.',
                                      ),
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Liposuction with power assistance(PAL): ',
                                        regularText: 'A cannula used in this kind of liposuction moves quickly back and forth.The surgeon can remove challenging fat more quickly and simply thanks to this vibration.PAL may occasionally result in reduced discomfort and edema, allowing the surgeon to remove fat with greater accuracy.If you ‘ve previously undergone liposuction, your surgeon might opt for this approach.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question10');
                                },
                                headingName: "Prior to your Lipoma Surgery",
                              ),
                              if (questionStates['Question10']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomRichText(
                                        boldSize: 16,
                                        regularSize: 16,
                                        boldText: 'Procedure for tumescent liposuction: ',
                                        regularText: ':The parts of your body that will undergo liposuction may have circles and lines drawn by the surgeon prior to the liposuction surgery.In order to compare before – and – after pictures, other photos may also be taken. The method used for your liposuction surgery will determine how it is carried out.Based on your treatment objectives, the area of your body that has to be treated, and whether you ‘ve had other liposuction operations in the past, your surgeon will choose the best technique for you.',
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question11');
                                },
                                headingName: "Following the Lipoma Surgery",
                              ),
                              if (questionStates['Question11']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "After the lipoma treatment, you might anticipate some pain, swelling, and bruising.A combination of painkillers and antibiotics may be recommended by your surgeon to lessen the chance of infection. The surgeon might keep your incisions open after the lipoma treatment and insert temporary drains to encourage fluid drainage.Typically, you must put on restrictive compression clothing for a few weeks in order to reduce swelling. After lipoma surgery, you might have to wait a few days to go back to work and a few weeks to carry on with your regular activities, including exercising.As the residual fat settles into place at this time, anticipate minor inconsistencies in the shape. The method used for your liposuction surgery will determine how it is carried out.Based on your treatment objectives, the area of your body that has to be treated, and whether you ‘ve had other liposuction operations in the past, your surgeon will choose the best technique for you.",
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ).pOnly(bottom: 15),
                              myQuestion(
                                onTap: () {
                                  toggle('Question12');
                                },
                                headingName: "Recommendation after Lipoma Surgery",
                              ),
                              if (questionStates['Question12']!)
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        textName: "After lipoma surgery, it will take 10 to 14 days for patched wounds to heal.We request you to refrain from engaging in any strenuous activity or vigorous exercise during this time.The following day, most people are able to return to their offices.In 7 to 10 days, stitches can be taken out.",
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
                            'assets/lipoma/3.jpg',
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
                          'When to Treat a Lipoma',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Deciding when to treat a lipoma depends on several factors, including:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• ',
                          regularText: 'Size and location of the lipoma.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• ',
                          regularText: 'Discomfort or pain it may cause.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• ',
                          regularText: 'Cosmetic concerns.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• ',
                          regularText: 'Changes in the lipoma’s appearance.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Consult a healthcare professional, such as at Aapkacare, to determine the most suitable treatment approach for your case.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lipoma treatment can help alleviate discomfort and address cosmetic concerns. Whether you opt for surgical removal or alternative therapies, seeking expert guidance and post-treatment care is essential for a successful outcome. Aapkacare is here to provide you with tailored lipoma treatment options to ensure your well-being.',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
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
                          description: 'To consult our skilled surgeons for any problems or to undergo  Lipoma Surgery, visit the nearest Lipoma clinic in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Lipoma Surgery in Pune. The Pune Aapkacare Health multi-speciality clinics for Lipoma Surgery are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Lipoma Surgery procedure in Pune.',
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
                    heading: 'Why should you opt for Lipoma Surgery with Aapkacare Health in Pune?',
                    description: 'Aapkacare Health finds you the most affordable prices for your Lipoma  in Pune. Even so, the exact cost is hard to pinpoint since your Lipoma surgery cost depends on various factors such as age, medical history, type of surgery, etc. Call us today to get a personalised cost breakdown.',
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
