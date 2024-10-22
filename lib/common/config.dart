// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

// const String baseURL = "https://api.prathibha.in";
// const String baseURL = "http://localhost:8000";
const String baseURL = "https://unniku.pythonanywhere.com";

getToken() {
  final cookie = document.cookie!;
  final entity = cookie.split("; ").map((item) {
    final split = item.split("=");
    return MapEntry(split[0], split[1]);
  });
  final cookieMap = Map.fromEntries(entity);
  return cookieMap["token"];
}

deleteToken() {
  document.cookie = "token=";
}
