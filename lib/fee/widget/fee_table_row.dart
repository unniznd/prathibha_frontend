import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class FeeTableRow extends StatelessWidget {
  FeeTableRow({
    super.key,
    required this.rowData,
    required this.amount,
    required this.markAsPaid,
    this.isHeader = false,
    this.isShimmer = false,
    this.isMarkingFee = false,
  });

  List rowData;
  bool isHeader = false;
  bool isShimmer = false;
  int amount;
  bool isMarkingFee = false;

  void Function()? markAsPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: rowData.map((cellData) {
          if (isShimmer) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          if (cellData.runtimeType == String) {
            if (cellData == "Paid") {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    cellData,
                    style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            } else if (cellData == "Unpaid") {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Tooltip(
                    message: isMarkingFee
                        ? "Marking paid for Amount: \u20B9 $amount"
                        : "Amount: \u20B9 $amount. Click to confirm payment",
                    child: TextButton(
                      onPressed: isMarkingFee ? null : markAsPaid,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: isMarkingFee
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : Text(
                                cellData,
                                style: TextStyle(
                                  fontWeight: isHeader
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: Colors.red,
                                ),
                              ),
                      ),
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
