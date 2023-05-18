import 'package:flutter/material.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "FEES STRUCTURE",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search",
              filled: true,
              fillColor: Color.fromRGBO(234, 240, 247, 1),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        DataTable(
          columns: const [
            DataColumn(
              label: Text(
                'REG NO:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataColumn(
              label: Text(
                'NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'BRANCH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataColumn(
              label: Text(
                'STATUS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'DATE',
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
                const DataCell(Text(
                  'PAID',
                  style: TextStyle(color: Colors.greenAccent),
                )),
                const DataCell(Text('31 DEC 2023')),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text('2')),
                const DataCell(Text('Mathew')),
                const DataCell(Text('9 B')),
                const DataCell(Text(
                  'PAID',
                  style: TextStyle(color: Colors.greenAccent),
                )),
                const DataCell(Text('31 DEC 2023')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
