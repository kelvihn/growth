import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:growth/models/historyModel.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';

class ApiService extends ControllerMVC {
  Future<String> getAccountstatus({required id}) async {
    final Uri url =
        Uri.parse('https://growthchartered.com/api/getAccountStatus');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    return json.decode(response.body)['data'];
  }

  Future<dynamic> login(
      {required String email, required String password}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/login');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'email': email, 'password': password}));
    setCurrentUser(response.body);
    return json.decode(response.body);
  }

  Future<dynamic> updateProfile(
      {required String email,
      required String id,
      required String phone,
      required String name}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/updateProfile');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode(
            {'id': id, 'email': email, 'phone_number': phone, 'name': name}));
    setCurrentUser(response.body);
    return json.decode(response.body);
  }

  Future<void> blockAccount({required String id}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/blockAccount');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    print(response.body);
  }

  Future<String> getCgtCode({required String id}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/getCgtCode');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    return json.decode(response.body)['data'];
  }

  Future<String> getAuthCode({required String id}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/getAuthCode');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    return json.decode(response.body)['data'];
  }

  Future<int> fetchAccountBalance({required id}) async {
    final Uri url =
        Uri.parse('https://growthchartered.com/api/getAccountBalance');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    return int.parse(json.decode(response.body)['data']);
  }

  Future<List<HistoryModel>> getHistory({required String id}) async {
    print(
        '=========================================================================');
    final Uri url = Uri.parse('https://growthchartered.com/api/getHistory');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'id': id}));
    List<HistoryModel> history = List.from(json.decode(response.body)['data'])
        .map((element) => HistoryModel.fromJSON(element))
        .toList();
    return history;
  }

  void setCurrentUser(jsonString) async {
    print('save to pref');
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_user', json.encode(json.decode(jsonString)));
      print('save done');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

  Future<String> requestLoan(
      {required String name, required String amount, File? file}) async {
    final String url = 'https://growthchartered.com/api/requestLoan';
    try {
      String fileName = file!.path.split('/').last;
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        'name': name,
        'amount': amount
      });

      Dio dio = new Dio();

      await dio.post(url, data: data).then((response) {
        print(response);
        return response.toString();
      });
    } catch (e) {
      print(e);
      return e.toString();
    }
    return 'done';
  }
/*
  Future<void> getUserById({required String email}) async {
    final Uri url = Uri.parse('https://growthchartered.com/api/getUserById');
    final client = new http.Client();
    final response = await client.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: json.encode({'email': email}));
    print(response.body);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['success'] = true) {}
    } else {
      print(response.body);
    }
  }
  */
}
