import 'package:aapkacare/screens/Result%20Page/SearchPage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorSearch extends StatefulWidget {
  const DoctorSearch({super.key});

  @override
  State<DoctorSearch> createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);

    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      backgroundColor: Colors.blue[50],
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 112.0),
          child: const NavBarBooking(
            Doctor: false,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: s.width < 720 ? s.width : 500,
                  height: 500,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CityDropdownPage(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CityDropdownPage extends StatefulWidget {
  @override
  _CityDropdownPageState createState() => _CityDropdownPageState();
}

class _CityDropdownPageState extends State<CityDropdownPage> {
  final TextEditingController locationController = TextEditingController();
  String? _selectedCity;
  List<String> cityNames = [];
  List<String> _experiences = [
    'Doctors',
    'Hospitals'
  ]; // Add your options here

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase('AllHospital');
  }

  Future<void> fetchDataFromFirebase(String collectionName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();

      Set<String> citySet = {}; // Use a Set to avoid duplicates

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();
        citySet.add(dataMap['city']);
      }

      setState(() {
        cityNames = citySet.toList();
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              value: _selectedCity,
              alignment: Alignment.bottomCenter,
              menuMaxHeight: 400,
              isExpanded: true, // Ensure the selected text is fully visible
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCity = newValue;
                  locationController.text = newValue ?? '';
                });
              },
              items: cityNames
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
                hintText: 'Search City',
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
        InkWell(
          onTap: () {
            if (locationController.text.isNotEmpty) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(
                        profession: 'Doctors',
                        location: locationController.text,
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
    );
  }
}
