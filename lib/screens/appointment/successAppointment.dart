import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/values/screen.dart';
import 'package:aapkacare/values/values.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfulAppointment extends StatefulWidget {
  const SuccessfulAppointment({super.key});

  @override
  State<SuccessfulAppointment> createState() => _SuccessfulAppointmentState();
}

class _SuccessfulAppointmentState extends State<SuccessfulAppointment> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/success.json', fit: BoxFit.contain),
            Text(
              "Appointment Book Successfully",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.blue, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
