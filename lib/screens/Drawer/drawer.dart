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
import 'package:aapkacare/screens/Hospital/hospital_Search.dart';
import 'package:aapkacare/screens/Result%20Page/doctorsearch.dart';
import 'package:aapkacare/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define your menu data
final List<Map<String, dynamic>> menuData = [
  {
    'text': 'Ophthalmology',
    'items': [
      'Cataract',
      'Lasik Surgery',
    ],
  },
  {
    'text': 'Laparoscopy',
    'items': [
      'Hernia',
      'Appendicitis',
      'Gallbladder stone',
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
      'Mole Removal',
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
      'Fistula',
    ],
  },
  {
    'text': 'Vascular',
    'items': [
      'Varicocele',
      'Varicose Vein',
    ],
  },
];

// Map for navigation
final Map<String, Widget Function(BuildContext)> pageRoutes = {
  'Cataract': (context) => Cataract(),
  'Lasik Surgery': (context) => LasikSurgery(),
  'Hernia': (context) => Hernia(),
  'Appendicitis': (context) => Appendicitis(),
  'Gallbladder stone': (context) => Gallbladder(),
  'Circumcision': (context) => Circumcision(),
  'Kidney Stone': (context) => Kidney(),
  'Hydrocele': (context) => Hydrocele(),
  'Frenuloplasty': (context) => Frenuloplasty(),
  'Kidney Transplant': (context) => KidneyTransplant(),
  'Prostate enlargement': (context) => Prostate(),
  'Gynecomastia': (context) => Gynecomastia(),
  'Lipoma': (context) => Lipoma(),
  'Mole Removal': (context) => Mole(),
  'Hip replacement': (context) => Hip(),
  'Knee replacement': (context) => Knee(),
  'ACL tear': (context) => ACL(),
  'Disc injury': (context) => Disc(),
  'Joint replacement': (context) => Joint(),
  'Knee Arthroscopy': (context) => Arthroscopy(),
  'Rotator cuff repair': (context) => Rotator(),
  'Piles': (context) => Piles(),
  'Fissure': (context) => Fissure(),
  'Fistula': (context) => Fistula(),
  'Varicocele': (context) => Varicocele(),
  'Varicose Vein': (context) => Varicose(),
};

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.all(10),
              // color: Colors.black,
              child: Image.asset(
                ImagePath.adsLogo,
                // color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(
              'Hospital',
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalSearch()));
            },
          ),
          ListTile(
            title: Text(
              'Doctors',
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSearch()));
            },
          ),
          ...menuData.map((menuItem) {
            return ExpansionTile(
              title: Text(
                menuItem['text'],
                style: GoogleFonts.montserrat(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
              ),
              children: menuItem['items'].map<Widget>((item) {
                return ListTile(
                  title: Text(
                    item,
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    _navigateToPage(context, item);
                  },
                );
              }).toList(),
            );
          }).toList(),
          ListTile(
            title: Text(
              'Baritric',
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Baritric()));
            },
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, String item) {
    final pageBuilder = pageRoutes[item];
    if (pageBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: pageBuilder),
      );
    } else {
      print('No page found for $item');
    }
  }
}
