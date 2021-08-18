import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiService api = new ApiService();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    emailController.value = TextEditingValue(text: widget.user.email);
    nameController.value = TextEditingValue(text: widget.user.name);
    phoneController.value = TextEditingValue(text: widget.user.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    //UserModel user = userProvider.user;

    Widget buildLargeButton() {
      return GestureDetector(
          onTap: () {
            showLoaderDialog(context);
            userProvider.user.email = emailController.text;
            userProvider.user.phone = phoneController.text;
            userProvider.user.name = nameController.text;
            api
                .updateProfile(
                    id: widget.user.id,
                    email: emailController.text,
                    phone: phoneController.text,
                    name: nameController.text)
                .then((value) {
              Navigator.pop(context);
              userProvider.setUser(userProvider.user);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Profile updated sucessfully"),
                ),
              );
            });
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text('Update Profile',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400))),
          ));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Edit Profile', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Center(
                  child: Column(children: [
                Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text('${userProvider.user.name[0].toUpperCase()}',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 8),
                Text('${userProvider.user.name}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600))
              ])),
              SizedBox(height: 40),
              buildInputField(type: 'email', controller: emailController),
              SizedBox(height: 20),
              buildInputField(type: 'name', controller: nameController),
              SizedBox(height: 20),
              buildInputField(type: 'phone', controller: phoneController),
              SizedBox(height: 40),
              buildLargeButton()
            ],
          ),
        ));
  }

  Widget buildInputField(
      {required String type, required TextEditingController controller}) {
    return Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: TextField(
          keyboardType:
              type == 'phone' ? TextInputType.number : TextInputType.text,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(type == 'email'
                  ? Icons.email
                  : type == 'name'
                      ? Icons.person
                      : Icons.call)),
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
