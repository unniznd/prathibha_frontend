import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'dart:convert';
import 'package:prathibha_web/fee/model/fee_model.dart';

class FeeApiProvider {
  Future<FeeModel> fetchFeeDetails(int branchId) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/fee/$branchId/",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return FeeModel.withError("Error Occured");
    }

    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      return FeeModel.fromJson(responseData);
    }
    return FeeModel.withError("Error Occured");
  }
}
