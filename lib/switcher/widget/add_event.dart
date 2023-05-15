import 'package:flutter/material.dart';

void addEvent(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: 250,
            width: 500,
            child: Column(
              children: [
                // add events
                const Text(
                  "Add Event",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Event Name",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Event Date",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Add Event"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
