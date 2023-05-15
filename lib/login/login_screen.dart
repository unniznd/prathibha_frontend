import 'package:flutter/material.dart';
import 'package:prathibha_web/switcher/switcher_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 10),
      //     child: SizedBox(
      //       width: 60,
      //       height: 60,
      //       child: Image.asset(
      //         "assets/images/logo.png",
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //   ),
      // ),
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/images/login_bg.png"),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 150,
                  left: 150,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Username",
                          filled: true,
                          fillColor: Color.fromRGBO(234, 240, 247, 1),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Color.fromRGBO(234, 240, 247, 1),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SwitcherScreen(),
                            ),
                          );
                        },
                        child: const Text("Login"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
