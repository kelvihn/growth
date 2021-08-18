import 'package:flutter/material.dart';
import 'package:growth/controllers/apiService.dart';
import 'package:growth/models/historyModel.dart';

class HistoryPage extends StatefulWidget {
  final String id;
  const HistoryPage({Key? key, required this.id}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ApiService api = new ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('My History', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<HistoryModel>>(
                future: api.getHistory(id: widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Text('No history to display yet');
                    } else {
                      return Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                HistoryModel history = snapshot.data[index];

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
        ));
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
}
