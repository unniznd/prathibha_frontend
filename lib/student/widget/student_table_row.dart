import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class StudentTableRow extends StatelessWidget {
  StudentTableRow({
    Key? key,
    required this.rowData,
    required this.onClickView,
    this.isHeader = false,
    this.isShimmer = false,
  }) : super(key: key);

  final List<String> rowData;
  final bool isHeader;
  final bool isShimmer;
  void Function()? onClickView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: rowData.map((cellData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: isShimmer
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
                        width: double.infinity,
                        height: 16.0, // Adjust the height as needed
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : (cellData != "View"
                      ? Text(
                          cellData,
                          style: TextStyle(
                            fontWeight:
                                isHeader ? FontWeight.bold : FontWeight.normal,
                          ),
                        )
                      : TextButton(
                          onPressed: onClickView,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(cellData),
                          ),
                        )),
            ),
          );
        }).toList(),
      ),
    );
  }
}
