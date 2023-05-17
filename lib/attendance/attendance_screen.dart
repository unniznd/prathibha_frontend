import 'dart:ffi';

import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: DataTable(columns: const [
      DataColumn(
        label: Text(
          'Roll No',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataColumn(
        label: Text(
          'Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'Class & Division',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataColumn(
        label: Text(
          'Attendance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ], rows: [
      DataRow(
        cells: [
          const DataCell(Text('1')),
          const DataCell(Text('John')),
          const DataCell(Text('10 A')),
          DataCell(
            ElevatedButton(
              onPressed: () {
                print("Absent");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 6, 217),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Set border radius
                ),
              ),
              child: const Text(
                "Absent",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Text('2')),
          const DataCell(Text('Mathew')),
          const DataCell(Text('9 B')),
          DataCell(
            ElevatedButton(
              onPressed: () {
                print("Absent");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 37, 6, 217),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Set border radius
                ),
              ),
              child: const Text(
                "Absent",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    ]));
  }
}
