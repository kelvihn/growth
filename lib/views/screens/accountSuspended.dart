import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSuspended extends StatefulWidget {
  const AccountSuspended({Key? key}) : super(key: key);

  @override
  _AccountSuspendedState createState() => _AccountSuspendedState();
}

class _AccountSuspendedState extends State<AccountSuspended> {
  var _url = 'https://growthchartered.com';

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
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
                'It seems your account has been suspended. Kindly report this problem to our live chat via the GSBC website. ',
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
          _launchURL();
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Go to site',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
        ));
  }
}
