import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Settings",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Manage Attendance",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        ElevatedButton(
            onPressed: () {},
            child: const Text("Send Attendance Notification")),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Manage Fees",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Generate Fee")),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("Send Fee Notification")),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Manage Classes, Divisions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Add Class")),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Add Division")),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Manage Branches",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        ElevatedButton(onPressed: () {}, child: const Text("Add Branch")),
      ],
    );
  }
}
