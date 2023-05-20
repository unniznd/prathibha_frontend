import 'package:flutter/material.dart';

class StudentTableRow extends StatelessWidget {
  StudentTableRow({
    super.key,
    required this.rowData,
    this.isHeader = false,
  });

  List<String> rowData;
  bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: rowData.map((cellData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: cellData != "View"
                  ? Text(
                      cellData,
                      style: TextStyle(
                        fontWeight:
                            isHeader ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(cellData),
                      ),
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
