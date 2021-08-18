import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Sign Up', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(height: 8),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/login.png')),
          SizedBox(height: 20),
          buildInputField(type: 'email', controller: emailController),
          SizedBox(height: 30),
          buildInputField(type: 'password', controller: passwordController),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: () {}, child: Text('Forgot password?')),
              ],
            ),
          ),
          buildLargeButton(),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
                text: 'Don\'t have an account?',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // navigate to desired screen
                        })
                ]),
          ),
        ])));
  }

  Widget buildInputField(
      {required String type, required TextEditingController controller}) {
    return Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(15)),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(type == 'email' ? Icons.person : Icons.lock)),
        ));
  }

  Widget buildLargeButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text('Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400))),
    );
  }
}
