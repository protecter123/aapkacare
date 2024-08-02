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

class Prostate extends StatefulWidget {
  const Prostate({super.key});

  @override
  State<Prostate> createState() => _ProstateState();
}

class _ProstateState extends State<Prostate> {
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
                                  'Affordable Prostate Enlargement in Pune',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Want to go through Prostate Enlargement surgery and have a healthy life at an affordable price with the best doctors in Mumbai? Get all kinds of BPH consultations for your eye surgery. Here at Aapkacare Health, we will provide the best urologists.',
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
                    rightImage: 'assets/kidney/19.jpg',
                    heading: 'What is BPH?',
                    description: 'Benign Prostate Hyperplasia (BPH), also known as benign prostatic hyperplasia, is a common medical condition affecting men’s prostate gland. The prostate is a walnut-sized gland that surrounds the urethra, the tube that carries urine from the bladder to the penis. BPH is a non-cancerous (benign) prostate gland enlargement that occurs as men age. It is not related to prostate cancer.',
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
                          textName: "Understanding the Signs of Benign Prostate Hyperplasia.",
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        30.heightBox,
                        Wrap(
                          spacing: 30 * s.customWidth, runSpacing: 20, alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReasonBox(image: "assets/kidney/9.png", headingName: "Increased Frequency of Urination", detailName: "Men with BPH often need to urinate more frequently than usual. This can include more frequent trips to the bathroom during the day and night."),
                            ReasonBox(image: "assets/kidney/1.png", headingName: "Difficulty Initiating Urination", detailName: "It may become more challenging to start urination, and there may be a delay between trying to urinate and the actual urine flow."),
                            ReasonBox(image: "assets/kidney/3.png", headingName: "Weak Urine Stream", detailName: "The force of the urine stream may decrease, resulting in a weaker stream than usual."),
                            ReasonBox(image: "assets/kidney/7.png", headingName: "Dribbling at the End of Urination", detailName: "After urination, some men with BPH may experience dribbling, where urine leaks out."),
                            ReasonBox(image: "assets/kidney/11.png", headingName: "Sensation of Incomplete Emptying", detailName: "Even after urination, some individuals may feel that the bladder is not empty, leading to a persistent sense of urinating."),
                            ReasonBox(image: "assets/kidney/11.png", headingName: "Urgency", detailName: "BPH can lead to a sudden and strong urge to urinate, often making it difficult to hold in the urine when needed."),
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
                            ErrorBox(width: 300, start: true, image: "assets/kidney/6.png", headingName: "Aging", detailName: "BPH is primarily an age-related condition, becoming more common as men age. Changes in hormone levels and cell growth over time may lead to prostate enlargement."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/5.png", headingName: "Hormonal Changes", detailName: "Hormones, particularly dihydrotestosterone (DHT), play a significant role in the growth and maintenance of the prostate gland. Changes in hormone levels as men age can lead to an increase in DHT, stimulating prostate cell growth."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/10.png", headingName: "Family History", detailName: "PH appears to have a genetic component. Men with a family history of BPH or prostate cancer are at a higher risk of developing the condition."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/8.png", headingName: " Testosterone", detailName: "Although often associated with DHT, testosterone may also contribute to prostate growth. Some studies suggest that the body’s balance between testosterone and estrogen may influence prostate enlargement."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/2.png", headingName: "Lifestyle Factors", detailName: "Certain factors may contribute to BPH or exacerbate its symptoms. These factors include obesity, lack of physical activity, and a diet high in red meat and low in fruits and vegetables."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/4.png", headingName: "Ethnicity", detailName: "BPH is more common in certain ethnic groups, such as African American men than others."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/8.png", headingName: "Inflammation", detailName: "Chronic prostate inflammation, a condition known as prostatitis, may sometimes be linked to developing BPH."),
                            ErrorBox(width: 300, start: true, image: "assets/kidney/2.png", headingName: "Medical Conditions", detailName: "Certain medical conditions, such as diabetes and heart disease, may increase the risk of developing BPH or worsen its symptoms."),
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

                  //
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Image.asset('assets/hydrocele/2.jpg'),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Enlarged Prostate Treatment in Pune',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Diagnosis of Benign prostatic hyperplasia (BPH):',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'The diagnosis of Benign Prostatic Hyperplasia (BPH), also known as an enlarged prostate, typically involves a combination of medical history, physical examination, and various tests. Here are the steps involved in diagnosing BPH: ',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Medical History: ',
                                regularText: 'Your doctor will begin by asking about your medical history, including any urinary symptoms you may be experiencing. Be prepared to discuss your symptoms’ nature, severity, duration, and frequency.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Physical Examination: ',
                                regularText: 'A  physical examination may be conducted, which can include a digital rectal examination (DRE). During a DRE, the doctor inserts a gloved, lubricated finger into the rectum to assess the size and condition of the prostate gland.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '•  International Prostate Symptom Score (IPSS): ',
                                regularText: 'You may be asked to complete an IPSS questionnaire. It helps quantify the severity of your urinary symptoms related to BPH.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Urinalysis:',
                                regularText: 'A simple urine test can help rule out urinary tract infections or other issues contributing to your symptoms.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Blood Test: ',
                                regularText: 'A blood test may be performed to check your Prostate-Specific Antigen (PSA) levels. Elevated PSA levels can indicate a problem with the prostate, although it’s not specific to BPH.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Ultrasound: ',
                                regularText: 'Transrectal ultrasound (TRUS) or abdominal ultrasound may be used to create an image of the prostate and assess its size and shape. TRUS is more common as it provides a more detailed view.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Uroflowmetry: ',
                                regularText: 'This test measures the rate and amount of urine flow. It can help assess the severity of obstruction due to an enlarged prostate.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Cystoscopy: ',
                                regularText: ' In some cases, a cystoscopy may be performed. This involves the insertion of a thin, flexible tube with a camera on the end (cystoscope) into the urethra to view the inside of the bladder and urethra.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Pressure Flow Studies: ',
                                regularText: 'In more complex cases or when surgical intervention is being considered, pressure flow studies can be conducted to measure pressure in the bladder and urethra during urination.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Biopsy: ',
                                regularText: 'In rare cases, a prostate biopsy may be performed to rule out the possibility of prostate cancer, especially if the PSA levels are significantly elevated.',
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
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: s.width < 1024 ? 20 : 120 * s.customWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Best Treatment for Enlarged Prostate',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'The treatment for an enlarged prostate, also known as Benign Prostatic Hyperplasia (BPH), depends on the severity of your symptoms, the impact on your quality of life, and overall health. Treatment options range from watchful waiting to various medical and surgical interventions. Your best treatment should be determined in consultation with your healthcare provider. Here are some standard treatment options for BPH',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: ' Watchful Waiting (Active Surveillance):',
                          regularText: ' If your symptoms are mild and not significantly affecting your quality of life, your doctor may recommend a watchful waiting approach. This involves regular monitoring to see if the condition worsens. Lifestyle changes may also be recommended.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: 'Lifestyle Modifications: ',
                          regularText: 'Certain lifestyle changes can help alleviate mild BPH symptoms. These may include limiting fluid intake before bedtime, avoiding caffeine and alcohol, and practicing “double voiding” (urinating twice during one bathroom visit).',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: 'Medications:',
                          regularText: 'Several medications can be used to manage BPH symptoms. These include',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Alpha-Blockers: ',
                          regularText: 'These relax the muscles around the prostate and bladder neck, improving urine flow and relieving symptoms.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• 5-Alpha Reductase Inhibitors:',
                          regularText: 'These medications can shrink the prostate gland over time, reducing urinary symptoms.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Combination Therapy: ',
                          regularText: 'Sometimes, your doctor may prescribe a combination of alpha-blockers and 5-alpha reductase inhibitors for more significant symptom relief.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Phosphodiesterase-5 Inhibitors: ',
                          regularText: 'Medications like tadalafil may help relieve BPH symptoms and erectile dysfunction.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: 'Minimally Invasive Procedures: ',
                          regularText: 'If medications do not provide sufficient relief, minimally invasive procedures can be considered, including',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Transurethral Microwave Therapy (TUMT)',
                          regularText: '',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Transurethral Radiofrequency Needle Ablation (TUNA)',
                          regularText: '',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Water Vapor Thermal Therapy (Rezūm)',
                          regularText: '',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Prostatic Urethral Lift (UroLift)',
                          regularText: '',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: 'Surgery: ',
                          regularText: 'Surgical intervention may be recommended for severe cases or when other treatments are ineffective. Standard surgical procedures for BPH include',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Transurethral Resection of the Prostate (TURP): ',
                          regularText: 'This standard procedure involves removing prostate tissue causing the blockage.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Transurethral Incision of the Prostate (TUIP): ',
                          regularText: 'Instead of removing tissue, this procedure involves making minor cuts in the prostate to relieve pressure on the urethra.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Laser Surgery: ',
                          regularText: 'Various types of laser surgery can vaporize or remove prostate tissue, such as Holmium laser enucleation (HoLEP) or GreenLight laser therapy.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: '• Open Prostatectomy:',
                          regularText: 'Open surgery to remove excess tissue may be necessary in very large prostates.',
                        ),
                        CustomRichText(
                          boldSize: 16,
                          regularSize: 16,
                          boldText: 'Aapkacare Health',
                          regularText: 'is here to deal with all treatment-related problems and follow-ups.',
                        ),
                        SizedBox(height: 20),
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
                    child: Wrap(
                      spacing: s.width < 1024 ? 0 : 50,
                      runSpacing: 20,
                      children: [
                        Container(
                          width: s.width / (s.width < 1024 ? 1.2 : 2.5),
                          child: Image.asset('assets/appendicitis/woman.jpg'),
                        ),
                        Container(
                          width: s.width < 1024 ? s.width : 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'How to prepare for BPH surgery?',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Preparing for a diagnosis of Benign Prostatic Hyperplasia (BPH) or managing the condition effectively involves a combination of lifestyle modifications and proactive healthcare steps. Here are some ways to prepare for BPH or manage it if you’ve already been diagnosed:',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Consult a Healthcare Provider:  ',
                                regularText: 'If you are experiencing urinary symptoms, such as increased frequency, weak urine flow, or difficulty starting and stopping urination, it’s essential to consult a healthcare provider. A healthcare professional can help diagnose BPH and create a tailored treatment plan.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Maintain a Health Journal:',
                                regularText: 'Before your appointment, record your urinary symptoms, including their frequency, severity, and any factors that seem to exacerbate or alleviate them. This information can help your healthcare provider in the diagnosis and treatment process.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Understand Your Medications: ',
                                regularText: 'If you are already taking medications for other health conditions, inform your healthcare provider about these medications, as they can influence the choice of BPH treatment.',
                              ),
                              CustomRichText(
                                boldSize: 16,
                                regularSize: 16,
                                boldText: '• Ask Questions:',
                                regularText: 'Don’t hesitate to ask your healthcare provider about your condition, available treatment options, potential side effects, and long-term outcomes. Aapkacare Health is here to answer all your questions regarding the treatment. Book an appointment for more information.',
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
                          description: 'To consult our skilled surgeons for any problems or to undergo Appendix surgery, visit the nearest Appendix hospital in Pune with Aapkacare Health. You can also schedule an online appointment and speak with the doctor live on video. Make an appointment at Aapkacare Health to speak with the top Laparoscopic surgeons in Pune. The Pune Aapkacare Health multi-speciality hospital for Appendix are sanitised, COVID-safe, and well-equipped. Book an appointment for the most advanced Appendix procedure in Pune.',
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
