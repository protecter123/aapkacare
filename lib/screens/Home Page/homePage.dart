import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Hospital/hospitalData.dart';
import 'package:aapkacare/screens/Hospital/hospitalDetails.dart';
import 'package:aapkacare/screens/Result%20Page/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_network/image_network.dart';

const kGoogleApiKey = "AIzaSyDEbV8pJrdpVk5sFC0pGaxXyag4IpRoRTA";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 112.0),
          child: const NavBarBooking(
            back: false,
          )),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(width: 500, height: 150, child: CityDropdownPage()),
            SizedBox(
              height: s.width < 1024 ? 0 : 20,
            ),

            // Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: s.width < 1024 ? 20 : 100),
              alignment: AlignmentDirectional.center,
              child: Wrap(
                spacing: s.width < 1024 ? 0 : 50,
                verticalDirection: VerticalDirection.up,
                runSpacing: 30,
                children: [
                  Container(
                      width: s.width < 1024 ? s.width : 400,
                      height: 300,
                      child: CityDropdownPage()),
                  Container(
                    width: s.width < 1024 ? s.width : s.width / 2,
                    height: s.width < 1024 ? 200 : 300,
                    // decoration: BoxDecoration(border: Border.all()),
                    child: Image.asset(
                      'assets/b3.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Hospitals
            Container(
              // color: Colors.amber,
              height: s.width < 1142 ? (s.width < 720 ? 1400 : 940) : 680,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: s.width,
                      alignment: Alignment.center,
                      height: 550,
                      color: const Color.fromRGBO(227, 245, 253, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Our Trusted Hospitals',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HospitalSlider(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: s.width < 720 ? 600 : 240,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 20, runSpacing: 10,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        boxData(
                          icon: Icon(Icons.person, color: Colors.white),
                          header: 'Qualified Doctors',
                          desc:
                              'We provide you with best in class doctors for all your health concerns',
                        ),
                        boxData(
                          icon: Icon(Icons.people_sharp, color: Colors.white),
                          header: 'Emergency Care',
                          desc:
                              'Life is unpredictable, so is an Emergency. We are available for any of your Emergencies 24X7, 365 days a year.',
                        ),
                        boxData(
                          icon: Icon(Icons.phone_in_talk_sharp,
                              color: Colors.white),
                          header: '24 Hours Service',
                          desc:
                              'We are available round the clock to give you the best possible healthcare.',
                        ),
                        boxData(
                          icon: Icon(Icons.monitor_heart_outlined,
                              color: Colors.white),
                          header: 'Advanced Technology',
                          desc:
                              'We use AI to filter out the best hospital and the best doctor based on the factors that matter most to you',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),

            // Services
            Container(
              width: s.width,
              alignment: Alignment.center,
              color: const Color.fromRGBO(227, 245, 253, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Our Services',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 50,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      ServiceBox(
                        image: Image.asset('assets/s1.jpg', fit: BoxFit.fill),
                        header: 'Proctology',
                        desc:
                            'Aapkacare is a Multispecialty healthcare provider that aims to provide a hassle-free surgical experience to all patients using cutting-edge technology, and a set of advanced operations and powerful processes.',
                      ),
                      ServiceBox(
                        image: Image.asset('assets/s2.jpg', fit: BoxFit.fill),
                        header: 'Pediatrician',
                        desc:
                            'Pediatricians are doctors who specialize in the health of children from birth to 18 years old. They provide preventive care, diagnose and treat illnesses, and offer guidance on health and wellness. Pediatricians are trained to understand the unique physical, emotional, and developmental needs of children.',
                      ),
                      ServiceBox(
                        image: Image.asset('assets/s3.jpg', fit: BoxFit.fill),
                        header: 'ENT',
                        desc:
                            'ENT stands for ear, nose, and throat, and it refers to the medical specialty that deals with the diagnosis and treatment of disorders of these three areas. Aapkacare provides you with the most advanced treatment of various diseases and disorders related to the Ear, Nose and Throat.',
                      ),
                      ServiceBox(
                        image: Image.asset('assets/s4.jpg', fit: BoxFit.fill),
                        header: 'Urology',
                        desc:
                            'Aapkacare has the most advanced doctors and the best hospitals that have proven record of treatments for laser circumcision, stapler circumcision, kidney stones, prostate treatment, urinary tract infection and other sexual health problems by highly experienced urologist.',
                      ),
                      ServiceBox(
                        image: Image.asset('assets/s5.jpg', fit: BoxFit.fill),
                        header: 'Eye Care',
                        desc:
                            'Eye is the most sensitive organ of the body. Aapkacare ensures that you get the best eye surgeon near you for the treatment of eye disorders or lasik eye surgery. Be it cataract, retinal disorders, pterygium, squint eye, diabetic retinopathy we got you covered for everyting with our best ophthalmologist doctors. ',
                      ),
                      ServiceBox(
                        image: Image.asset('assets/s6.jpg', fit: BoxFit.fill),
                        header: 'Cosmetic',
                        desc:
                            'We know the disappointment you face when you hear that cosmetic surgery is not covered under insurance. With our best hospital and expert doctors, you can undergo any surgery, such as Gynecomastia, Lipoma, Hair transplant, and Scar removal, with a hassle-free procedure.',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),

            // Working
            Container(
              width: s.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'It’s really easy',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      Text(
                        'Here is how it works',
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      WorkingBox(
                        step: '1',
                        image: 'assets/w1.jpg',
                        header: 'Connect with a care expert',
                        desc: 'Share your details & surgery preferences',
                      ),
                      WorkingBox(
                        step: '2',
                        image: 'assets/w2.jpg',
                        header: 'Doctors recommendation',
                        desc:
                            'Get personalized options for doctors & hospitals that match your requirements',
                      ),
                      WorkingBox(
                        step: '3',
                        image: 'assets/w3.jpg',
                        header: 'Surgery closure',
                        desc:
                            'Assisted transport& hospital admission, cashless & no stress settlement',
                      ),
                      WorkingBox(
                        step: '4',
                        image: 'assets/w4.jpg',
                        header: 'Post-surgery support',
                        desc:
                            'Free follow-ups post-surgery, One year Aapka Care plus subscription',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Footer
            Container(
              color: Colors.black87,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Copyright @2023 All Rights Reserved by Aapka Care |  Designed & Developed by Fuerte Developers.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget WorkingBox(
      {required String image,
      required String step,
      required String header,
      required String desc}) {
    Screen s = Screen(context);
    return Container(
      width: 650,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Step $step',
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: s.width < 720 ? 180 : 300,
                height: s.width < 720 ? 140 : 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: GoogleFonts.poppins(
                      fontSize: s.width < 720 ? 18 : 22,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.poppins(
                        fontSize: s.width < 720 ? 12 : 16, height: 1.4),
                  ),
                ],
              ).w(s.width < 720 ? 160 : 300),
            ],
          ),
        ],
      ),
    );
  }

  Widget ServiceBox(
      {required Image image, required String header, required String desc}) {
    Screen s = Screen(context);
    return Container(
      padding: EdgeInsets.all(10),
      width: 350,
      height: s.width < 720 ? null : 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        children: [
          Container(width: double.infinity, height: 200, child: image),
          SizedBox(
            height: 20,
          ),
          Text(
            header,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            desc,
            style: GoogleFonts.poppins(fontSize: 14, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget boxData(
      {required Icon icon, required String header, required String desc}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade500),
      ),
      // height: double.infinity,
      padding: EdgeInsets.all(20),
      width: 270,
      height: 235,
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              padding: EdgeInsets.all(20),
              child: icon,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              header,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class HospitalSlider extends StatefulWidget {
  @override
  State<HospitalSlider> createState() => _HospitalSliderState();
}

class _HospitalSliderState extends State<HospitalSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('AllHospital').get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();
        sliderImages1.add(dataMap);
      }

      setState(() {
        // print('${sliderImages1[3]}...........');
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> sliderImages1 = [];

  // List<Map<String, String>> Images = [
  //   {
  //     'image': 'assets/Hospital_logo/apex.png',
  //   },
  //   {
  //     'image': 'assets/Hospital_logo/mcp.png',
  //   },
  //   {
  //     'image': 'assets/Hospital_logo/nayanam.png',
  //   },
  //   {
  //     'image': 'assets/Hospital_logo/sankalpa.png',
  //   },
  //   {
  //     'image': 'assets/Hospital_logo/shah.png',
  //   },
  //   {
  //     'image': 'assets/Hospital_logo/sharvari.png',
  //   },
  //   {
  //     'image': 'assets/hl8.png',
  //   },
  //   {
  //     'image': 'assets/hl9.png',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return isLoading
        ? Container(
            width: s.width,
            height: 300,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )))
        : CarouselSlider(
            items: sliderImages1.asMap().entries.map((entry) {
              Map<String, dynamic> imageInfo = entry.value;

              String imageUrl = (imageInfo['imageUrls'] != null &&
                      imageInfo['imageUrls'].isNotEmpty)
                  ? imageInfo['imageUrls'][0]
                  : 'assets/noimage.png';

              return InkWell(
                onTap: () {
                  context.go(
                      '/${Uri.encodeComponent(imageInfo['city'].toString())}/${Uri.encodeComponent(imageInfo['name'].toString())}');
                },
                child: Container(
                  width: 350,
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -0.1,
                        blurRadius: 2,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ImageNetwork(
                            image: imageUrl,
                            height: 200,
                            width: 250,
                            onLoading: CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: .8,
                            ),
                          ),
                          Container(
                            height: 200,
                            width: 250,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                      // ImageNetwork(
                      //   image: imageUrl,
                      //   height: 200,
                      //   width: 250,
                      //   onLoading: CircularProgressIndicator(
                      //     color: Colors.blue,
                      //     strokeWidth: .4,
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      Text(
                        imageInfo['name'] ?? 'No Name',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                      Text(
                        imageInfo['city'] ?? 'No Address',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).py(10),
              );
            }).toList(),
            options: CarouselOptions(
              height: 330,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction:
                  s.width < 1024 ? (s.width < 720 ? 1 : .50) : 0.25,
              pauseAutoPlayOnTouch: false,
              pauseAutoPlayInFiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            carouselController: _controller,
          ).px(30 * s.customWidth);
  }
}

class CityDropdownPage extends StatefulWidget {
  @override
  _CityDropdownPageState createState() => _CityDropdownPageState();
}

class _CityDropdownPageState extends State<CityDropdownPage> {
  final TextEditingController locationController = TextEditingController();
  String? _selectedExperience;

  List<String> filteredCities = [];
  String? selectedCity;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase('AllHospital');
  }

  Future<void> fetchDataFromFirebase(String collectionName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      Set<String> citySet = {}; // Use a Set to avoid duplicates

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();
        citySet.add(dataMap['city']);
      }

      setState(() {
        cityNames = citySet.toList();
        filteredCities = cityNames;
        // print('${cityNames}...........');
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  List<String> cityNames = [];

  List<String> _experiences = [
    'Doctors',
    'Hospital',
  ];

  void _filterCityNames(String query) {
    setState(() {
      filteredCities = cityNames
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _showDropdown(context);
    });
  }

  void _showDropdown(BuildContext context) {
    Screen s = Screen(context);
    OverlayState? overlayState = Overlay.of(context);
    if (overlayState != null) {
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 150, // Adjust this value to position the dropdown
          left: s.width < 1024 ? 20 : 160,
          width: s.width < 1024 ? s.width * .9 : 400, // Adjust width
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Container(
              height: 250,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredCities.map((city) {
                    return ListTile(
                      title: Text(city),
                      onTap: () {
                        setState(() {
                          selectedCity = city;
                          locationController.text = city;
                          _hideDropdown();
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      );
      overlayState.insert(overlayEntry!);
    }
  }

  void _hideDropdown() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      body: Column(
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
              height: 50,
              child: DropdownButtonFormField<String>(
                value: _selectedExperience,
                isExpanded: true, // Ensure the selected text is fully visible
                borderRadius: BorderRadius.circular(10),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedExperience = newValue;
                    if (newValue == 'Doctors') {
                      fetchDataFromFirebase('AllDoctors');
                    } else {
                      fetchDataFromFirebase('AllHospital');
                    }
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
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: .4),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: .4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: .4),
                  ),
                  hintText: 'What you need',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 12), // Adjust padding if necessary
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
          TextField(
            cursorColor: Colors.black,
            controller: locationController,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "Search City",
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
              hintStyle: GoogleFonts.poppins(
                color: Colors.black45,
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 12), // Adjust padding if necessary
            ),
            onTap: () {
              _showDropdown(context);
            },
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              if (_selectedExperience != null &&
                  locationController.text.isNotEmpty) {
                if (_selectedExperience == 'Hospital') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HospitalDetails(
                            hospitalName: locationController.text,
                          )));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchPage(
                            profession: _selectedExperience.toString(),
                            location: locationController.text,
                          )));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 800),
                    content: Text(
                      'Please fill in all fields before searching.',
                      style: GoogleFonts.poppins(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'Find',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// TextEditingController _locationController = TextEditingController();
// String? _selectedExperience;
// bool _isListViewVisible = false;
// @override
// void initState() {
//   super.initState();
//   _locationController.addListener(_onChange);
// }

// _onChange() {
//   placeSuggestion(_locationController.text);
// }

// Future<void> placeSuggestion(String input) async {
//   String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$kGoogleApiKey';
//   final corsProxy = 'https://api.allorigins.win/raw?url=';

//   final finalUrl = corsProxy + Uri.encodeComponent(url);
//   try {
//     final response = await http.get(Uri.parse(finalUrl), headers: {
//       "x-requested-with": "XMLHttpRequest",
//     });
//     if (response.statusCode == 200) {
//       setState(() {
//         listOfLocation = json.decode(response.body)['predictions'];
//       });
//     } else {
//       print("Response.........Error ");
//       throw Exception('Failed to load suggestions');
//     }
//   } catch (e) {
//     print("Error : $e");
//   }
// }

// List<Map<String, String>> sliderImages = [
//   // {
//   //   'path': 'assets/Hospital_logo/apex.png',
//   //   'id': 'medicoverhospitalskurnool@aapkacare.com',
//   //   'name': 'Medicover Hospital',
//   //   'city': 'rajot'
//   // },
//   // {
//   //   'path': 'assets/Hospital_logo/apex.png',
//   //   'id': 'apexmulund@aapkacare.com',
//   //   'name': 'ApexMulund',
//   //   'city': 'rajot'
//   // },
//   // {
//   //   'path': 'assets/Hospital_logo/apex.png',
//   //   'id': 'medicoverhospitalssrikakulam@aapkacare.com',
//   //   'name': 'medicoverhospitalssrikakulam',
//   //   'city': 'rajot'
//   // },
//   {
//     'path': 'assets/Hospital_logo/apex.png',
//     'id': 'medicoverhospitalsvizianagram@aapkacare.com',
//     'name': 'medicoverhospitalsvizianagram',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/Hospital_logo/mcp.jpg',
//     'id': 'mpctsurana@aapkacare.com',
//     'name': 'Mpctsurana',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/Hospital_logo/sankalpa.png',
//     'id': 'sankalpa@aapkacare.com',
//     'name': 'Sankalpa',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/Hospital_logo/shah.png',
//     'id': 'shahlifeline@aapkacare.com',
//     'name': 'Shahlifeline',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/Hospital_logo/sharvari.jpeg',
//     'id': 'sharvari@aapkacare.com',
//     'name': 'Sharvari',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/hl8.png',
//     'id': 'suranahospitalmalad@aapkacare.com',
//     'name': 'Suranahospitalmalad',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/hl9.png',
//     'id': 'suranasethia@aapkacare.com',
//     'name': 'Suranasethia',
//     'city': 'rajot'
//   },
//   {
//     'path': 'assets/Hospital_logo/nayanam.jpeg',
//     'id': 'nayanameye@aapkacare.com',
//     'name': 'Nayanameye',
//     'city': 'rajot'
//   },
// ];

// List<String> _experiences = [
//   'Doctors',
//   // 'Nurse',
//   'Hospital',
//   // 'Patient',
// ];

// Container(
//   width: s.width < 1024 ? s.width : 400,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         'Best surgery\'s',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//       Text(
//         'AapkaCare Provide Top Doctors',
//         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
//       ),
//       SizedBox(height: 10),
//       Theme(
//         data: ThemeData(
//           focusColor: Colors.white,
//           splashColor: Colors.transparent,
//         ),
//         child: Container(
//           height: 45,
//           child: DropdownButtonFormField<String>(
//             value: _selectedExperience,
//             isExpanded: true, // Ensure the selected text is fully visible
//             borderRadius: BorderRadius.circular(10),
//             onChanged: (String? newValue) {
//               setState(() {
//                 _selectedExperience = newValue;
//               });
//             },
//             items: _experiences
//                 .map<DropdownMenuItem<String>>(
//                   (String value) => DropdownMenuItem<String>(
//                     alignment: AlignmentDirectional.centerStart,
//                     value: value,
//                     child: Text(
//                       value,
//                       style: GoogleFonts.poppins(
//                         color: Colors.black,
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 )
//                 .toList(),
//             decoration: InputDecoration(
//               fillColor: Colors.black,
//               focusColor: Colors.black,
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade600, width: .4),
//               ),
//               hintText: 'What you need',
//               hintStyle: GoogleFonts.poppins(
//                 color: Colors.black45,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 15.0,
//               ),
//               contentPadding: EdgeInsets.symmetric(horizontal: 12), // Adjust padding if necessary
//             ),
//             style: GoogleFonts.poppins(
//               color: Colors.black,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       SizedBox(height: 10),
//       Container(height: 50, width: double.infinity, child: CityDropdownPage()),
//       SizedBox(height: 10),
//       Container(
//         height: 45,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: Colors.grey.shade600, width: .4),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(left: 10, top: 3),
//           child: TextField(
//             onChanged: (value) {
//               setState(() {
//                 _isListViewVisible = value.isNotEmpty;
//               });
//             },
//             cursorColor: Colors.black,
//             controller: _locationController,
//             showCursor: true,
//             decoration: InputDecoration.collapsed(
//               fillColor: Colors.black,
//               focusColor: Colors.black,
//               hintText: 'Enter Location',
//               hintStyle: GoogleFonts.poppins(
//                 color: Colors.black45,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 15.0,
//                 height: 3,
//               ),
//             ),
//             style: GoogleFonts.poppins(
//               color: Colors.black,
//               fontSize: 16.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       Visibility(
//         visible: _isListViewVisible,
//         child: Container(
//           height: 180,
//           // width: MediaQuery.of(context).size.width,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: listOfLocation.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       setState(() {
//                         _locationController.text = listOfLocation[index]["description"];
//                         _isListViewVisible = false;
//                       });
//                     },
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.location_on_rounded,
//                         size: 20,
//                       ),
//                       title: Text(
//                         listOfLocation[index]["description"],
//                         style: GoogleFonts.poppins(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14.0,
//                         ),
//                       ).pSymmetric(v: 5),
//                     ),
//                   );
//                 }),
//           ),
//         ),
//       ),
//       // SizedBox(height: 10),
//       // _buildSearchInput('City'),
//       SizedBox(height: 10),
//       InkWell(
//         onTap: () {
//           if (_selectedExperience != null && _locationController.text.isNotEmpty) {
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => SearchPage(
//                       profession: _selectedExperience.toString(),
//                       location: _locationController.text,
//                     )));
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 duration: Duration(milliseconds: 800),
//                 content: Text(
//                   'Please fill in all fields before searching.',
//                   style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           }
//         },
//         child: Container(
//           width: double.infinity,
//           height: 40,
//           decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(5)),
//           child: Center(
//             child: Text(
//               'Find',
//               style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ),
//       )
//     ],
//   ),
// ),

//hospital slider
// CarouselSlider(
//   items: sliderImages.map((imageInfo) {
//     return InkWell(
//       onTap: () {
//         // Navigate to the new page with the image ID
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Extra(
//               id: imageInfo['id'].toString(),
//               // profession: 'Hospital',
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: 300,
//         height: 400,
//         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey.shade200, width: .5), boxShadow: [
//           BoxShadow(color: Colors.black26, spreadRadius: 3, blurRadius: 5)
//         ]),
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: 250,
//               child: Image.asset(
//                 imageInfo['path']!,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               imageInfo['name']!,
//               style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               imageInfo['city']!,
//               style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ).py(10),
//     );
//   }).toList(),
//   options: CarouselOptions(
//     height: 300,
//     enableInfiniteScroll: true,
//     autoPlay: true,
//     autoPlayInterval: Duration(seconds: 3),
//     autoPlayAnimationDuration: Duration(milliseconds: 800),
//     autoPlayCurve: Curves.fastOutSlowIn,
//     scrollDirection: Axis.horizontal,
//     viewportFraction: s.width < 1024 ? (s.width < 720 ? .90 : .50) : 0.25,
//     pauseAutoPlayOnTouch: false,
//     pauseAutoPlayInFiniteScroll: false,
//     onPageChanged: (index, reason) {
//       setState(() {
//         _current = index;
//       });
//     },
//   ),
//   carouselController: _controller,
// ).px12(),
