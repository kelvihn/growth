import 'package:flutter/material.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/views/screens/cgtVerification.dart';

class InternationalTransfer extends StatefulWidget {
  final UserModel user;
  const InternationalTransfer({Key? key, required this.user}) : super(key: key);

  @override
  _InternationalTransferState createState() => _InternationalTransferState();
}

class _InternationalTransferState extends State<InternationalTransfer> {
  String _currentSelectedValue = "Savings account";

  var _currencies = ["Savings account", "Current account", "Checking account"];
  TextEditingController amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('International Transfer',
              style: TextStyle(color: Colors.black)),
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
                      child: Text('Make International Transfers',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                    SizedBox(height: 30),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Receiver\'s full name'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('Receiver\'s account number'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('Receiver\'s account type'),
                          SizedBox(height: 8),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16.0),
                                    hintText: 'Please select account type',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                isEmpty: _currentSelectedValue == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'MontserratRegular'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _currentSelectedValue = newValue!;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _currencies.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 18),
                          Text('Receiver\'s bank name'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('Receiver\'s bank address'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('Receiver\'s bank country'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('IBAN/Routing number'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('Amount to transfer'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          Text('Reason for transfer'),
                          SizedBox(height: 8),
                          Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 18),
                          Text('4 digit transaction pin'),
                          SizedBox(height: 8),
                          Container(
                              height: 48,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              )),
                          SizedBox(height: 20),
                          buildLargeButton(),
                          SizedBox(height: 20),
                        ])
                  ],
                ))));
  }

  Widget buildLargeButton() {
    return GestureDetector(
        onTap: () {
          if (amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please fill all details"),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CgtVerification(user: widget.user),
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
