// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/routes/routes.dart';
import 'package:growth/views/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/images/logo.png', height: 400)));
  }

  startTimer(BuildContext context) async {
    return Timer(
      const Duration(seconds: 5),
      () async {
        checkUserStatus();
      },
    );
  }

  checkUserStatus() async {
    print('checking user login');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('current_user');
    print(user);

    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteNames.onboardingScreen);
    } else {
      UserModel userModel = UserModel.fromJSON(json.decode(user)['data']);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(user: userModel),
          ),
          (route) => false);
    }
  }
}
