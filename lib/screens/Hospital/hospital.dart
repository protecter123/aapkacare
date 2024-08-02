import 'package:aapkacare/responsive.dart';
import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Hospital/hospital_mobile.dart';
import 'package:aapkacare/screens/Hospital/hospital_web.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aapkacare/values/screen.dart';

class Hospital extends StatefulWidget {
  final String id;
  // final String profession;

  const Hospital({super.key, required this.id});

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  List<Map<String, dynamic>> Details = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      String queryTokens = widget.id;
      // QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(widget.profession).where('id', isEqualTo: queryTokens).get();
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("AllHospital").where('uId', isEqualTo: queryTokens).get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();

        // Creating a map for the new job data
        Map<String, dynamic> newJobData = {
          "name": dataMap['name'] ?? 'name',
          "mobile": dataMap['mobile'] ?? 'phone',
          "address": dataMap['city'] ?? 'address',
          "image": dataMap['image'] ?? 'assets/d3.png',
          "experience": dataMap['experience'] ?? 'experience',
          "department": dataMap['department'] ?? 'department',
        };

        // Updating the state to reflect the new data
        setState(() {
          Details.add(newJobData);
          // Details.add(dataMap);
          isLoading = false;
        });
        print("Job data added: $Details");
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 110.0), child: const NavBarBooking()),
      drawer: CustomDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          // : Container()
          : Responsive(
              mobile: HospitalMobile(
                Details: Details,
              ),
              tablet: HospitalMobile(
                Details: Details,
              ),
              desktop: HospitalWeb(
                Details: Details,
              ),
            ),
    );
  }
}
