import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartCustom extends StatefulWidget {
  final double maxValue;
  final double cap;
  final List<Color> chartColor;
  final double chartWidth;
  final bool showChartArea;
  final List<FlSpot> chartValues;

  LineChartCustom({Key key,@required this.maxValue, @required this.chartValues, this.cap = 5, this.chartColor, this.chartWidth = 3, this.showChartArea = false,}) : super(key: key);

  @override
  _LineChartCustomState createState() => _LineChartCustomState();
}

class _LineChartCustomState extends State<LineChartCustom> {
  double maxTarget = 10;

  List<Color> gradientColors = [
    const Color(0xff02d39a),
  ];

  List<FlSpot> temps = [
    FlSpot(0, 0.5),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
    FlSpot(12, 8),
    FlSpot(13, 6.9),
    FlSpot(14, 9.88),
    FlSpot(15, 9),
    FlSpot(16, 7),
    FlSpot(18, 8),
    FlSpot(19, 1),
    FlSpot(25, 9.88),
    FlSpot(30, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Color(0xff232d37),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          // custom return widget or show middle target
          if(value == 5){
            return FlLine(
              color: Colors.white,
              strokeWidth: 2,
            );
          }

          if(value == 0 || value == maxTarget){
            return FlLine(
              color: Colors.white,
              strokeWidth: 2,
            );
          }
          return FlLine(
            color: Colors.white.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: widget.maxValue,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            if((value.toInt() % widget.cap) == 0)
              return value.toInt().toString();
            else
              return "";
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            if(value == 5){
              return "Expert State Target";
            }
            else
              return "";
          },
          reservedSize: widget.maxValue,
          margin: 0,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border(
          top: BorderSide(color: Colors.white,),
          bottom: BorderSide(color: Colors.white,)
      )),
      minX: 0,
      maxX: widget.maxValue,
      minY: 0,
      maxY: maxTarget,
      lineBarsData: [
        LineChartBarData(
          spots: widget.chartValues ?? temps,
          isCurved: true,
          colors: widget.chartColor ?? gradientColors,
          gradientFrom: Offset(0,1),
          gradientTo: Offset(0,-1),
          barWidth: widget.chartWidth,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: widget.showChartArea,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}