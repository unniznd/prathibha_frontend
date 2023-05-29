import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/login/bloc/login_bloc.dart';
import 'package:prathibha_web/login/bloc/login_event.dart';
import 'package:prathibha_web/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          if (maxWidth >= 1000) {
            // Web view layout
            return Row(
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
                      child: buildForm(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile view layout
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/images/login_bg.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: buildForm(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                final fieldWidth = constraints.maxWidth > 400
                    ? 400
                    : constraints.maxWidth * 0.9;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: usernameController,
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
                    validator: (value) {
                      if (value!.length < 4) {
                        return "Username is too short";
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: fieldWidth * 0.05,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final fieldWidth = constraints.maxWidth > 400
                    ? 400
                    : constraints.maxWidth * 0.9;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
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
                    validator: (value) {
                      if (value!.length < 4) {
                        return "Password is too short";
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: fieldWidth * 0.05,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            LayoutBuilder(builder: (context, constraints) {
              final buttonWidth =
                  constraints.maxWidth > 400 ? 200 : constraints.maxWidth * 0.4;
              return BlocBuilder<LoginBloc, LoginState>(
                bloc: loginBloc,
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return SizedBox(
                      width: buttonWidth.toDouble(),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is LoginFailure) {
                    return Column(
                      children: [
                        SizedBox(
                          width: buttonWidth.toDouble(),
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginBloc.add(
                                  LoginButtonPressed(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                            child: const Text("Login"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          state.error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox(
                    width: buttonWidth.toDouble(),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginBloc.add(
                            LoginButtonPressed(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
