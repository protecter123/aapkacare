import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aapkacare/screens/Home%20Page/homePage.dart';
import 'package:aapkacare/screens/Hospital/hospitalData.dart'; // Assuming Extra is in hospitalData.dart

final GoRouter router = GoRouter(
  routes: [
    GoRoute(   
      path: '/',
        
        
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/:city/:name',
      builder: (context, state) {
        final city = Uri.decodeComponent(state.pathParameters['city']!);
        
        final name = Uri.decodeComponent(state.pathParameters['name']!);
        return Extra(city: city,name:name);
      },
    ),
  ],
);
