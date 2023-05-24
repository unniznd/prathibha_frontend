import 'package:flutter/material.dart';

void studentView(
  BuildContext context,
  var nameController,
  var standardController,
  var admissionNoController,
  var parentsNameController,
  var parentsPhoneNoController,
) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Student Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name:",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            child: TextField(
              controller: standardController,
              decoration: const InputDecoration(
                hintText: "Standard:",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            child: TextField(
              controller: admissionNoController,
              decoration: const InputDecoration(
                hintText: "Admission No:",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            child: TextField(
              controller: parentsNameController,
              decoration: const InputDecoration(
                hintText: "Parents name:",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            child: TextField(
              controller: parentsPhoneNoController,
              decoration: const InputDecoration(
                hintText: "Parents phone No:",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FilledButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Close')),
      ],
    ),
  );
}
