import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../fee/widget/fee_table_row.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? selectedClass = 'Class';
  String? selectedDivision = 'Division';
  String? selectedMonth = 'Month';

  bool isAbsentChecked = false;
  bool isPresentChecked = false;

  void handleAbsentCheck(bool? value) {
    setState(() {
      isAbsentChecked = value!;
      if (value) {
        isPresentChecked = false;
      }
    });
  }

  void handlePresentCheck(bool? value) {
    setState(() {
      isPresentChecked = value!;
      if (value) {
        isAbsentChecked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Attendance Details",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              message: 'Reload the table',
              child: HeroIcon(
                HeroIcons.arrowPath,
                size: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search by Student Name, Class, Section, Roll No.",
              filled: true,
              fillColor: Color.fromRGBO(234, 240, 247, 1),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isAbsentChecked,
                onChanged: handleAbsentCheck,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color.fromRGBO(68, 97, 242, 1),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Absent",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isPresentChecked,
                onChanged: handlePresentCheck,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color.fromRGBO(68, 97, 242, 1),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Present",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedClass,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: HeroIcon(HeroIcons.chevronDown),
                  ),
                  items: <String>[
                    'Class',
                    '10',
                    '9',
                    '8',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDivision,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDivision = newValue;
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: HeroIcon(HeroIcons.chevronDown),
                  ),
                  items: <String>[
                    'Division',
                    'A',
                    'B',
                    'C',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          width: 10,
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.9,
              child: Column(
                children: [
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Student Name',
                      'Status',
                      'Reason',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {},
                          child: const Text('Present'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Reason",
                            filled: false,
                            fillColor: Color.fromRGBO(234, 240, 247, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {},
                          child: const Text('Present'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Reason",
                            filled: false,
                            fillColor: Color.fromRGBO(234, 240, 247, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {},
                          child: const Text('Present'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Reason",
                            filled: false,
                            fillColor: Color.fromRGBO(234, 240, 247, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {},
                          child: const Text('Present'),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Reason",
                            filled: false,
                            fillColor: Color.fromRGBO(234, 240, 247, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
