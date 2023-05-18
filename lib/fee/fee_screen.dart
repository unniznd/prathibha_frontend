import 'package:flutter/material.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Fee Screen'),
    );
  }
}
