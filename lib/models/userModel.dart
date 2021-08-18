class UserModel {
  late String id;
  late String name;
  late String email;
  late String phone;
  late String imageUrl;
  late String accountNumber;
  int? accountBalance;
  late String withdrawalFee;
  late String billingAmount;
  late String createdAt;

  bool? auth;

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
    email = jsonMap['email'];
    phone = jsonMap['phone'];
    accountBalance = int.parse(jsonMap['account_balance']);
    accountNumber = jsonMap['account_number'];
    withdrawalFee = jsonMap['withdrawal_fee'];
    billingAmount = jsonMap['billing_amount'];
    createdAt = jsonMap['created_at'];
    imageUrl = jsonMap['picture'];
  }
}
