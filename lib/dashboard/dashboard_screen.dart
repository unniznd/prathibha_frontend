import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:prathibha_web/dashboard/widget/dashboard_summary_card.dart';
import 'package:prathibha_web/dashboard/widget/income_expense_graph.dart';

import 'model/bar_char_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedOption = 'All Branches';

  String formatNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<BarChartModel> barChartModelData = [
      BarChartModel(
        monthName: "Jan",
        income: 100000,
        expense: 50000,
      ),
      BarChartModel(
        monthName: "Feb",
        income: 200000,
        expense: 100000,
      ),
      BarChartModel(
        monthName: "Mar",
        income: 300000,
        expense: 150000,
      ),
      BarChartModel(
        monthName: "Apr",
        income: 400000,
        expense: 200000,
      ),
      BarChartModel(
        monthName: "May",
        income: 500000,
        expense: 250000,
      ),
      BarChartModel(
        monthName: "Jun",
        income: 600000,
        expense: 300000,
      ),
      BarChartModel(
        monthName: "Jul",
        income: 700000,
        expense: 350000,
      ),
      BarChartModel(
        monthName: "Aug",
        income: 800000,
        expense: 400000,
      ),
      BarChartModel(
        monthName: "Sep",
        income: 900000,
        expense: 450000,
      ),
      BarChartModel(
        monthName: "Oct",
        income: 1000000,
        expense: 500000,
      ),
      BarChartModel(
        monthName: "Nov",
        income: 1100000,
        expense: 550000,
      ),
      BarChartModel(
        monthName: "Dec",
        income: 1200000,
        expense: 600000,
      ),
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    double ratioHeight = 900 / MediaQuery.of(context).size.height;

    return Column(
      children: [
        DashboardSummaryCard(
          totalStudents: "100",
          totalExpenses: "345678",
          totalDue: "23000",
          ratioWidth: screenWidth,
          ratioHeight: ratioHeight,
        ),
        const SizedBox(height: 30),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Income vs Expense",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30),
        IncomeExpenseGraph(
          barChartModelData: barChartModelData,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Today's Attendance Overview",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Sl No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Branch',
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
                      'Percentage',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
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
                      const DataCell(Text('Branch 1')),
                      const DataCell(Text('10 A')),
                      const DataCell(Text('90%')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 37, 6, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Set border radius
                            ),
                          ),
                          child: const Text(
                            "View",
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
                      const DataCell(Text('Branch 2')),
                      const DataCell(Text('9 B')),
                      const DataCell(Text('87%')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 37, 6, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Set border radius
                            ),
                          ),
                          child: const Text(
                            "View",
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
                      const DataCell(Text('3')),
                      const DataCell(Text('Branch 3')),
                      const DataCell(Text('10 D')),
                      const DataCell(Text('84%')),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 37, 6, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Set border radius
                            ),
                          ),
                          child: const Text(
                            "View",
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
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
