import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FeeTableRow extends StatelessWidget {
  FeeTableRow({
    super.key,
    required this.rowData,
    this.isHeader = false,
  });

  List rowData;
  bool isHeader = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: rowData.map((cellData) {
          if (cellData.runtimeType == String) {
            return Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    cellData,
                    style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: cellData == "Paid"
                          ? Colors.green
                          : cellData == "Unpaid"
                              ? Colors.red
                              : Colors.black,
                    ),
                  )),
            );
          } else {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(alignment: Alignment.centerLeft, child: cellData),
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
