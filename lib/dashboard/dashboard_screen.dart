import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

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
    List barChartModelData = [
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hello Maietry \u{1F44B}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(234, 240, 247, 1),
                      ), // Customize the border color and other properties
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: const Color.fromRGBO(234, 240, 247,
                          1) // Customize the border radius if needed
                      ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue;
                        });
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        'All Branches',
                        'Branch 1',
                        'Branch 2',
                        'Branch 3'
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
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 200,
                  height: 100,
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
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Students",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
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
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Expenses",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "3000000",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
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
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Due",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
            Container(
              width: double.infinity,
              height: 300,
              padding: const EdgeInsets.all(20.0),
              child: AspectRatio(
                aspectRatio: 1.4,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    borderData: FlBorderData(
                      show: true,
                      border: const Border.symmetric(
                        horizontal: BorderSide(
                          color: Color(0xFFececec),
                        ),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        drawBehindEverything: true,
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              formatNumber(value.toInt()),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.left,
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(),
                      topTitles: AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              barChartModelData[value.toInt()].monthName,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.left,
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xFFececec),
                        strokeWidth: 0,
                      ),
                    ),
                    barGroups: List<BarChartGroupData>.generate(
                      barChartModelData.length,
                      (index) => BarChartGroupData(
                        x: index,
                        barsSpace: 1,
                        barRods: [
                          BarChartRodData(
                            toY: barChartModelData[index].income.toDouble(),
                            color: const Color.fromARGB(255, 62, 62, 179),
                            width: 15,
                            borderRadius: const BorderRadius.all(Radius.zero),
                          ),
                          BarChartRodData(
                            toY: barChartModelData[index].expense.toDouble(),
                            color: const Color.fromRGBO(22, 22, 63, 1),
                            width: 15,
                            borderRadius: const BorderRadius.all(Radius.zero),
                          ),
                        ],
                      ),
                    ),
                    barTouchData: BarTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex =
                              barTouchResponse.spot!.touchedBarGroupIndex;
                        });
                      },
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.toY.toString(),
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: rod.color,
                              fontSize: 30,
                              shadows: const [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
