import 'package:flutter/material.dart';
import 'package:prathibha_web/settings/widget/generate_fee.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key, required this.branchId});

  int branchId;

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
          "Manage Fees",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    generateFee(
                      context: context,
                      branchId: widget.branchId,
                    );
                  },
                  child: const Text("Generate Fee")),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Send Fee Notification")),
            ],
          ),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Add Class")),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Add Division")),
            ],
          ),
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
