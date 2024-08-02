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

class Gallbladder extends StatefulWidget {
  const Gallbladder({super.key});

  @override
  State<Gallbladder> createState() => _GallbladderState();
}

class _GallbladderState extends State<Gallbladder> {
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
                                  'Affordable Gallbladder Stone Surgery in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Gallbladder stones (cholelithiasis) can be silent or cause unbearable pain if they get stuck. Our gallstone specialists in Pune use gallstone surgery (cholecystectomy) to resolve the condition effectively. Consult the best gallstone surgeons in Pune using advanced techniques for gallstone treatment.',
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
                    height: 20,
                  ),

                  // what
                  LeftRightData(
                    rightImage: 'assets/gallbladder/bladder.jpg',
                    heading: 'What Is A Gallbladder Stone?',
                    description: 'Gallbladder stones, also known as gallstones or cholelithiasis, are solid particles that form in the gallbladder, a small organ located just beneath the liver. The gallbladder’s primary function is to store bile, a digestive fluid produced by the liver, and release it into the small intestine to help digest the fats needed. A gallstone can vary in size from tiny grains of sand to larger, golf ball-sized stones. They primarily comprise cholesterol or bilirubin, a pigment produced when red blood cells break down.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Treatment
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
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
                                'Treatment',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Diagnosis',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Diagnosis and treatment of gallbladder stones typically involve a combination of medical evaluation, imaging tests, and, in some cases, medical surgery intervention. Here’s an overview of the process',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Medical History and Physical Examination: ',
                                regularText: 'The doctor will begin by taking a detailed medical history and conducting a physical examination. They will ask about your symptoms, including abdominal pain, digestive issues, or jaundice.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Blood Test: ',
                                regularText: 'A blood test may be ordered to check for elevated liver enzyme and bilirubin levels.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Imaging Tests: ',
                                regularText: 'Various imaging studies can help confirm the presence of gallstones and assess the severity of the condition. Standard imaging tests are: Ultra Sound, CT Scan, MRI, HIDA Scan',
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
                                'assets/gallbladder/gallstone2.png',
                                fit: BoxFit.fill,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // surgery
                  Container(
                    width: s.width,
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: LeftRightData(
                      rightImage: 'assets/gallbladder/i.png',
                      heading: 'Surgery (Cholecystectomy)',
                      description: 'If Gallstone is causing symptoms or complications, the most common treatment is the surgical removal of the gallbladder, known as cholecystectomy. This procedure can be performed using minimally invasive laparoscopic techniques or open surgery, depending on the patient’s condition. Treatment choice depends on the specific circumstances, including the size and location of the stone, the severity of symptoms, and the patient’s overall health. It’s essential to consult with a healthcare provider for a proper evaluation and individualized treatment plan if you suspect you have gallbladder stones or are experiencing symptoms. Left untreated, gallstones can lead to potentially serious complications.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // best treatment
                  LeftRightData(
                    leftImage: 'assets/appendicitis/woman.jpg',
                    heading: 'Best Treatment for Gallstone in Pune at Aapka Care',
                    description: 'Laparoscopy is the best treatment for Gallstones in Pune, even if the treatment involves the removal of the gallbladder. Here at Aapka Care, we will provide you with the best surgeon and facilities at a reasonable price for laparoscopy. We have a success rate of 90%. You get the appointments and treatment in a hassle-free way. If you seek gallstone treatment in Pune, aapka Care is your best option. We are one of the leading and best healthcare services in Pune. Book an appointment and consult with the specialist today to get more information about the treatment and surgeons.',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // best surgery
                  Container(
                    width: s.width,
                    color: Colors.blue[50],
                    child: LeftRightData(
                      rightImage: 'assets/gallbladder/i2.png',
                      heading: 'Best Treatment for Gallstone in Pune- Laparoscopic Surgery',
                      description: 'Laparoscopy, or minimally invasive or keyhole surgery, is a surgical treatment for gallstones. If you are looking to get the treatment and are a Pune resident, then Aapka Care is your go-to option for the surgery. The surgery that used to take 1 to 2 hours can now be done in 30 to 45 minutes with the help of a laparoscope. A surgical technique that allows a surgeon to perform operations through small incisions (usually 0.5 to 1.5 centimeters in length) using specialized instruments and a camera. The camera, called a laparoscope, is inserted through one of the incisions and provides a high-definition view of the surgical area on a monitor. This technology allows for precise and less invasive surgical procedures than traditional open surgery.Laparoscopy has revolutionized the field of surgery and is widely used for various procedures due to its benefits in patient recovery and cosmetic outcomes. However, the suitability of laparoscopy for a particular surgery depends on the specific case and the surgeon’s expertise. Patients should discuss the surgical approach with their healthcare provider to determine the most appropriate method.',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // How
                  LeftRightData(
                    rightImage: 'assets/gallbladder/i3.jpg',
                    heading: 'How do gallstones form?',
                    description: 'Gallstones form when there is an imbalance in the substances that make up bile, a digestive fluid produced by the liver and stored in the gallbladder. Bile primarily comprises water, bile salts, cholesterol, and bilirubin. When there is excessive cholesterol, bilirubin, or other components in the bile, or when the gallbladder does not empty properly, gallstones can develop. There are two types of Gallstone:',
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //different type
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 150 * s.customWidth),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'What are the different types of gallbladder stones?',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Types of gallstones differ in their composition,appearance, and formation causes. Here’s a closer look at each type:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Cholesterol Stones: ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Composition: ',
                          regularText: 'Cholesterol stones are the most common type of gallstones. They are primarily composed of cholesterol, a fatty substance.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Appearance: ',
                          regularText: 'Cholesterol stones tend to be yellow or pale in color and are often round or oval.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Formation: ',
                          regularText: ' Cholesterol stones form when there is an imbalance in the composition of bile, with an excess of cholesterol relative to the amount of bile salts and lecithin (a phospholipid). This imbalance can cause cholesterol to crystallize and aggregate into stones.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Risk Factors: ',
                          regularText: 'Risk factors for cholesterol stone formation include a high-fat diet, obesity, genetics, and certain medical conditions that affect cholesterol metabolism.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Pigment Stones: ',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Composition: ',
                          regularText: ': Pigment stones are smaller and darker than cholesterol stones. They primarily comprise bilirubin, a pigment produced when red blood cells break down.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Appearance: ',
                          regularText: 'Pigment stones can vary in color, ranging from dark brown to black.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Formation: ',
                          regularText: ' Pigment stones typically form when there is an excess of bilirubin in the bile. This can occur due to cirrhosis, hemolysis (the rapid breakdown of red blood cells), or biliary tract infections. Bilirubin can precipitate and form pigment stones.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '•  Risk Factors: ',
                          regularText: 'Conditions that increase bilirubin production or reduce the ability to excrete bilirubin can increase the risk of pigment stone formation.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The type of Gallstone can be determined through imaging studies or laboratory analysis of gallstone fragments if they are removed during surgery. The choice of treatment and prevention strategies may vary depending on the type and composition of the gallstones and the patient\'s overall health and symptoms.',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // why
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
                                'Why should gallbladder stones not be left untreated?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'If left untreated, gallbladder stones can lead to complications and potentially severe health problems. Here are some reasons why gallbladder stones should not be left untreated: ',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Gallbladder Attacks:  ',
                                regularText: ' One of the most common and painful complications of gallstones is a gallbladder attack. These attacks occur when a gallstone blocks the neck of the gallbladder or the cystic duct, preventing bile flow. The resulting pressure and inflammation can cause sudden and severe abdominal pain, nausea, vomiting, and other digestive symptoms.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Cholecystitis:',
                                regularText: 'If a gallstone obstructs the cystic duct for an extended period, it can lead to gallbladder inflammation, a condition known as cholecystitis. Cholecystitis can be extremely painful and may require hospitalization for treatment, including antibiotics and, in some cases, surgical removal of the gallbladder.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Pancreatitis: ',
                                regularText: 'In some cases, gallstones can pass from the gallbladder into the common bile duct, leading to a blockage of the pancreatic duct. This can result in pancreatitis, which is inflammation of the pancreas. Acute pancreatitis is a potentially life-threatening condition that can cause severe abdominal pain, digestive issues, and systemic complications.',
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/w2.jpg'),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Bile Duct Obstruction: ',
                                regularText: 'Gallstones can migrate into the bile ducts, causing a blockage. When the common bile duct is obstructed, it can lead to jaundice (yellowing of the skin and eyes), dark urine, and pale stools. This can also result in infection, known as cholangitis, which is a severe medical emergency.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Gallstone Ileus:  ',
                                regularText: 'In rare cases, a large gallstone can erode through the wall of the gallbladder and enter the intestine, causing an obstruction. This condition is called gallstone ileus and can lead to bowel obstruction, abdominal pain, and surgical intervention.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  Complications in High-Risk Groups: ',
                                regularText: 'Certain groups of people, such as the elderly and those with underlying health conditions, are at a higher risk of gallstone complications. For them, prompt treatment is essential.',
                              ),
                              SizedBox(height: 20),
                              Text(
                                'The most common and effective treatment for gallstones that cause symptoms or complications is surgical removal of the gallbladder, known as cholecystectomy. This procedure is generally safe and minimally invasive when done laparoscopically. ',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
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
                                'assets/gallbladder/i4.jpg',
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
                                'Prevention of Gallbladder Stones',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'It is mostly our lifestyle that increases the risk of gallbladder stone formation. Therefore, you can prevent gallstones by making the following changes in your daily life:',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Do not skip meals- ',
                                regularText: 'Try your best to stick with the usual meal times each day. Skipping meals can cause excess bile secretion and deposition.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Lose weight slowly- ',
                                regularText: ' Being overweight is a risk factor for gallstone development. So, if you are trying to lose weight, take things slow. Don’t push your body to its limits in order to lose weight as rapid weight loss can cause the liver to secrete extra cholesterol, which can further increase the risk of gallstones.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Eat high-fiber foods-',
                                regularText: 'Foods that are rich in fiber ensure that the levels of bad cholesterol in the body are minimal. Furthermore, fiber keeps the digestive system moving and helps to flush out the bile from the body. Therefore, it is crucial that you add more fiber to your diet.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Exercise regularly-',
                                regularText: 'It doesn’t necessarily mean that you have to do an extensive workout, being physically active is enough. The less you move, the slower the digestion process will be. As a result, the bile won’t flush out correctly. Invest some time in exercising and leave the sedentary lifestyle behind.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Take prescribed medications-',
                                regularText: ' People who are at high risk of developing gallstones due to heredity or other factors can take medicines to lower the risk of gallstone formation.',
                              ),
                              SizedBox(height: 20),
                              Text(
                                'You can talk to a gallstone specialist to find out what else you can do to prevent gallstones.',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 20),
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
                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 50 : 100),
                    alignment: AlignmentDirectional.center,
                    color: Colors.blue[50],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          spacing: s.width < 1024 ? 0 : 50,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: [
                            Container(
                              width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Dietary Changes for Gallstones',
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 20),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '• Low-Fat Diet ',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '•  High Fiber Diet',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '• Healthy Fats ',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '•  Small, Frequent Meals',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '•  Avoid Rapid Weight Loss',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '• Hydration ',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '•  Avoid Trigger Foods',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '• Monitor for Food Intolerances',
                                    regularText: '',
                                  ),
                                  CustomRichText(
                                    boldSize: 16,
                                    boldText: '• Consult a Registered Dietitian',
                                    regularText: '',
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'It is important to note that dietary changes alone may not always prevent gallstone-related symptoms or complications, especially if gallstones are large or if you have underlying medical conditions.',
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Container(
                                width: s.width < 1024 ? s.width : 500,
                                height: s.width < 720 ? 200 : 300,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/what.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'About our Doctors & Hospitals',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ).pSymmetric(h: s.width < 1024 ? 20 : 100),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'At Aapkacare Health we provide well-experienced and highly qualified doctors to give you the most accurate diagnosis and health care advice.',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ).pSymmetric(h: s.width < 1024 ? 20 : 100),
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
