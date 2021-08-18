import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/routes/routes.dart';
import 'package:growth/views/screens/homeScreen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  ApiService api = new ApiService();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Sign In', style: TextStyle(color: Colors.black)),
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
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(type == 'email' ? Icons.person : Icons.lock)),
        ));
  }

  Widget buildLargeButton() {
    return GestureDetector(
        onTap: () {
          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please fill all details"),
              ),
            );
          } else {
            showLoaderDialog(context);
            api
                .login(
                    email: emailController.text,
                    password: passwordController.text)
                .then((value) {
              Navigator.pop(context);
              if (value['success'] == true) {
                UserModel user = UserModel.fromJSON(value['data']);
                print(value['data']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(user: user),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${value['message']}"),
                  ),
                );
              }
            });
          }

          // Navigator.of(context).pushNamed(RouteNames.homeScreen);
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
        ));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
        content: new Row(children: [
      CircularProgressIndicator(),
      Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
    ]));

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
