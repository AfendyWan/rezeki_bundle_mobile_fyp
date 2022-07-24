
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rezeki_bundle_mobile/screens/Welcome/welcome_screen.dart';
import 'package:rezeki_bundle_mobile/constants.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 10;
  }
}

void main(){
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rezeki Bundle',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
