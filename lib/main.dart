import 'package:aapkacare/Router.dart';
import 'package:aapkacare/fetch.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Hospital/hospital_Search.dart';
import 'package:aapkacare/screens/Result%20Page/doctorsearch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'utils/app_theme.dart' as app_theme;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          //
          apiKey: "AIzaSyArH2J1b59uuL09t0PH6VI5HekBOOSp7A8",
          authDomain: "aapkacare-dc252.firebaseapp.com",
          projectId: "aapkacare-dc252",
          storageBucket: "aapkacare-dc252.appspot.com",
          messagingSenderId: "489116955693",
          appId: "1:489116955693:web:c5a08fe06adde4ae70f4a4",
          measurementId: "G-2E965SP2X1"
          // apiKey: "AIzaSyAQ9XIcDlN2FuQ9vg1JfyjTRhg2oMvDZQE",
          // authDomain: "aapka--care.firebaseapp.com",
          // projectId: "aapka--care",
          // storageBucket: "aapka--care.appspot.com",
          // messagingSenderId: "333668592864",
          // appId: "1:333668592864:web:fbb925358b24605641b485",
          // measurementId: "G-FQ5DBV0BKD"
          // apiKey: "AIzaSyA_68RTO8v1aaZm3L1uScwhFjwcAeLKum0", authDomain: "medeasy-829d9.firebaseapp.com", projectId: "medeasy-829d9", storageBucket: "medeasy-829d9.appspot.com", messagingSenderId: "529282502849", appId: "1:529282502849:web:fa17872311f85db0350440", measurementId: "G-7K6GMMMX01",
          ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: app_theme.lightThemeData,
      title: 'AAPKA CARE',
     routerConfig: router,
      // Fetch()
      // DoctorSearch()
      // HospitalSearch()
      //     DoctorDetailsPage(
      //   id: 'DR.PRAMOD',
      //   uId: 'sankalpa@aapkacare.com',
      // ),
    );
  }
}
