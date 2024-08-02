import 'package:aapkacare/values/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _appointmentDateController = TextEditingController();
  TextEditingController _preferredTimeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _streetAddressController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          'Book Appointment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // color: Colors.blue[50],
            padding: EdgeInsets.symmetric(horizontal: s.width < 1000 ? 32 : s.width * .3, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book An Appointment Online!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We have the best specialists in your region. Quality, guarantee and professionalism are our slogan!',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      // You can add more complex email validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _appointmentDateController,
                    decoration: InputDecoration(
                      labelText: 'Appointment Date',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter appointment date';
                      }
                      // You can add date format validation or range validation here
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _preferredTimeController,
                    decoration: InputDecoration(
                      labelText: 'Preferred Time',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter preferred time';
                      }
                      // You can add time format validation or range validation here
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // You can add more complex phone number validation if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _streetAddressController,
                    decoration: InputDecoration(
                      labelText: 'Street Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your street address';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      // Optional: Add validation for message if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          Text(
                            '  Submit',
                            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // Validate the form before submitting
                        if (_formKey.currentState!.validate()) {
                          // Process the form data, e.g., submit to backend
                          // For now, just show a dialog or navigate
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Appointment Submitted'),
                                content: Text('Your appointment details have been submitted.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Optionally navigate to a new screen or pop the route
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  // Container(
                  //   height: 48,
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Validate the form before submitting
                  //       if (_formKey.currentState!.validate()) {
                  //         // Process the form data, e.g., submit to backend
                  //         // For now, just show a dialog or navigate
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //               title: Text('Appointment Submitted'),
                  //               content: Text('Your appointment details have been submitted.'),
                  //               actions: <Widget>[
                  //                 TextButton(
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                     // Optionally navigate to a new screen or pop the route
                  //                   },
                  //                   child: Text('OK'),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //       }
                  //     },
                  //     child: Text('Submit'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';


// class AppointmentScreen extends StatefulWidget {
//   @override
//   _AppointmentScreenState createState() => _AppointmentScreenState();
// }

// class _AppointmentScreenState extends State<AppointmentScreen> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//             color: Colors.white
//         ),
//         backgroundColor: Colors.blue,
//         title: Text('Book Appointment',style: TextStyle(color: Colors.white)),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             height: MediaQuery.of(context).size.height*1.3,
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Container(

//                     color: Colors.blue.shade50,
//                     child: Center(
//                       child: Image.asset(
//                         'assets/d4.png', // Make sure to add your image in the assets folder
//                         width: 300,
//                         height: 300,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(32.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Book An Appointment Online!',
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'We have the best specialists in your region. Quality, guarantee and professionalism are our slogan!',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 32),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Your Name"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height:45,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: TextField(
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.normal
//                                           ),
//                                           decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Expanded(
//                               child: Container(
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Appliance Type"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: DropdownButtonFormField<String>(
//                                           decoration: InputDecoration(
//                                             fillColor: Colors.white,
//                                             focusColor: Colors.white,
//                                             border: InputBorder.none,
//                                             hoverColor: Colors.white
//                                           ),

//                                           focusColor: Colors.white,
//                                           dropdownColor: Colors.white,


//                                           items: ['Type 1', 'Type 2', 'Type 3'].map((String value) {
//                                             return DropdownMenuItem<String>(
//                                               alignment: Alignment.center,
//                                               value: value,
//                                               child: Text(value,style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.normal
//                                               ),),
//                                             );
//                                           }).toList(),
//                                           onChanged: (_) {},
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Appointment Date"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: Expanded(
//                                           child: TextField(

//                                             style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.normal
//                                             ),
//                                             decoration: InputDecoration(
//                                             border: InputBorder.none
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Expanded(
//                               child: Container(
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Preferred Time"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: TextFormField(
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.normal
//                                           ),
//                                           decoration: InputDecoration(
//                                             border: InputBorder.none,

//                                           ),

//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Email Address"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: TextFormField(
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.normal
//                                           ),
//                                           decoration: InputDecoration(

//                                             border: InputBorder.none,

//                                           ),

//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Expanded(
//                               child: Container(
//                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text("Phone Number"),
//                                     SizedBox(height: 5,),
//                                     Container(
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           border: Border.all(color: Colors.black38)
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                         child: TextField(
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.normal
//                                           ),
//                                           keyboardType: TextInputType.number,
//                                           decoration: InputDecoration(

//                                             border: InputBorder.none,

//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         SizedBox(height: 16),
//                         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("City"),
//                             SizedBox(height: 5,),
//                             Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: Colors.black38)
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                                 child: TextFormField(
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.normal
//                                   ),
//                                   decoration: InputDecoration(

//                                     border: InputBorder.none,
//                                   ),

//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("Street Address"),
//                             SizedBox(height: 5,),
//                             Container(
//                               height: 45,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: Colors.black38)
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: TextFormField(
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.normal
//                                   ),
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,

//                                   ),

//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("Your Message"),
//                             SizedBox(height: 5,),
//                             Container(
//                               height: 105,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(color: Colors.black38)
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 child: TextFormField(
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.normal
//                                   ),
//                                   decoration: InputDecoration(

//                                     border: InputBorder.none,
//                                   ),
//                                   maxLines: 4,

//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         SizedBox(height: 16),
//                         Container(
//                           height: 48,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5)
//                               )
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                              Icon(Icons.send,color: Colors.white,),
//                                Text('  Submit',style: TextStyle(
//                                    fontSize: 15,
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700
//                                ),),
//                             ],),
//                             onPressed: () {

//                             },

//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
