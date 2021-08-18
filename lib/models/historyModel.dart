class HistoryModel {
  String? id;
  String? type;
  String? reason;
  String? amount;
  String? date;

  HistoryModel();

  HistoryModel.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['name'].toString();
    type = jsonMap['type'];
    reason = jsonMap['reason'];
    amount = jsonMap['amount'];
    date = jsonMap['date'];
  }
}
