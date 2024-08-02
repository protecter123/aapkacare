import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Drawer/fixedWidgets.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/calendar.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String id;
  final String? uId;
  final String? image;
  const DoctorDetailsPage({super.key, required this.id, this.image, this.uId});

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> details = [];
  bool isLoading = true;
  int _selectedIndex = 0;
  late PageController _pageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchDataFromFirebase();
    print('${widget.uId}...');
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      String queryTokens = widget.id;

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("AllHospital").doc(widget.uId ?? '').collection("Doctors").where('name', isEqualTo: queryTokens).get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();

        setState(() {
          details.add(dataMap);
        });
        print("Data Details: $details");
      }
      setState(() {
        isLoading = false;
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
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: s.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: s.width < 720 ? 20 : 100 * s.customWidth,
                    ),
                    child: Row(
                      children: [
                        Container(
                          // margin: EdgeInsets.only(left: 20),
                          margin: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Container(
                                height: s.width < 720 ? 200 : 250,
                                width: s.width < 720 ? 150 : 250,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  // color: Color.fromARGB(255, 74, 196, 252),
                                  color: Colors.transparent,
                                  // border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black26,
                                  //     spreadRadius: 3,
                                  //     blurRadius: 5,
                                  //     offset: Offset(3, 3),
                                  //   ),
                                  // ],
                                ),
                                child: ImageNetwork(
                                  image: widget.image ?? "assets/download.jpeg",
                                  height: s.width < 720 ? 200 : 250,
                                  width: s.width < 720 ? 150 : 250,
                                ),
                                //  Image.asset(
                                //   widget.image ?? 'assets/d3.png',
                                //   fit: BoxFit.contain,
                                // ),
                              ),
                              SizedBox(height: 10)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Details(
                            data: details,
                            uId: widget.uId,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (s.width < 720)
                    Buttons(
                      uId: widget.uId,
                    ),
                  SizedBox(height: s.width > 720 ? 0 : 10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.width < 720 ? 20 : 100 * s.customWidth,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OverView',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        data(text: 'A specialist in ENT with a rich experience of over 11 years is currently working in Max Smart Super Speciality Hospital, Saket. He has handled numerous complex medical cases and is known for attention to detail, accurate diagnosis and treating patients with empathy.'),
                        SizedBox(height: 16),
                        data(text: 'Connect to Dr Amrit Kapoor for priority appointments and hassle free experience via medical experts of HexaHealth.'),
                        SizedBox(height: 16),
                        Text(
                          'Treatments',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        data(text: 'Dr. Amrit Kapoor specializes in the following treatments:'),
                        SizedBox(height: 16),
                        CustomRichText(
                          boldText: '• ',
                          boldSize: 20,
                          regularSize: 15,
                          regularText: 'Adenoidectomy',
                        ),
                        SizedBox(height: 8),
                        CustomRichText(
                          boldText: '• ',
                          boldSize: 20,
                          regularSize: 15,
                          regularText: 'Adenoidectomy',
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),

      //  NestedScrollView(
      //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //       return <Widget>[
      //         SliverToBoxAdapter(
      //           child: SingleChildScrollView(
      //             physics: NeverScrollableScrollPhysics(),
      //             child: Column(
      //               children: [
      //                 SizedBox(height: 10),
      //                 Container(
      //                   width: s.width,
      //                   padding: EdgeInsets.symmetric(
      //                     vertical: 10,
      //                     horizontal: s.width < 720 ? 20 : 100 * s.customWidth,
      //                   ),
      //                   child: Row(
      //                     children: [
      //                       Expanded(
      //                         child: Details(
      //                           data: details,
      //                         ),
      //                       ),
      //                       Container(
      //                         margin: EdgeInsets.only(left: 20),
      //                         child: Column(
      //                           children: [
      //                             Container(
      //                               height: s.width < 720 ? 200 : 250,
      //                               width: s.width < 720 ? 150 : 250,
      //                               padding: EdgeInsets.all(10),
      //                               decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 border: Border.all(color: Colors.grey.shade400),
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                     color: Colors.black12,
      //                                     spreadRadius: 3,
      //                                     blurRadius: 5,
      //                                     // offset: Offset(3, 3),
      //                                   ),
      //                                 ],
      //                               ),
      //                               child: Image.asset(
      //                                 widget.image ?? 'assets/d1.png',
      //                                 fit: BoxFit.contain,
      //                               ),
      //                             ),
      //                             SizedBox(height: 10)
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 if (s.width < 720)
      //                   Buttons(
      //                     uId: widget.uId,
      //                   ),
      //                 SizedBox(height: 20),
      //                 Container(
      //                   color: Colors.blue[50],
      //                   width: s.width,
      //                   child: SingleChildScrollView(
      //                     scrollDirection: Axis.horizontal,
      //                     controller: _scrollController,
      //                     child: Row(
      //                       children: [
      //                         SizedBox(
      //                           width: s.width < 720 ? 0 : 50 * s.customWidth,
      //                         ),
      //                         _buildNavItem('About', 0),
      //                         _buildNavItem('Treatment', 1),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ];
      //     },
      //     body: _buildPageContent(),
      //   ),
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

  Widget _buildPageContent() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildTabContent(AboutTab()),
        _buildTabContent(Treatment()),
      ],
    );
  }

  Widget _buildTabContent(Widget tab) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: tab,
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
                  fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                  fontSize: _selectedIndex == index ? 18 : 14,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300), // Duration of the animation
                height: 4, // Fixed height
                width: _selectedIndex == index ? 200 : 0, // Animate width from 0 to full width
                curve: Curves.easeOut, // Optional curve for smoother animation
                color: _selectedIndex == index ? Colors.blue : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String? uId;

  const Buttons({
    Key? key,
    this.uId,
  }) : super(key: key);

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
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Calendar(
                          Data: {
                            'uId': uId ?? ''
                          },
                        )));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
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
            _launchWhatsAppChat('+9724453735', 'Hello!');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
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
    );
  }
}

