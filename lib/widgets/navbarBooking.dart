import 'dart:math';
import 'package:aapkacare/screens/Result%20Page/doctorsearch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aapkacare/screens/Drawer/acl.dart';
import 'package:aapkacare/screens/Drawer/appendicitis.dart';
import 'package:aapkacare/screens/Drawer/arthroscopy.dart';
import 'package:aapkacare/screens/Drawer/baritric.dart';
import 'package:aapkacare/screens/Drawer/cataract.dart';
import 'package:aapkacare/screens/Drawer/circumcision.dart';
import 'package:aapkacare/screens/Drawer/disc.dart';
import 'package:aapkacare/screens/Drawer/fissure.dart';
import 'package:aapkacare/screens/Drawer/fistula.dart';
import 'package:aapkacare/screens/Drawer/frenuloplasty.dart';
import 'package:aapkacare/screens/Drawer/gallbladderStone.dart';
import 'package:aapkacare/screens/Drawer/gynecomastia.dart';
import 'package:aapkacare/screens/Drawer/hernia.dart';
import 'package:aapkacare/screens/Drawer/hip.dart';
import 'package:aapkacare/screens/Drawer/hydrocele.dart';
import 'package:aapkacare/screens/Drawer/joint.dart';
import 'package:aapkacare/screens/Drawer/kidney.dart';
import 'package:aapkacare/screens/Drawer/kidneytransplant.dart';
import 'package:aapkacare/screens/Drawer/knee.dart';
import 'package:aapkacare/screens/Drawer/lasikSurgery.dart';
import 'package:aapkacare/screens/Drawer/lipoma.dart';
import 'package:aapkacare/screens/Drawer/mole.dart';
import 'package:aapkacare/screens/Drawer/piles.dart';
import 'package:aapkacare/screens/Drawer/prostate.dart';
import 'package:aapkacare/screens/Drawer/rotator.dart';
import 'package:aapkacare/screens/Drawer/varicocele.dart';
import 'package:aapkacare/screens/Drawer/varicose.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Hospital/hospital_Search.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/values/values.dart';
import 'package:aapkacare/widgets/navbar.dart';

class NavBarBooking extends StatefulWidget {
  final bool? back;
  final bool? Hospital;
  final bool? Doctor;
  const NavBarBooking({
    Key? key,
    this.back,
    this.Hospital,
    this.Doctor,
  }) : super(key: key);

  @override
  State<NavBarBooking> createState() => _NavBarBookingState();
}

