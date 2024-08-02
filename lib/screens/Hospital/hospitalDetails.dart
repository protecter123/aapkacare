import 'dart:math';

import 'package:aapkacare/screens/Hospital/hospitalData.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';
import '../appointment/appointment.dart';

class HospitalDetails extends StatefulWidget {
  final String hospitalName;

  const HospitalDetails({super.key, required this.hospitalName});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  @override
  void initState() {
    super.initState();
    print('...${widget.hospitalName}');
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text('Hospital Details', style: TextStyle(color: Colors.white)),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('AllHospital').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              // var hospital = snapshot.data!.docs.first.data(); // Accessing the first document's data
              var hospital = snapshot.data!.docs.where((doc) {
                return (doc['city']).toLowerCase().contains(widget.hospitalName.toLowerCase());
              }).toList();

              if (hospital.isEmpty) {
                return Container(
                  child: Text('No Data'),
                );
              }

              return ListView.builder(
                  itemCount: hospital.length,
                  itemBuilder: (context, index) {
                    var hospitals = hospital[index];
                    var hospitalData = hospital[index].data() as Map<String, dynamic>;
                    var imageUrls = hospitalData['imageUrls'] as List<dynamic>?;

                    // Get the 0th index image URL if available
                    var imageUrl = imageUrls != null && imageUrls.isNotEmpty ? imageUrls[0] : "assets/noimage.png"; // Use a default image URL

                    final random = Random();
                    final randomEnquiries = random.nextInt(50) + 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: InkWell(
                        onTap: () {
                          // print(hospitalData);
                          // print(imageUrl);
                         context.go(
                      '/${Uri.encodeComponent(hospitals['city'].toString())}/${Uri.encodeComponent(hospitals['name'].toString())}');
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ImageNetwork(
                                      image: imageUrl,
                                      height: 100,
                                      width: 100,
                                      fullScreen: false,
                                      fitAndroidIos: BoxFit.fill,
                                      fitWeb: BoxFitWeb.fill,
                                      onLoading: CircularProgressIndicator(
                                        color: Colors.blue,
                                        strokeWidth: .8,
                                      ),
                                    ),
                                    // Image(
                                    //   image: NetworkImage(
                                    //     "assets/noimage.png",
                                    //   ),
                                    //   width: 100,
                                    //   height: 100,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hospitals['name'] ?? 'Unknown',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star, color: Colors.orange),
                                              Text(
                                                "4.5",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text('  (55 Rating)'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on),
                                              Flexible(child: Text(hospitals['address'] ?? 'Address not available', overflow: TextOverflow.ellipsis)),
                                            ],
                                          ),
                                          Text("  Health Care Package"),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _launchPhoneCall('+919821527088');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                    ),
                                                    Text(" +919821527088", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => appointment(uId: hospitals['uId']),
                                                      ));
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Book Appointment',
                                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                ),
                                                onPressed: () {
                                                  _launchWhatsAppChat('+919821527088', 'Hello!');
                                                },
                                                child: Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.whatsapp,
                                                      color: Colors.green,
                                                    ),
                                                    Text('  Chat', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Text('${randomEnquiries} people recently enquired'),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
