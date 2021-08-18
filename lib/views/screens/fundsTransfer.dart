import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/accountBlocked.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundsTransfer extends StatefulWidget {
  const FundsTransfer({Key? key}) : super(key: key);

  @override
  _FundsTransferState createState() => _FundsTransferState();
}

class _FundsTransferState extends State<FundsTransfer> {
  blockAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('current_user');
    UserModel userModel = UserModel.fromJSON(json.decode(user!)['data']);
    api.blockAccount(id: userModel.id);
  }

  ApiService api = new ApiService();
  startTimer(BuildContext context) async {
    return Timer(
      const Duration(seconds: 10),
      () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AccountBlocked(),
            ),
            (route) => false);
      },
    );
  }

  @override
  void initState() {
    blockAccount();
    startTimer(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('Funds Transfer', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularPercentIndicator(
            radius: 200.0,
            lineWidth: 13.0,
            animation: true,
            animationDuration: 7200,
            percent: 0.97,
            center: new Text(
              "Transfering Funds...",
              style: new TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ),
      ),
    );
  }
}
