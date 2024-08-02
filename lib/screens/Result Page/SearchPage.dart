import 'package:aapkacare/screens/Drawer/drawer.dart';
import 'package:aapkacare/screens/Profile%20Page/Profile.dart';
import 'package:aapkacare/screens/appointment/doctorappointment.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/calendar.dart';
import 'package:aapkacare/widgets/navbarBooking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPage extends StatefulWidget {
  final String profession;
  final String location;

  const SearchPage({super.key, required this.profession, required this.location});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> ResultDataList = [];
  List<Map<String, dynamic>> filteredList = [];
  TextEditingController _searchController = TextEditingController();
  bool isLoading = true;

  String? selectedExperience;
  String? selectedRelevance;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
    _searchController.addListener(_filterResults);
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      String normalizedQuery = widget.location.toLowerCase();
      List<String> queryTokens = normalizedQuery.split(',').map((s) => s.trim()).toList();
      // QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(widget.profession).get();
      // QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('AllDoctors').get();
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('All${widget.profession}').get();

      List<Map<String, dynamic>> tempList = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> dataMap = doc.data();
        // String address = dataMap['address'] ?? '';
        String address = dataMap['city'] ?? '';
        List<String> addressTokens = address.toLowerCase().split(',').map((s) => s.trim()).toList();
        bool matches = queryTokens.any((queryToken) => addressTokens.contains(queryToken));

        if (matches) {
          tempList.add(dataMap);
        }
      }

      setState(() {
        ResultDataList = tempList;
        filteredList = tempList;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterResults() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredList = ResultDataList.where((data) {
        String name = data['name']?.toLowerCase() ?? '';
        int experience = int.tryParse(data['experience']?.toString() ?? '0') ?? 0;

        bool matchesQuery = name.contains(query);

        bool matchesExperience = selectedExperience == null || experience <= int.parse(selectedExperience!.split('+').first.trim());

        return matchesQuery && matchesExperience;
      }).toList();

      if (selectedRelevance != null) {
        if (selectedRelevance == 'Experience - Low to High') {
          filteredList.sort((a, b) => b['experience'].compareTo(a['experience']));
        } else if (selectedRelevance == 'Experience - High to Low') {
          filteredList.sort((a, b) => a['experience'].compareTo(b['experience']));
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterResults);
    _searchController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(s.width < 1024 ? 60.0 : 110.0), child: const NavBarBooking()),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: s.width < 720 ? 80 : 100,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: .4),
                ),
                height: 50,
                width: s.width / (s.width > 700 ? 2 : 1.05),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          cursorColor: Colors.black,
                          showCursor: true,
                          decoration: InputDecoration.collapsed(
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            hintText: 'Search By Name',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: s.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 27, 181, 253),
                border: Border.all(color: Color.fromARGB(42, 0, 0, 0)),
              ),
              child: Wrap(
                spacing: s.width < 720 ? 10 : 50 * s.customWidth,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 110,
                  //   height: 35,
                  //   child: buildCustomDropdownForm(
                  //       hintText: 'Gender',
                  //       items: [
                  //         "Female",
                  //         "Male"
                  //       ],
                  //       onChanged: (String? value) {
                  //         print("object...................$value");
                  //       }),
                  // ),
                  // SizedBox(
                  //   width: 150,
                  //   height: 35,
                  //   child: buildCustomDropdownForm(
                  //       hintText: 'Patient Stories',
                  //       items: [
                  //         "10+ Patient",
                  //         "30+ Patient",
                  //         "50+ Patient",
                  //         "100+ Patient",
                  //       ],
                  //       onChanged: (String? value) {
                  //         print("object.................$value");
                  //       }),
                  // ),
                  SizedBox(
                    width: 125,
                    height: 35,
                    child: buildCustomDropdownForm(
                      hintText: 'Experience',
                      items: [
                        "2+ Year",
                        "5+ Year",
                        "10+ Year",
                        "15+ Year",
                        "20+ Year",
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          selectedExperience = value;
                          _filterResults();
                          print("object.................$selectedExperience");
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    height: 35,
                    child: buildCustomDropdownForm(
                        hintText: 'Relevance',
                        items: [
                          "Fees - Low to High",
                          "Fees - High to Low",
                          // "Patients - High to Low",
                          "Experience - High to Low",
                          "Experience - Low to High",
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedRelevance = value;
                            _filterResults();
                            print("object.................$selectedRelevance");
                          });
                        }),
                  ),
                  // More SizedBox widgets here...
                ],
              ),
            ),
            SizedBox(
              height: 600 * s.customHeight, // Example height, adjust as needed
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          // Your other content here
                          Container(
                            // height: 500, // Example height for the ListView container
                            child: isLoading
                                ? Container(
                                    height: 300,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    )))
                                : ResultDataList.isEmpty
                                    ? Container(
                                        height: 300,
                                        child: Center(
                                            child: Text(
                                          'No Data',
                                          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.blue),
                                        )),
                                      )
                                    : filteredList.isEmpty
                                        ? Container(
                                            height: 300,
                                            child: Center(
                                                child: Text(
                                              'No Data',
                                              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.blue),
                                            )),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: filteredList.length,
                                            itemBuilder: (context, index) {
                                              var data = filteredList[index];
                                              return Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(width: .9, color: Colors.grey.shade500),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        _buildDoctorImage(Data: data),
                                                        Expanded(child: _buildDoctorDetails(Data: data)),
                                                        s.width < 720
                                                            ? Container()
                                                            : SizedBox(
                                                                width: 20,
                                                              ),
                                                        s.width < 720 ? Container() : clinicDetails(Data: data) // No Expanded here
                                                      ],
                                                    ),
                                                    s.width > 720
                                                        ? Container()
                                                        : Container(
                                                            decoration: BoxDecoration(border: Border(top: BorderSide(width: .8, color: Colors.grey.shade300))),
                                                            child: clinicDetails(Data: data), // No Expanded here
                                                          ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                          ),
                        ],
                      ).px(s.width < 1024 ? 0 : 32),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Copyright @2023 All Rights Reserved by Aapka Care |  Designed & Developed by Fuerte Developers.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput(String hintText, IconData icon) {
    Screen s = Screen(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: .4),
      ),
      height: 50,
      width: s.width / (s.width > 700 ? 2 : 1.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                icon,
                color: Colors.grey.shade400,
              ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                showCursor: true,
                decoration: InputDecoration.collapsed(
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hintText: hintText,
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                ),
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomDropdownForm({
    required List<String> items,
    required String hintText,
    Icon? icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Theme(
      data: ThemeData(
        focusColor: Colors.lightBlue,
        cardColor: Colors.black,
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        ),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ).pOnly(top: 4),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // iconSize: 28,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ).pOnly(top: 2),
        dropdownColor: Colors.black,
      ),
    );
  }

  Widget boxData({required String text}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(),
      ),
    );
  }

  Widget _buildDoctorImage({required Map<String, dynamic> Data}) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profile(
                                Data: Data,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                        child: Data['imgUrl'] != null
                            ? Image.asset('assets/doc.png', fit: BoxFit.fill)
                            : ImageNetwork(
                                // Data['image'],
                                image: Data['imgUrl'] ?? 'assets/doc.png',
                                // fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              )
                        // Image.asset('assets/d9.png', fit: BoxFit.fill),
                        ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      margin: EdgeInsets.only(top: 15, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Aapka care',
                            style: GoogleFonts.montserrat(color: Colors.purple, fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Clinic',
                            style: GoogleFonts.montserrat(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.purple,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.video_camera_front_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDoctorDetails({required Map<String, dynamic> Data}) {
    Screen s = Screen(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Data['name'] ?? 'Doctor Name',
            // 'Dr. Keval Shah',
            style: GoogleFonts.montserrat(
              fontSize: s.width > 720 ? 18 : 16,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Text(Data['qualification'] ?? 'qualification', style: GoogleFonts.poppins(fontSize: s.width > 720 ? 16 : 12)),
          Text('Specialist in : ', overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontSize: s.width > 720 ? 16 : 12, fontWeight: FontWeight.bold)),
          // Text(Data['specialist'], overflow: TextOverflow.ellipsis, maxLines: 2, style: GoogleFonts.poppins(fontSize: s.width > 720 ? 16 : 12)),
          Text(Data['speciality'] ?? 'speciality', overflow: TextOverflow.ellipsis, maxLines: 2, style: GoogleFonts.poppins(fontSize: s.width > 720 ? 16 : 12)),
          Data['experience'] == null ? SizedBox.shrink() : Text('${Data['experience'] ?? '0'} Years Experience', style: GoogleFonts.poppins(fontSize: s.width > 720 ? 16 : 12)),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text('10 %', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: s.width > 720 ? 16 : 12)),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text('30 Patient', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: s.width > 720 ? 16 : 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget clinicDetails({required Map<String, dynamic> Data}) {
    return Container(
      // Removed Expanded
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(5)),
            child: Text(
              'Holistic Care Doctor',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(height: 15),
          // Row(
          //   children: [
          //     Data['city'] == null
          //         ? SizedBox.shrink()
          //         : Text(
          //             // '${Data['address']} •',
          //             '${Data['city']} •',
          //             style: GoogleFonts.montserrat(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //     Text(
          //       '  Sharma hospital',
          //       style: GoogleFonts.montserrat(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.grey.shade700,
          //       ),
          //     ),
          //   ],
          // ),
          Text(
            '  Consultation Fees',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            '~₹ 1000',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            'Free Booking',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          // Row(
          //   children: [
          //     Column(
          //       children: [
          //         Text(
          //           '~₹ 1000',
          //           style: GoogleFonts.montserrat(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             decoration: TextDecoration.lineThrough,
          //           ),
          //         ),
          //         Text(
          //           'Free Booking',
          //           style: GoogleFonts.montserrat(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.green,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Text(
          //       '  Consultation Fees',
          //       style: GoogleFonts.montserrat(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.grey.shade700,
          //       ),
          //     ),
          //   ],
          // ),

          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Calendar(
                            Data: Data,
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Book Appointment',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
