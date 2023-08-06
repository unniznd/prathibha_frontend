import 'package:http/http.dart' as http;
import 'package:prathibha_web/common/config.dart';
import 'dart:html';

class ReportApiProvider {
  Future<bool> getAttendanceReport(
    int branchId,
    String fromDate,
    String toDate,
    String view,
  ) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/attendance-report/$branchId/?from=$fromDate&to=$toDate&view=$view",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }
    final csvData = res.bodyBytes;

    // Create a Blob from the Uint8List
    final blob = Blob([csvData]);

    // Create an anchor element
    final anchor = AnchorElement(href: Url.createObjectUrlFromBlob(blob))
      ..target = 'blank'
      ..download = 'Attendance Report $fromDate - $toDate.csv';
    // Trigger a click event on the anchor element to start the download
    anchor.click();

    // Clean up the Blob and Object URLs to avoid memory leaks
    anchor.remove();
    Url.revokeObjectUrl(anchor.href!);
    return true;
  }

  Future<bool> getFeeReport(
    int branchId,
    String fromDate,
    String toDate,
    String view,
  ) async {
    dynamic res;
    try {
      res = await http.get(
          Uri.parse(
            "$baseURL/fee-report/$branchId/?from=$fromDate&to=$toDate&view=$view",
          ),
          headers: {
            'Authorization': 'Token ${getToken()}'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return false;
    }
    final csvData = res.bodyBytes;

    // Create a Blob from the Uint8List
    final blob = Blob([csvData]);

    // Create an anchor element
    final anchor = AnchorElement(href: Url.createObjectUrlFromBlob(blob))
      ..target = 'blank'
      ..download = 'Fee Report $fromDate - $toDate.csv';
    // Trigger a click event on the anchor element to start the download
    anchor.click();

    // Clean up the Blob and Object URLs to avoid memory leaks
    anchor.remove();
    Url.revokeObjectUrl(anchor.href!);
    return true;
  }
}
