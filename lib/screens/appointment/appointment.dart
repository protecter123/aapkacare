import 'package:aapkacare/screens/Profile%20Page/DoctorDetailsPage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/widgets/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:velocity_x/velocity_x.dart';

class appointment extends StatefulWidget {
  final uId;
  const appointment({super.key, this.uId});

  @override
  State<appointment> createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          title: Text(
            "Appointments",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: DoctorList(
          uId: widget.uId,
        )
        // Center(
        //   child: Container(
        //     width: s.width * (s.width < 1024 ? 1 : .7),
        //     child: StreamBuilder(
        //         stream: FirebaseFirestore.instance.collection('AllHospital').doc(widget.uId).collection("Doctors").snapshots(),
        //         builder: (context, snapshot) {
        //           if (!snapshot.hasData) {
        //             return Center(child: CircularProgressIndicator());
        //           }

        //           var doctors = snapshot.data!.docs; // Accessing the first document's data
        //           return ListView.builder(
        //             // padding: const EdgeInsets.all(16.0),
        //             itemCount: doctors.length,
        //             itemBuilder: (context, index) {
        //               var hospital = doctors[index].data();
        //               print('$hospital.............');
        //               return SingleChildScrollView(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(16.0),
        //                   child: Container(
        //                     width: MediaQuery.of(context).size.width * .7,
        //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(16.0),
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         children: [
        //                           Row(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             children: [
        //                               Image(
        //                                 image: AssetImage(
        //                                   "assets/download.jpeg",
        //                                 ),
        //                                 width: 100,
        //                                 height: 100,
        //                                 fit: BoxFit.cover,
        //                               ),
        //                               SizedBox(width: 16),
        //                               Expanded(
        //                                 child: Column(
        //                                   crossAxisAlignment: CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       hospital['name'],
        //                                       style: TextStyle(
        //                                         fontSize: 24,
        //                                         fontWeight: FontWeight.bold,
        //                                       ),
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         Icon(Icons.star, color: Colors.orange),
        //                                         Text(
        //                                           "4.5",
        //                                           style: TextStyle(fontSize: 20),
        //                                         ),
        //                                         Text('  (55 Rating)'),
        //                                       ],
        //                                     ),
        //                                     Row(
        //                                       children: [
        //                                         Icon(Icons.school_outlined),
        //                                         Expanded(
        //                                           child: Text(
        //                                             " ${hospital['qualification']}",
        //                                             overflow: TextOverflow.ellipsis,
        //                                             maxLines: 3,
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                     Text("Experience: ${hospital['experience']} year"),
        //                                     Text("Speciality: ${hospital['speciality']}"),
        //                                     Text('21 people recently enquired'),
        //                                     s.width > 720
        //                                         ? Container()
        //                                         : ElevatedButton(
        //                                             style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue),
        //                                             onPressed: () {
        //                                               Navigator.push(
        //                                                   context,
        //                                                   MaterialPageRoute(
        //                                                     builder: (context) => Calendar(
        //                                                       Data: {
        //                                                         ...hospital,
        //                                                         'uId': widget.uId
        //                                                       },
        //                                                     ),
        //                                                   ));
        //                                             },
        //                                             child: Row(
        //                                               mainAxisSize: MainAxisSize.min,
        //                                               children: [
        //                                                 Text(
        //                                                   'Book Appointment',
        //                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        //                                                 ),
        //                                               ],
        //                                             ),
        //                                           ),
        //                                   ],
        //                                 ),
        //                               ),
        //                               s.width < 720
        //                                   ? Container()
        //                                   : ElevatedButton(
        //                                       style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue),
        //                                       onPressed: () {
        //                                         Navigator.push(
        //                                             context,
        //                                             MaterialPageRoute(
        //                                               builder: (context) => Calendar(
        //                                                 Data: {
        //                                                   ...hospital,
        //                                                   'uId': widget.uId
        //                                                 },
        //                                               ),
        //                                             ));
        //                                       },
        //                                       child: Row(
        //                                         children: [
        //                                           Text(
        //                                             'Book Appointment',
        //                                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                             ],
        //                           ),
        //                           SizedBox(height: 16),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //           );
        //         }),
        //   ),
        // ),
        );
  }
}

class DoctorList extends StatelessWidget {
  final String uId;
  const DoctorList({super.key, required this.uId});
  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Center(
      child: Container(
        width: s.width * (s.width < 1024 ? 1 : .7),
        // height: 800,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('AllHospital').doc(uId).collection("Doctors").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: .9,
                  ).pOnly(top: 40),
                );
              }

              var doctors = snapshot.data!.docs;
              if (doctors.isEmpty) {
                return Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }

              return ListView.builder(
                // padding: const EdgeInsets.all(16.0),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  var hospital = doctors[index].data();
                  print('$hospital.............');

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          // print('${hospital['name']}');
                          print(uId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorDetailsPage(
                                        id: hospital['name'],
                                        uId: uId,
                                        image: hospital['imageUrl'] ?? 'assets/doc.png',
                                      )
                                  // Profile(
                                  //       Data: hospital,
                                  //     )
                                  ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .7,
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
                                    // Image(
                                    //   image: AssetImage(
                                    //     "assets/download.jpeg",
                                    //   ),
                                    //   width: 100,
                                    //   height: 100,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ImageNetwork(
                                      image: hospital['imageUrl'] ?? "assets/doc.png",
                                      width: 100,
                                      height: 100,
                                      onLoading: CircularProgressIndicator(color: Colors.blue, strokeWidth: .8),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hospital['name'],
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
                                              Icon(Icons.school_outlined),
                                              Expanded(
                                                child: Text(
                                                  " ${hospital['qualification']}",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Experience: ${hospital['experience']} year",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Speciality: ${hospital['speciality']}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text('21 people recently enquired'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          s.width > 720
                                              ? Container()
                                              : ElevatedButton(
                                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Calendar(
                                                            Data: {
                                                              ...hospital,
                                                              'uId': uId
                                                            },
                                                          ),
                                                        ));
                                                  },
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Book Appointment',
                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    s.width < 720
                                        ? Container()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor: Colors.blue),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Calendar(
                                                      Data: {
                                                        ...hospital,
                                                        'uId': uId
                                                      },
                                                    ),
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
                                  ],
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
