import 'package:flutter/material.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/loanForm.dart';

class LoanScreen extends StatefulWidget {
  final UserModel user;
  const LoanScreen({Key? key, required this.user}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loan.png'))),
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Center(
                  child: Text('GSCB Loans',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 40)),
                ),
              ),
              Positioned(
                  left: 9,
                  top: 40,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About our soft loans', style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'We offer loan services to all our users from any country. Our loan terms and conditons are very flexible with fair interest rates. No collateral? No problem. We offer both collateral and non-collateral loans. Click the button below to apply for a soft loan now.'),
                SizedBox(
                  height: 40,
                ),
                buildLargeButton()
              ],
            ),
          )
        ])));
  }

  Widget buildLargeButton() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoanForm(user: widget.user)),
          );
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Apply now',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
        ));
  }
}
