import 'package:flutter/material.dart';

class ShowEvents extends StatelessWidget {
  const ShowEvents({super.key, required this.eventName});

  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 247, 249, 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          eventName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