class _NavBarBookingState extends State<NavBarBooking> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final double maxSlide = 250.0;
  late List<GlobalKey<PopupMenuButtonState<String>>> _menuKeys;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _menuKeys = List.generate(menuData.length, (_) => GlobalKey<PopupMenuButtonState<String>>());
  }

  void toggle() => animationController.isDismissed ? animationController.forward() : animationController.reverse();

  void _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchWhatsAppChat(String phoneNumber, String message) async {
    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<Map<String, dynamic>> menuData = [
    {
      'text': 'Ophthalmology',
      'items': [
        'Cataract',
        'Lasik Surgery'
      ],
    },
    {
      'text': 'Laparoscopy',
      'items': [
        'Hernia',
        'Appendicitis',
        'Gallbladder stone'
      ],
    },
    {
      'text': 'Urology',
      'items': [
        'Circumcision',
        'Kidney Stone',
        'Hydrocele',
        'Frenuloplasty',
        'Kidney Transplant',
        'Prostate enlargement',
      ],
    },
    {
      'text': 'Cosmetic',
      'items': [
        'Gynecomastia',
        'Lipoma',
        'Mole Removal'
      ],
    },
    {
      'text': 'Orthopaedic',
      'items': [
        'Hip replacement',
        'Knee replacement',
        'ACL tear',
        'Disc injury',
        'Joint replacement',
        'Knee Arthroscopy',
        'Rotator cuff repair',
      ],
    },
    {
      'text': 'Proctology',
      'items': [
        'Piles',
        'Fissure',
        'Fistula'
      ],
    },
    {
      'text': 'Vascular',
      'items': [
        'Varicocele',
        'Varicose Vein'
      ],
    },
  ];
  void closeMenu() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    final textTheme = Theme.of(context).textTheme;
    return s.isDesktop
        ? Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  // color: Color(0xfff8f8f8),
                  color: Color.fromARGB(255, 27, 181, 253),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * s.customWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.back == false
                          ? SizedBox.shrink()
                          : IconButton(
                              onPressed: () {
                                context.go(
                      '/');
                              },
                              icon: Icon(Icons.arrow_back),
                              color: Colors.white,
                            ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              },
                              child: const Logo()),
                        ],
                      ),
                      Expanded(child: Container()),
                      if (s.width > 720) Buttons(Doctor: widget.Doctor, Hospital: widget.Hospital),
                      // Expanded(child: Container()),
                      SizedBox(
                        width: 20 * s.customWidth,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     _launchPhoneCall('1234567890');
                      //   },
                      //   child: Container(
                      //     // height: 50,
                      //     // width: 200,
                      //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white, width: 2)),
                      //     child: Text(
                      //       '+911234567890',
                      //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),

                      InkWell(
                        onTap: () {
                          _launchPhoneCall('1234567890');
                        },
                        child: ShakeOnHover(
                          duration: Duration(milliseconds: 150),
                          distance: 24.0,
                          color: Colors.transparent,
                          hoverColor: Color.fromARGB(255, 91, 209, 95),
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white, width: 2)),
                            child: Center(
                                child: Text(
                              '+919821527088',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20 * s.customWidth,
                      ),
                      InkWell(
                        onTap: () {
                          _launchWhatsAppChat('+919821527088', 'Hello!');
                        },
                        child: Container(
                          height: 48,
                          // width: 200,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white, width: 2)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                                size: 20,
                              ),
                              Text('  Chat', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 30.0 * s.customWidth),
                    ],
                  ),
                ),
              ),
              s.width < 1024
                  ? Container()
                  : Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: menuData.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> menuItem = entry.value;

                              return MouseRegion(
                                // onEnter: (event) => _menuKeys[index].currentState?.showButtonMenu(),
                                child: PopupMenuButton<String>(
                                  key: _menuKeys[index],
                                  tooltip: '',
                                  offset: Offset(0, 35),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        menuItem['text'],
                                        style: GoogleFonts.montserrat(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return menuItem['items'].map<PopupMenuEntry<String>>((item) {
                                      return PopupMenuItem<String>(
                                        padding: EdgeInsets.zero,
                                        value: item,
                                        height: 50,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: double.infinity,
                                          // color: Colors.white,
                                          child: Text(
                                            item,
                                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  onSelected: (value) {
                                    // Handle the selection of the popup menu item
                                    print('$value selected for ${menuItem['text']}');
                                    switch (value) {
                                      case 'Cataract':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cataract()));
                                        break;
                                      case 'Lasik Surgery':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LasikSurgery()));
                                        break;
                                      case 'Hernia':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hernia()));
                                        break;
                                      case 'Appendicitis':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Appendicitis()));
                                        break;
                                      case 'Gallbladder stone':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Gallbladder()));
                                        break;
                                      case 'Circumcision':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Circumcision()));
                                        break;
                                      case 'Kidney Stone':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Kidney()));
                                        break;
                                      case 'Hydrocele':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hydrocele()));
                                        break;
                                      case 'Frenuloplasty':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Frenuloplasty()));
                                        break;
                                      case 'Kidney Transplant':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => KidneyTransplant()));
                                        break;
                                      case 'Prostate enlargement':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Prostate()));
                                        break;
                                      case 'Gynecomastia':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Gynecomastia()));
                                        break;
                                      case 'Lipoma':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Lipoma()));
                                        break;
                                      case 'Mole Removal':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Mole()));
                                        break;
                                      case 'Hip replacement':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hip()));
                                        break;
                                      case 'Knee replacement':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Knee()));
                                        break;
                                      case 'ACL tear':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ACL()));
                                        break;
                                      case 'Disc injury':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Disc()));
                                        break;
                                      case 'Joint replacement':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Joint()));
                                        break;
                                      case 'Knee Arthroscopy':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Arthroscopy()));
                                        break;
                                      case 'Rotator cuff repair':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rotator()));
                                        break;
                                      case 'Piles':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Piles()));
                                        break;
                                      case 'Fissure':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Fissure()));
                                        break;
                                      case 'Fistula':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Fistula()));
                                        break;
                                      case 'Varicocele':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Varicocele()));
                                        break;
                                      case 'Varicose Vein':
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Varicose()));
                                        break;

                                      default:
                                        break;
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Baritric()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  'Bariatric',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     padding: EdgeInsets.all(10),
                          //     child: Center(
                          //       child: Text(
                          //         'Blog',
                          //         style: GoogleFonts.montserrat(
                          //           color: Colors.blue,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
            ],
          )
        : AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 27, 181, 253),
            scrolledUnderElevation: 0,
            leadingWidth: 300,
            leading: Row(
              children: [
                widget.back == false
                    ? SizedBox(
                        width: 10,
                      )
                    : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                    // height: 60,
                    padding: EdgeInsets.all(10),
                    // color: Colors.black,
                    child: Image.asset(
                      ImagePath.adsLogo,
                      // color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // title: GestureDetector(
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => HomePage()),
            //     );
            //   },
            //   child: Container(
            //     height: 60,
            //     padding: EdgeInsets.all(10),
            //     // color: Colors.black,
            //     child: Image.asset(
            //       ImagePath.adsLogo,
            //       // color: Colors.black,
            //     ),
            //   ),
            // ),
            actions: [
              IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 36,
                  )),
              SizedBox(
                width: 30 * s.customWidth,
              )
            ],
          );
  }

  Row _buildItems(BuildContext context) {
    Screen s = Screen(context);
    return Row(
      children: [
        widget.Hospital == false
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalSearch()),
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Text(
                        'Hospitals',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        widget.Doctor == false ? SizedBox.shrink() : SizedBox(width: 20.0 * s.customWidth),
        widget.Doctor == false
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorSearch()),
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white, width: 2)),
                    child: Center(
                      child: Text(
                        'Doctors',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class ShakeOnHover extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double distance;
  final Color color;
  final Color hoverColor;

  const ShakeOnHover({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.distance = 24.0,
    required this.color,
    required this.hoverColor,
  }) : super(key: key);

  @override
  _ShakeOnHoverState createState() => _ShakeOnHoverState();
}

class _ShakeOnHoverState extends State<ShakeOnHover> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  bool _hovering = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startShaking() {
    _controller.repeat();
    setState(() {
      _hovering = true;
    });
  }

  void _stopShaking() {
    _controller.stop();
    setState(() {
      _hovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _startShaking(),
      onExit: (event) => _stopShaking(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final dx = sin(_controller.value * 2 * pi) * widget.distance / 6;
          return Transform.translate(
            offset: Offset(dx, 0),
            child: Container(
              color: _hovering ? widget.hoverColor : widget.color,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  final bool? Hospital;
  final bool? Doctor;

  Buttons({this.Hospital, this.Doctor});

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  bool isHoveringHospital = false;
  bool isHoveringDoctor = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.Hospital == false
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => isHoveringHospital = true),
                  onExit: (_) => setState(() => isHoveringHospital = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HospitalSearch()),
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white, width: 2),
                        color: isHoveringHospital ? Colors.white : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Hospitals',
                          style: GoogleFonts.montserrat(
                            color: isHoveringHospital ? Colors.black : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        widget.Doctor == false ? SizedBox.shrink() : SizedBox(width: 20.0),
        widget.Doctor == false
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => isHoveringDoctor = true),
                  onExit: (_) => setState(() => isHoveringDoctor = false),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DoctorSearch()),
                      );
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white, width: 2),
                        color: isHoveringDoctor ? Colors.white : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Doctors',
                          style: GoogleFonts.montserrat(
                            color: isHoveringDoctor ? Colors.black : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
