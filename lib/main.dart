import 'package:flutter/material.dart';
import 'package:prathibha_web/switcher/switcher_screen.dart';
import 'package:prathibha_web/login/login_screen.dart';

void main(List<String> args) {
  runApp(const PrathibhaWebApplication());
}

class PrathibhaWebApplication extends StatefulWidget {
  const PrathibhaWebApplication({super.key});

  @override
  State<PrathibhaWebApplication> createState() =>
      _PrathibhaWebApplicationState();
}

class _PrathibhaWebApplicationState extends State<PrathibhaWebApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Prathibha",
      initialRoute: '/',
      routes: {
        "/login": (context) => const LoginScreen(),
        "/": (context) => const SwitcherScreen(),
      },
      theme: ThemeData(
        fontFamily: "Poppins",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromRGBO(68, 97, 242, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromRGBO(68, 97, 242, 1),
        ),
      ),
    );
  }
}
