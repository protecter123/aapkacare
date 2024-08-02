import 'package:aapkacare/screens/appointment/successAppointment.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> Data;
  final String dateTime;

  const DoctorAppointmentScreen({super.key, required this.Data, required this.dateTime});
  @override
  _DoctorAppointmentScreenState createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selectedExperience;

  bool nameError = false;
  bool phoneError = false;
  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Book An Appointment Online!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: s.width < 720 ? 20 : 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We have the best specialists in your region. Quality, guarantee and professionalism are our slogan!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: s.width < 720 ? 14 : 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.width < 720 ? 16.0 : 32.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue, width: .8),
                        boxShadow: [
                          BoxShadow(offset: Offset(0, 2), color: Colors.grey.shade200, spreadRadius: 3, blurRadius: 5),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Appointment Date : ${widget.dateTime}',
                              style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500, height: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        focusColor: Colors.black,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name address';
                        }
                        // You can add more complex email validation if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        focusColor: Colors.black,
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone Number address';
                        } else if (value.length != 10) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        // You can add more complex email validation if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.black,
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // You can add more complex email validation if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    buildCustomDropdownForm(
                      hintText: 'Gender',
                      items: [
                        'Male',
                        'Female'
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          selectedExperience = value;
                          print("object.................$selectedExperience");
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Wrap(
                      spacing: 30,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Container(
                          height: 48,
                          width: s.width < 720 ? double.infinity : 190,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
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
                                  style: GoogleFonts.montserrat(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await FirebaseFirestore.instance.collection('RequestAppointment').add({
                                  'name': nameController.text,
                                  'patient_number': '+91${phoneController.text}',
                                  'email': emailController.text,
                                  'Created at': DateTime.now(),
                                  'gender': selectedExperience ?? 'gender',
                                  'isJoined': false,
                                  'uId': widget.Data['uId'],
                                  'joinDate': widget.dateTime,
                                  // ...widget.Data
                                });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(content: Text('Appointment Request Sent')),
                                // );
                                nameController.clear();
                                phoneController.clear();
                                emailController.clear();
                                setState(() {
                                  selectedExperience = null;
                                });
                                Navigator.pop(context);
                                _showAlert(context);
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SuccessfulAppointment()));
                              } else {
                                setState(() {
                                  // Update error flags based on validation results
                                  nameError = nameController.text.isEmpty;
                                  phoneError = phoneController.text.isEmpty || phoneController.text.length != 10;
                                  emailError = emailController.text.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text);
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          height: 48,
                          width: s.width < 720 ? double.infinity : 190,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close_sharp,
                                  color: Colors.red,
                                ),
                                Text(
                                  '  Cancel',
                                  style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: InputBorder.none,
            content: Container(
              height: 600,
              width: 500,
              child: SuccessfulAppointment(),
            ));
      },
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
        cardColor: Colors.white,
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        ),
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ).pOnly(top: 4),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // iconSize: 28,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ).pOnly(top: 2),
        dropdownColor: Colors.white,
      ),
    );
  }
}
