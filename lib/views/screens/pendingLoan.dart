import 'package:flutter/material.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/homeScreen.dart';

class PendingLoan extends StatefulWidget {
  final UserModel user;
  const PendingLoan({Key? key, required this.user}) : super(key: key);

  @override
  _PendingLoanState createState() => _PendingLoanState();
}

class _PendingLoanState extends State<PendingLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/suspended.png',
              height: 250,
            ),
            SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Your loan request is pending. Someone from GSCB will get in touch with you shortly.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            buildLargeButton()
          ],
        )),
      ),
    );
  }

  Widget buildLargeButton() {
    return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: widget.user),
            ),
          );
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Return to dashboard',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
        ));
  }
}
