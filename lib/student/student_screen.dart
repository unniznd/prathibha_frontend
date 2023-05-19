import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../attendance/widget/fee_table_row.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
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
              "Students",
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
              hintText: "Search by Reg No. and Name",
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
              height: 20,
              width: 10,
            ),
          ],
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
                    rowData: const [
                      'Reg No',
                      'Student Name',
                      'Contact',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: const [
                      '01',
                      'Akhil',
                      '987654321',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: const [
                      '02',
                      'Akhil',
                      '987654321',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: const [
                      '03',
                      'Akhil',
                      '987654321',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: const [
                      '04',
                      'Akhil',
                      '987654321',
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
