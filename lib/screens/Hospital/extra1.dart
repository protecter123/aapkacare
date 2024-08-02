import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Hospital/hospitalData.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:velocity_x/velocity_x.dart';

class Extra1 extends StatefulWidget {
  @override
  State<Extra1> createState() => _Extra1State();
}

class _Extra1State extends State<Extra1> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s.width < 1024 ? 64.0 : 110.0),
        child: const NavBarBooking(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'HCG Cancer Centre',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (s.width < 1024) ImageSlider(),
            Container(
              width: s.width,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: s.width < 720 ? 20 : 100 * s.customWidth,
              ),
              child: s.width < 720
                  ? Details()
                  : Row(
                      children: [
                        Details(),
                        if (s.width >= 1024)
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Container(
                                      height: 200,
                                      width: 500,
                                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        'assets/hl1.png',
                                      )),
                                  SizedBox(height: 20),
                                  ImageSlider()
                                ],
                              ),
                            ),
                          ),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '11 Doctors | 4 Specialities | Multi-Speciality Hospital',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
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
                'Shanti Nagar, Bangalore, Karnataka',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Container(
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
            Container(
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
          ],
        ),
      ],
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  List<String> sliderImages = [
    'assets/s1.jpeg',
    'assets/s2.jpeg',
    'assets/s3.jpeg',
    'assets/s4.jpeg',
    'assets/s5.jpeg',
    'assets/s6.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: s.width,
      child: CarouselSlider(
        items: sliderImages.map((imageInfo) {
          return InkWell(
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
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey.shade200, width: .5), boxShadow: []),
              child: Image.asset(
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



//  Container(
                    //   width: s.width,
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: 10,
                    //     horizontal: s.width < 720 ? 20 : 100 * s.customWidth,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: s.width < 720 ? s.width : 420,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             SizedBox(height: 10),
                    //             Text(
                    //               '$DoctorCount  Doctors | Multi-Speciality Hospital',
                    //               style: GoogleFonts.montserrat(
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             SizedBox(height: 16),
                    //             Text(
                    //               'Timing: 24 x 7 Open',
                    //               style: GoogleFonts.montserrat(
                    //                 fontSize: 16,
                    //                 color: Colors.green,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             SizedBox(height: 16),
                    //             Container(
                    //               padding: EdgeInsets.all(10),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                   color: Colors.grey.shade200,
                    //                   width: .8,
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(5),
                    //                 color: Colors.grey.shade200,
                    //               ),
                    //               child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Row(
                    //                     children: [
                    //                       Icon(Icons.location_on_outlined),
                    //                       Text(
                    //                         'Address',
                    //                         style: GoogleFonts.montserrat(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Text(
                    //                     'Shanti Nagar, Bangalore, Karnataka',
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: GoogleFonts.montserrat(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w400,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(height: 16),
                    //             Wrap(
                    //               spacing: 10,
                    //               runSpacing: 10,
                    //               children: [
                    //                 InkWell(
                    //                   onTap: () {
                    //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar(Data: {})));
                    //                   },
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.blue,
                    //                       borderRadius: BorderRadius.circular(10),
                    //                     ),
                    //                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //                     child: Row(
                    //                       mainAxisSize: MainAxisSize.min,
                    //                       children: [
                    //                         Icon(
                    //                           Icons.calendar_today_outlined,
                    //                           size: 20,
                    //                           color: Colors.white,
                    //                         ),
                    //                         SizedBox(width: 5),
                    //                         Text(
                    //                           'Book Appointment',
                    //                           style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, height: 2),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                     color: Colors.white,
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     border: Border.all(color: Colors.green),
                    //                   ),
                    //                   padding: EdgeInsets.symmetric(
                    //                     vertical: 10,
                    //                     horizontal: 20,
                    //                   ),
                    //                   child: Row(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       FaIcon(
                    //                         FontAwesomeIcons.whatsapp,
                    //                         color: Colors.green,
                    //                         size: 26,
                    //                       ),
                    //                       SizedBox(width: 5),
                    //                       Text(
                    //                         'WhatsApp Expert',
                    //                         style: GoogleFonts.montserrat(
                    //                           fontSize: 14,
                    //                           color: Colors.green,
                    //                           fontWeight: FontWeight.w500,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           margin: EdgeInsets.only(left: 20),
                    //           // color: Colors.yellow,
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                   height: 200,
                    //                   width: 500,
                    //                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    //                   decoration: BoxDecoration(
                    //                     color: Colors.white,
                    //                     border: Border.all(color: Colors.grey.shade300),
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: Image.asset(
                    //                     'assets/hl1.png',
                    //                     // fit: BoxFit.contain,
                    //                   )),
                    //               SizedBox(
                    //                 height: 20,
                    //               ),
                    //               Container(
                    //                 padding: EdgeInsets.symmetric(horizontal: 50),
                    //                 child: CarouselSlider(
                    //                   items: sliderImages.map((imageInfo) {
                    //                     return InkWell(
                    //                       onTap: () {
                    //                         Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                             builder: (context) => FullScreenSlider(
                    //                               images: sliderImages,
                    //                               initialIndex: _current,
                    //                             ),
                    //                           ),
                    //                         );
                    //                       },
                    //                       child: Container(
                    //                         width: 200,
                    //                         height: 50,
                    //                         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey.shade200, width: .5), boxShadow: []),
                    //                         child: Image.asset(
                    //                           imageInfo,
                    //                           fit: BoxFit.fill,
                    //                         ),
                    //                       ),
                    //                     );
                    //                   }).toList(),
                    //                   options: CarouselOptions(
                    //                     height: 100,
                    //                     enableInfiniteScroll: true,
                    //                     autoPlay: true,
                    //                     autoPlayInterval: Duration(seconds: 3),
                    //                     autoPlayAnimationDuration: Duration(milliseconds: 800),
                    //                     autoPlayCurve: Curves.fastOutSlowIn,
                    //                     scrollDirection: Axis.horizontal,
                    //                     viewportFraction: s.width < 1024 ? (s.width < 720 ? .90 : .50) : 0.35,
                    //                     pauseAutoPlayOnTouch: false,
                    //                     pauseAutoPlayInFiniteScroll: false,
                    //                     onPageChanged: (index, reason) {
                    //                       setState(() {
                    //                         _current = index;
                    //                       });
                    //                     },
                    //                   ),
                    //                   carouselController: _controller,
                    //                 ).px12(),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),