import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/login/bloc/login_bloc.dart';
import 'package:prathibha_web/login/bloc/login_event.dart';
import 'package:prathibha_web/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Form(
                  key: formKey,
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<LoginBloc, LoginState>(
                        bloc: loginBloc,
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return SizedBox(
                              width: 200,
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
                                  width: 200,
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
                            width: 200,
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
