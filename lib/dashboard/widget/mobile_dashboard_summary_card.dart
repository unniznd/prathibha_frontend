import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class MobileDashboardSummaryCard extends StatelessWidget {
  MobileDashboardSummaryCard({
    super.key,
    required this.totalStudents,
    required this.totalPaid,
    required this.totalDue,
    this.isLoading = false,
  });

  final String totalStudents, totalPaid, totalDue;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(234, 240, 247, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Students",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
                        // width: ratioWidth / 12,
                        height: 30, // Adjust the height as needed
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      totalStudents,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(248, 239, 226, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Fee Paid",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
                        // width: ratioWidth / 12,
                        height: 30, // Adjust the height as needed
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      "\u20B9 $totalPaid",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(239, 247, 226, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Fee Unpaid",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: const Color.fromARGB(255, 248, 240, 240),
                      child: SizedBox(
                        // width: ratioWidth / 12,
                        height: 30, // Adjust the height as needed
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      "\u20B9 $totalDue",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
