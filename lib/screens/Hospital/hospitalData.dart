import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/appointment/appointment.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';

class Extra extends StatefulWidget {
  final String? city;
  final String? name;

  const Extra({super.key, this.city, this.name});

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> details = [];
  bool isLoading = true;
  late int doctorCount;
  int _selectedIndex = 0;
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();
  String? firstImageUrl;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      String city = widget.city!;
      String name = widget.name!;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("AllHospital")
              .where('city', isEqualTo: city)
              .where('name', isEqualTo: name)
              .get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();

        setState(() {
          details.add(dataMap);
        });
        // print("Job data added: $details");
      }

      QuerySnapshot<Map<String, dynamic>> doctorsCollection =
          await FirebaseFirestore.instance
              .collection("AllHospital")
              .doc(details[0]['uid'])
              .collection('Doctors')
              .get();

      int doctorsCount = doctorsCollection.docs.length;
      setState(() {
        doctorCount = doctorsCount;
        isLoading = false;
        firstImageUrl = details.isNotEmpty &&
                details[0]['imageUrls'] != null &&
                (details[0]['imageUrls'] as List).isNotEmpty
            ? details[0]['imageUrls'][0]
            : null;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
    _scrollToSelectedItem(index);
  }

  void _scrollToSelectedItem(int index) {
    double itemWidth = 250; // Fixed width of each item
    double screenWidth = MediaQuery.of(context).size.width;
    double offset = (itemWidth * index) - (screenWidth / 2) + (itemWidth / 2);
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _launchWhatsAppChat(String phoneNumber, String message) async {
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 110.0),
        child: const NavBarBooking(),
      ),
      drawer: CustomDrawer(),
      body: isLoading
          ? Container(
              height: s.height,
              width: s.width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: .8,
                ),
              ),
            )
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        // Text(
                        //   details[0]['name'] ?? 'HCG Cancer Centre, Double Road, Bangalore',
                        //   textAlign: TextAlign.center,
                        //   style: GoogleFonts.montserrat(
                        //     fontSize: 40,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        if (s.width < 1024)
                          ImageSlider(
                              images: List<String>.from(details[0]
                                      ['imageUrls'] ??
                                  {'assets/noimage.png'})),
                        Container(
                          width: s.width,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                s.width < 720 ? 20 : 100 * s.customWidth,
                          ),
                          child: s.width < 720
                              ? Details(
                                  data: details,
                                  count: doctorCount.toString(),
                                )
                              : Row(
                                  children: [
                                    Details(
                                      data: details,
                                      count: doctorCount.toString(),
                                    ),
                                    if (s.width >= 1024)
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                width: 500,
                                                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 3,
                                                      blurRadius: 5,
                                                      // offset: Offset(3, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: ImageNetwork(
                                                  image: firstImageUrl ??
                                                      'assets/noimage.png',
                                                  height: 200,
                                                  width: 250,
                                                  fitWeb: BoxFitWeb.contain,
                                                  fullScreen: false,
                                                  onLoading:
                                                      CircularProgressIndicator(
                                                          color: Colors.blue,
                                                          strokeWidth: .8),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              ImageSlider(
                                                  images: List<String>.from(
                                                      details[0]['imageUrls'] ??
                                                          {
                                                            'assets/noimage.png'
                                                          })),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          color: Colors.blue[50],
                          width: s.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: s.width < 720 ? 0 : 50 * s.customWidth,
                                ),
                                _buildNavItem('About', 0),
                                _buildNavItem('Doctor', 1),
                                // _buildNavItem('Treatments', 2),
                                // _buildNavItem('Insurance', 3),
                                // _buildNavItem('FAQs', 4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _scrollToSelectedItem(index);
                },
                children: [
                  AboutTab(about: details[0]['about']),
                  DoctorList(uId: details[0]['uId']),
                  // TreatmentsTab(),
                  // InsuranceTab(),
                  // FaqTab(),
                ],
              ),
            ),
    );
  }

  Widget _buildNavItem(String text, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        width: 200, // Fixed width for each navigation item
        height: 60,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                  color: _selectedIndex == index ? Colors.blue : Colors.black,
                  fontWeight: _selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: _selectedIndex == index ? 18 : 14,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration:
                    Duration(milliseconds: 300), // Duration of the animation
                height: 4, // Fixed height
                width: _selectedIndex == index
                    ? 200
                    : 0, // Animate width from 0 to full width
                curve: Curves.easeOut, // Optional curve for smoother animation
                color:
                    _selectedIndex == index ? Colors.blue : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example tab content widgets
class AboutTab extends StatelessWidget {
  final String? about;

  const AboutTab({super.key, this.about});

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: s.width < 720 ? 20 : 60 * s.customWidth,
        ),
        child: about != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    about ?? 'No Data',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                    ),
                  ),
                  // SizedBox(height: 16),
                  // data(text: 'Narayana Superspeciality Hospital, Gurugram, is a NABH-accredited world-class medical centre that serves the NCR region\'s healthcare needs. The hospital demonstrates Narayana Health\'s commitment to quality medical care and patient service, skilled medical experts, and the most up-to-date medical facilities, including:'),
                  // SizedBox(height: 16),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     data(text: '1. No. of beds with World-class Intensive Care Units: 215'),
                  //     data(text: '2. Modular Operation Theaters: 6'),
                  //     data(text: '3. Advanced Critical Care and Dialysis Unit'),
                  //     data(text: '4. State-of-the-art Radiology unit with MRI, CT scan and ultrasound'),
                  //     data(text: '5. State-of-art Cath Labs with Rota and IVUS facilities: 2'),
                  //     data(text: '6. Fully Equipped Laboratory Medicine and Blood Bank'),
                  //   ],
                  // ).pOnly(left: 20),
                  // SizedBox(height: 8),
                  // data(text: 'Narayana Health, Gurugram, offers specialized medical services in various fields, including cardiology, neurology, gastroenterology, urology, nephrology, orthopaedics, and more. It is staffed with experienced and highly trained doctors, nurses, and other medical professionals dedicated to providing patients with the best possible care.'),
                  // SizedBox(height: 8),
                  // data(text: 'Narayana superspeciality is equipped with advanced medical technologies and offers various services, such as:'),
                  // SizedBox(height: 8),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     data(text: '1. 24/7 Trauma Care and Pharmacy Services'),
                  //     data(text: '2. 24/7 Radiology Services - 128 Slice CT Scan, 3.0 Tesla MRI'),
                  //     data(text: '3. Round-the-clock critical care ambulance'),
                  //     data(text: '4. 24/7 dialysis services'),
                  //   ],
                  // ).pOnly(left: 20),
                  // SizedBox(height: 8),
                  // data(text: 'Narayana Superspeciality Hospital Gurugram has a patient-centric approach to providing personalized care to each patient. This superspeciality hospital offers various amenities, such as private rooms, a cafeteria, and a pharmacy, to make the patient\'s stay as comfortable as possible. Along with these services, the hospital location offers additional advantages. It is the closest superspeciality hospital from Indira Gandhi International Airport towards Gurugram and is easily accessible via the metro.'),
                  // SizedBox(height: 8),
                  // data(text: 'In addition to providing high-quality medical care, Narayana Superspeciality Hospital is committed to community service and runs various health programs to educate and raise awareness about health issues. The hospital also organizes health camps and free medical checkups for underprivileged communities.'),
                  // SizedBox(height: 8),
                  // data(text: 'Connect to the top doctors of Narayana Superspeciality Hospital, Gurugram, for priority appointments and a hassle-free experience via the medical experts of HexaHealth.'),
                ],
              )
            : Container(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget data({required String text}) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class FullScreenSlider extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenSlider({required this.images, required this.initialIndex});

  @override
  _FullScreenSliderState createState() => _FullScreenSliderState();
}