class Treatment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: s.width < 720 ? 20 : 60 * s.customWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Treatments',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          data(text: 'Dr. Amrit Kapoor specializes in the following treatments:'),
          SizedBox(height: 16),
          CustomRichText(
            boldText: '• ',
            boldSize: 20,
            regularSize: 15,
            regularText: 'Adenoidectomy',
          ),
          SizedBox(height: 8),
          CustomRichText(
            boldText: '• ',
            boldSize: 20,
            regularSize: 15,
            regularText: 'Adenoidectomy',
          ),
          SizedBox(height: 8),
          CustomRichText(
            boldText: '• ',
            boldSize: 20,
            regularSize: 15,
            regularText: 'Adenoidectomy',
          ),
          SizedBox(height: 8),
        ],
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

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: s.width < 720 ? 20 : 60 * s.customWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'OverView',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          data(text: 'A specialist in ENT with a rich experience of over 11 years is currently working in Max Smart Super Speciality Hospital, Saket. He has handled numerous complex medical cases and is known for attention to detail, accurate diagnosis and treating patients with empathy.'),
          SizedBox(height: 16),
          data(text: 'Connect to Dr Amrit Kapoor for priority appointments and hassle free experience via medical experts of HexaHealth.'),
          SizedBox(height: 16),
        ],
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

class Details extends StatelessWidget {
  final List<Map<String, dynamic>>? data;
  final String? uId;

  const Details({
    super.key,
    this.data,
    this.uId,
  });

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
    final defaultData = {
      'name': 'HCG Cancer Centre',
      'qualification': 'None',
      'experience': 0,
      'address': 'Shanti Nagar, Bangalore, Karnataka'
    };

    final itemData = data != null && data!.isNotEmpty ? data![0] : defaultData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          itemData['name'] ?? 'HCG Cancer Centre',
          style: GoogleFonts.montserrat(
            fontSize: s.width < 720 ? 24 : 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          itemData['qualification'] ?? 'None',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Text(
          'Experience : ${itemData['experience'] ?? '0'} Years',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Text(
          itemData['address'] ?? 'Shanti Nagar, Bangalore, Karnataka',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        if (s.width > 720)
          Buttons(
            uId: uId,
          ),
      ],
    );
  }
}
