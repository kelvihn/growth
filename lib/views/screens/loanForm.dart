import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/pendingLoan.dart';

class LoanForm extends StatefulWidget {
  final UserModel user;
  const LoanForm({Key? key, required this.user}) : super(key: key);

  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  ApiService api = new ApiService();
  File? _collateralDocument;
  TextEditingController amountController = new TextEditingController();
  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _collateralDocument = File(result.files.single.path!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File uploaded"),
        ),
      );
    } else {
      print('user did not select a file');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File uploaded cancelled"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Loan Form', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Fill the loan application form below',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              SizedBox(height: 30),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Loan amount'),
                SizedBox(height: 8),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(height: 18),
                Text('Reason for loan'),
                SizedBox(height: 8),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(height: 18),
                Text('Employment status'),
                SizedBox(height: 8),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(height: 18),
                Text('Employer name'),
                SizedBox(height: 8),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(height: 18),
                Text('Monthly income'),
                SizedBox(height: 8),
                Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                    )),
                SizedBox(height: 18),
                Text(
                    'Select a document to be used as collateral e.g House ownership, Business ownership e.t.c'),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    selectFile();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: _collateralDocument == null
                          ? Container(
                              height: 50,
                              width: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text('Select file',
                                      style: TextStyle(color: Colors.white))),
                            )
                          : Image.asset('assets/images/file.png')),
                ),
                SizedBox(height: 20),
                buildLargeButton(),
                SizedBox(height: 20),
              ])
            ],
          ),
        )));
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

  Widget buildLargeButton() {
    return GestureDetector(
        onTap: () async {
          if (amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please fill all the details"),
              ),
            );
          } else {
            showLoaderDialog(context);
            await api
                .requestLoan(
                    file: _collateralDocument,
                    name: widget.user.name,
                    amount: amountController.text)
                .then((value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PendingLoan(user: widget.user)),
              );
            });
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
