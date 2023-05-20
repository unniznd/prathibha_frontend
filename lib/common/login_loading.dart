import 'package:flutter/material.dart';

class LoginLoadingScreen extends StatelessWidget {
  const LoginLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/loading.gif",
          width: 100,
        ),
      ),
    );
  }
}
