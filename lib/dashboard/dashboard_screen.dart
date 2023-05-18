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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.67,
              child: Column(
                children: [
                  _buildTableRow([
                    'Sl No',
                    'Branch/Class-Division',
                    'Percentage',
                    ' View Details'
                  ], isHeader: true),
                  const Divider(),
                  _buildTableRow(['1', 'Branch 1', '90%', 'View']),
                  const Divider(),
                  _buildTableRow(['2', 'Branch 2', '100%', 'View']),
                  const Divider(),
                  _buildTableRow(['3', 'Branch 3', '86%', 'View']),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _buildTableRow(List<String> rowData, {bool isHeader = false}) {
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
