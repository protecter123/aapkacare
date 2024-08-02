import 'package:flutter/material.dart';

import 'package:aapkacare/responsive.dart';
import 'package:aapkacare/screens/Profile%20Page/profile_mobile.dart';
import 'package:aapkacare/screens/Profile%20Page/profile_web.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> Data;

  const Profile({super.key, required this.Data});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    print(widget.Data);
  }

  // final String specification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: ProfileMobile(
          image: 'assets/doctor.png',
          city: widget.Data['city'] ?? 'city',
          name: widget.Data['name'] ?? 'name',
          specification: widget.Data['speciality'] ?? 'speciality',
          uId: widget.Data['uId'] ?? 'uId',
        ),
        tablet: DoctorWeb(
          image: 'assets/doctor.png',
          city: widget.Data['city'] ?? 'city',
          name: widget.Data['name'] ?? 'name',
          specification: widget.Data['speciality'] ?? 'speciality',
          uId: widget.Data['uId'] ?? 'uId',
        ),
        desktop: DoctorWeb(
          // image: Data['imgUrl'],
          image: 'assets/doctor.png',
          city: widget.Data['city'] ?? 'city',
          name: widget.Data['name'] ?? 'name',
          specification: widget.Data['speciality'] ?? 'speciality',
          uId: widget.Data['uId'] ?? 'uId',
        ),
      ),
    );
  }
}