class _FullScreenSliderState extends State<FullScreenSlider> {
  late int _current;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_current + 1} / ${widget.images.length}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 30),
                    onPressed: () => _controller.previousPage(),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: widget.images.length,
                      itemBuilder: (context, index, realIndex) {
                        return ImageNetwork(
                          image: widget.images[index],
                          fitWeb: BoxFitWeb.contain,
                          height: s.height,
                          width: s.width * .8,
                        );
                      },
                      options: CarouselOptions(
                        initialPage: widget.initialIndex,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      carouselController: _controller,
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 30),
                    onPressed: () => _controller.nextPage(),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final List<Map<String, dynamic>>? data;
  final String? count;

  void _launchWhatsAppChat(String phoneNumber, String message) async {
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  const Details({super.key, this.data, this.count});
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      width: s.width < 1024 ? null : 500 * s.customWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data![0]['name'] ?? 'HCG Cancer Centre',
            // textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: s.width < 720 ? 24 : 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${count ?? '0'}  Doctors | Multi-Speciality Hospital',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Timing: 24 x 7 Open',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
                width: .8,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      'Address',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  data?[0]['address'] ?? 'Shanti Nagar, Bangalore, Karnataka',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).w(s.width > 720 ? 380 : 300),
              ],
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => appointment(
                                uId: data?[0]['uId'],
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Book Appointment',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _launchWhatsAppChat('+919821527088', 'Hello!');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.green,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'WhatsApp Expert',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> images;

  const ImageSlider({
    Key? key,
    required this.images,
  }) : super(key: key);
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  late List<String> sliderImages;

  @override
  void initState() {
    super.initState();

    sliderImages = widget.images;

    print('Images: ${widget.images}');
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        items: sliderImages.map((imageInfo) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenSlider(
                    images: sliderImages,
                    initialIndex: _current,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade200, width: .5),
                boxShadow: [],
              ),
              child: imageInfo.startsWith('http')
                  ? ImageNetwork(
                      image: imageInfo,
                      height: s.width > 1024 ? 100 : 200,
                      width: s.width > 1024 ? 100 : 200,
                      onLoading: CircularProgressIndicator(
                          color: Colors.blue, strokeWidth: .8),
                    )
                  : Image.asset(
                      imageInfo,
                      fit: BoxFit.fill,
                    ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: s.width > 1024 ? 100 : 200,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          viewportFraction: s.width < 1024 ? (s.width < 720 ? 1 : .50) : 0.25,
          pauseAutoPlayOnTouch: false,
          pauseAutoPlayInFiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        carouselController: _controller,
      ).px12(),
    );
  }
}
