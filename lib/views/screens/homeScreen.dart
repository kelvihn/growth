import 'dart:async';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/historyModel.dart';
import 'package:growth/models/userModel.dart';
import 'package:growth/providers/user_provider.dart';
import 'package:growth/views/screens/accountBlocked.dart';
import 'package:growth/views/screens/accountSuspended.dart';
import 'package:growth/views/screens/historyPage.dart';
import 'package:growth/views/screens/internationalTransfer.dart';
import 'package:growth/views/screens/loans.dart';
import 'package:growth/views/screens/onboarding.dart';
import 'package:growth/views/screens/profile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService api = new ApiService();
  late Stream stream;
  StreamController<int> amountController = new StreamController<int>();
  late Future<List<HistoryModel>> historyModel;

  startBalanceTimer() {
    var oneSec = Duration(seconds: 3);
    Timer.periodic(oneSec, (Timer t) {
      getAccountBalance();
    });
  }

  void getAccountBalance() async {
    int accountBal = await api.fetchAccountBalance(id: widget.user.id);
    amountController.add(accountBal);
  }

  late Future<String> userStatus;

  @override
  void initState() {
    userStatus = api.getAccountstatus(id: widget.user.id);
    startBalanceTimer();
    historyModel = api.getHistory(id: widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: userStatus,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('-----------------------------------------------------');
            print(snapshot.data);
            if (snapshot.data == 'blocked') {
              return AccountBlocked();
            } else if (snapshot.data == 'suspended') {
              return AccountSuspended();
            } else {
              var userProvider = Provider.of<UserProvider>(context);
              userProvider.setUser(widget.user);
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.5,
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  title:
                      Text('Dashboard', style: TextStyle(color: Colors.black)),
                  centerTitle: true,
                ),
                drawer: Drawer(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                        ),
                        child: Center(
                            child: Column(children: [
                          Container(
                            height: 105,
                            width: 105,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Text(
                                  '${userProvider.user.name[0].toUpperCase()}',
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('${userProvider.user.name}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))
                        ])),
                      ),
                      ListTile(
                        title: const Text('Dashboard'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      ListTile(
                        title: const Text('International Transfers'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InternationalTransfer(user: widget.user),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Local Transfers'),
                        onTap: () {
                          showUnavailableDialog(context);
                        },
                      ),
                      ListTile(
                        title: const Text('Domestic Transfers'),
                        onTap: () {
                          showUnavailableDialog(context);
                        },
                      ),
                      ListTile(
                        title: const Text('Loans'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoanScreen(user: widget.user),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('History'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HistoryPage(id: widget.user.id),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('My Profile'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(user: widget.user),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: const Text('Logout'),
                        onTap: () {
                          api.logout().whenComplete(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Onboarding(),
                                ),
                                (route) => false);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor),
                            child: Center(
                                child: Text(
                                    '${userProvider.user.name[0].toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hi, ${userProvider.user.name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                              Text(
                                  '${userProvider.user.accountNumber.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 16))
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 17)),
                          StreamBuilder(
                              stream: amountController.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Countup(
                                    begin: 0,
                                    end: snapshot.data!.toDouble(),
                                    prefix: new String.fromCharCodes(
                                        new Runes('\u0024')),
                                    duration: Duration(seconds: 1),
                                    separator: ',',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 35,
                                        fontFamily: 'MontserratBold'),
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Text('An error occured');
                                }
                                return Text('Loading...');
                              })
                        ],
                      ),
                      SizedBox(height: 40),
                      Text('Transaction History',
                          style: TextStyle(fontSize: 17)),
                      SizedBox(height: 15),
                      FutureBuilder<List<HistoryModel>>(
                        future: historyModel,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length == 0) {
                              return Text('No history to display yet');
                            } else {
                              return Container(
                                  height: 400,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.separated(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        HistoryModel history =
                                            snapshot.data[index];

                                        return buildHistoryWidget(
                                            type: history.type,
                                            amount: history.amount,
                                            reason: history.reason,
                                            date: history.date);
                                      },
                                      separatorBuilder: (context, int index) {
                                        return Divider();
                                      }));
                            }
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Text('Could not retrieve history');
                          }

                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                )),
              );
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Image.asset(
                            'assets/images/404.png',
                            height: 250,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'An error occured. Please check your network and try again',
                            textAlign: TextAlign.center,
                          ),
                        ])),
                  ),
                ));
          }
          return Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        });
  }

  Widget buildHistoryWidget(
      {String? type, String? amount, String? reason, String? date}) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColor),
        child: Center(
            child: Text('T',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
      ),
      title: Text('$reason'),
      subtitle: Text('$date'),
      trailing: Text('\$$amount',
          style:
              TextStyle(color: type == 'credit' ? Colors.green : Colors.red)),
    );
  }

  Widget typeWidget(String type) {
    return Container(
      alignment: Alignment.center,
      height: 22,
      //width: 7,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: type == 'credit' ? Colors.green : Colors.red),
      child: Text(type, style: TextStyle(color: Colors.white, fontSize: 13)),
    );
  }

  showUnavailableDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Container(
          margin: EdgeInsets.only(left: 7),
          child: Text("This feature is not available for your account type")),
    );

    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

/*
Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 15,
            width: 15,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          ),
          Text('$reason'),
          typeWidget(type),
          Text('\$50000',
              style: TextStyle(
                  color: type == 'credit' ? Colors.green : Colors.red)),
          Text('$date')
        ],
      ),
    )
*/