import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'package:prathibha_web/login/model/login_model.dart';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class LoginApiProvider {
  Future<LoginModel> authenticate(String username, String password) async {
    dynamic res;
    try {
      res = await http.post(
          Uri.parse(
            "$baseURL/login/",
          ),
          body: {
            "username": username,
            "password": password,
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return LoginModel.withError("Authentication Failed");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      document.cookie = "token=${responseData["token"]}";
      responseData["token"] = null;
      return LoginModel.fromJson(responseData);
    }

    return LoginModel.withError("Authentication Failed");
  }

  Future<LoginModel> dashboard(String token) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/dashboard/",
          ),
          headers: {
            'Authorization': 'Token $token'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return LoginModel.fromJson(responseData);
    }
    throw Exception("Error Occured");
  }
}
