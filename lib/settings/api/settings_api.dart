import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';

class SettingsApiProvider {
  Map<String, dynamic> convertToMap(Map<dynamic, dynamic> input) {
    Map<String, dynamic> output = {};
    input.forEach((key, value) {
      output[key.toString()] = value;
    });
    return output;
  }

  Future<bool> generateFee(
    int branchId,
    Map standardFee,
    String installment,
  ) async {
    dynamic res;
    try {
      Map<String, dynamic> convertedStandardFee = convertToMap(standardFee);
      res = await http.post(
        Uri.parse("$baseURL/fee/$branchId/generate/"),
        headers: {
          'Authorization': 'Token ${getToken()}',
        },
        body: {
          "standard_fee": json.encode(convertedStandardFee),
          "installment": installment,
        },
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
