import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prathibha_web/dashboard/model/bar_char_model.dart';
import 'package:intl/intl.dart';

class IncomeExpenseGraph extends StatelessWidget {
  const IncomeExpenseGraph({
    super.key,
    required this.barChartModelData,
  });

  final List<BarChartModel> barChartModelData;

  String formatNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
