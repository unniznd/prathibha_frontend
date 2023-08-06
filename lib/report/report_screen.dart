import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'api/report_api.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    super.key,
    required this.branchId,
  });

  final int branchId;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedType;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  ReportApiProvider reportApiProvider = ReportApiProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reports",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              message: 'Old Reports',
              child: HeroIcon(
                HeroIcons.clock,
                size: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                fromDateController.text =
                    DateFormat('MMMM d, y').format(pickedDate);
              }
            },
            child: TextFormField(
              enabled: false,
              controller: fromDateController,
              decoration: const InputDecoration(
                hintText: "From Date",
                filled: true,
                fillColor: Color.fromRGBO(234, 240, 247, 1),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: HeroIcon(HeroIcons.calendar),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                toDateController.text =
                    DateFormat('MMMM d, y').format(pickedDate);
              }
            },
            child: TextFormField(
              enabled: false,
              controller: toDateController,
              decoration: const InputDecoration(
                hintText: "To Date",
                filled: true,
                fillColor: Color.fromRGBO(234, 240, 247, 1),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: HeroIcon(HeroIcons.calendar),
                ),
              ),
            ),
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
              ), // Customize the border color and other properties
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: const Color.fromRGBO(
                  234, 240, 247, 1) // Customize the border radius if needed
              ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              hint: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Report Type"),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: HeroIcon(HeroIcons.chevronDown),
              ),
              items: <String>[
                'Attendance',
                'Fee',
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
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   width: 150,
              //   height: 50,
              //   child: ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: const HeroIcon(HeroIcons.eye),
              //     label: const Text("View Data"),
              //   ),
              // ),
              // const SizedBox(
              //   width: 20,
              // ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (fromDateController.text.isNotEmpty &&
                        toDateController.text.isNotEmpty) {
                      if (selectedType == "Attendance") {
                        reportApiProvider.getAttendanceReport(
                            widget.branchId,
                            fromDateController.text,
                            toDateController.text,
                            "csv");
                      }
                      if (selectedType == "Fee") {
                        reportApiProvider.getFeeReport(
                          widget.branchId,
                          fromDateController.text,
                          toDateController.text,
                          "csv",
                        );
                      }
                    }
                  },
                  icon: const HeroIcon(HeroIcons.documentText),
                  label: const Text("Download CSV"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              // SizedBox(
              //   width: 170,
              //   height: 50,
              //   child: ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: const HeroIcon(HeroIcons.document),
              //     label: const Text("Generate PDF"),
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              setState(() {
                selectedType = null;
              });
            },
            child: const Text("Clear Filters"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 50,
        ),
        // no report to view
        const HeroIcon(
          HeroIcons.documentText,
          size: 100,
          color: Color.fromRGBO(233, 233, 233, 1),
        ),
        const Center(
          child: Text(
            " No report to view",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(194, 194, 194, 1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
