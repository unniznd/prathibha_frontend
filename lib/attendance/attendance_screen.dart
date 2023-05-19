import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

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
        DataTable(
          columns: const [
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
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(Text('1')),
                const DataCell(Text('John')),
                const DataCell(Text('10 A')),
                DataCell(
                  ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
          ],
        ),
      ],
    );
  }
}
