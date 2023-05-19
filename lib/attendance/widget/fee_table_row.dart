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
            if (cellData == "Present") {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Tooltip(
                    child: Text(
                      cellData,
                      style: TextStyle(
                        fontWeight:
                            isHeader ? FontWeight.bold : FontWeight.normal,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              );
            } else if (cellData == "Absent") {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Tooltip(
                    child: GestureDetector(
                      child: Text(
                        cellData,
                        style: TextStyle(
                          fontWeight:
                              isHeader ? FontWeight.bold : FontWeight.normal,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Fee Payment Confirmation"),
                              content: const Text(
                                  "Are you sure you want to confirm fee payment of  \u20B9 2000?"),
                              actions: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 136, 67),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Set border radius
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text("Cancel"),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, right: 10),
                                  child: ElevatedButton(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text("Confirm"),
                                    ),
                                    onPressed: () {
                                      // Perform logout actions here
                                      Navigator.of(context)
                                          .pop(); // Close the dialog

                                      // Add your logout logic here
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    cellData,
                    style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black,
                    ),
                  )),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(alignment: Alignment.centerLeft, child: cellData),
            );
          }
        }).toList(),
      ),
    );
  }
}
