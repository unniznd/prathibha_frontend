import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AttendanceTableRow extends StatelessWidget {
  AttendanceTableRow({
    super.key,
    required this.rowData,
    required this.onMarkAbsent,
    this.isHeader = false,
    this.isShimmer = false,
    this.isMarkingAttendace = false,
  });

  List rowData;
  bool isHeader = false;
  bool isShimmer = false;
  bool isMarkingAttendace = false;

  void Function()? onMarkAbsent;

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
                  child: isShimmer
                      ? _buildShimmerWidget()
                      : Tooltip(
                          message: isMarkingAttendace
                              ? 'Marking absent'
                              : 'Present. Click to mark as absent',
                          child: TextButton(
                            onPressed: isMarkingAttendace ? null : onMarkAbsent,
                            child: isMarkingAttendace
                                ? const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cellData,
                                      style: TextStyle(
                                        fontWeight: isHeader
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                ),
              );
            } else if (cellData == "Absent") {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: isShimmer
                      ? _buildShimmerWidget()
                      : Tooltip(
                          message: isMarkingAttendace
                              ? 'Marking present'
                              : 'Absent. Click to mark as present',
                          child: TextButton(
                            onPressed: isMarkingAttendace ? null : () {},
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: isMarkingAttendace
                                  ? const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                      ),
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
                  child: isShimmer
                      ? _buildShimmerWidget()
                      : Text(
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
              child: isShimmer
                  ? _buildShimmerWidget()
                  : Align(alignment: Alignment.centerLeft, child: cellData),
            );
          }
        }).toList(),
      ),
    );
  }

  Widget _buildShimmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        width: double.infinity,
        height: 16.0, // Adjust the height as needed
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
