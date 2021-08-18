import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/authorizationCode.dart';

class CgtVerification extends StatefulWidget {
  final UserModel user;
  const CgtVerification({Key? key, required this.user}) : super(key: key);

  @override
  _CgtVerificationState createState() => _CgtVerificationState();
}

class _CgtVerificationState extends State<CgtVerification> {
  ApiService api = new ApiService();
  TextEditingController cgtController = new TextEditingController();

  @override
  void initState() {
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
          title:
              Text('CGT Verification', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<String>(
                    future: api.getCgtCode(id: widget.user.id),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('CGT Verification',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    SizedBox(height: 5),
                                    Text(
                                        'Contact our live chat via web to get your CGT Code',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ],
                                )),
                            SizedBox(height: 30),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Enter CGT Code below'),
                                  SizedBox(height: 8),
                                  Container(
                                      height: 48,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextField(
                                        controller: cgtController,
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      )),
                                ]),
                            SizedBox(height: 20),
                            buildLargeButton(snapshot.data),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text('An error occured');
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }))));
  }

  Widget buildLargeButton(String? cgtCode) {
    return GestureDetector(
        onTap: () {
          if (cgtController.text != cgtCode) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Incorrect CGT Code"),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthorizationCode(user: widget.user),
              ),
            );
          }
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text('Submit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400))),
        ));
  }
}
