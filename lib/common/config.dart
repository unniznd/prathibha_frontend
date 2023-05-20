// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

const String baseURL = "https://prathibhabackendtest-production.up.railway.app";

getToken() {
  final cookie = document.cookie!;
  final entity = cookie.split("; ").map((item) {
    final split = item.split("=");
    return MapEntry(split[0], split[1]);
  });
  final cookieMap = Map.fromEntries(entity);
  return cookieMap["token"];
}
