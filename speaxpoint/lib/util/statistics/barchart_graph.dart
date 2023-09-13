import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';

class _BarChart extends StatelessWidget {
  const _BarChart(this.longPasues, this.repeatedWords, this.outOfContext,
      this.filledPasues, this.maxNumber);
  final int longPasues;
  final int repeatedWords;
  final int outOfContext;
  final int filledPasues;
  final int maxNumber;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxNumber.toDouble(),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Color(AppMainColors.ongoingSessionCardIcon),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
      color: Color(AppMainColors.backgroundAndContent),
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Long\nPause';
        break;
      case 1:
        text = 'Repeated\nWords';
        break;
      case 2:
        text = 'Out Of \nContext';
        break;
      case 3:
        text = 'Filled\nPauses';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, textAlign: TextAlign.center, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [Color(AppMainColors.p90), Color(AppMainColors.p10)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: longPasues.toDouble(),
              width: 18,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: repeatedWords.toDouble(),
              width: 18,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: outOfContext.toDouble(),
              width: 18,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: filledPasues.toDouble(),
              width: 18,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartGraph extends StatefulWidget {
  const BarChartGraph({
    super.key,
    required this.longPasues,
    required this.repeatedWords,
    required this.outOfContext,
    required this.filledPasues,
    required this.maxNumber,
  });
  final int longPasues;
  final int repeatedWords;
  final int outOfContext;
  final int filledPasues;
  final int maxNumber;

  @override
  State<StatefulWidget> createState() => BarChartGraphState();
}

class BarChartGraphState extends State<BarChartGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(AppMainColors.p100),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: _BarChart(
          widget.longPasues,
          widget.repeatedWords,
          widget.outOfContext,
          widget.filledPasues,
          widget.maxNumber,
        ),
      ),
    );
  }
}
