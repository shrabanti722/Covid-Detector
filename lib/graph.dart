import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<_SalesData> data = [
    _SalesData('30', 54),
    _SalesData('60', 85),
    _SalesData('90', 92),
    _SalesData('120', 94),
    _SalesData('150', 91),
    _SalesData('180', 89),
  ];
  @override
  Widget build(BuildContext context) {
    return
        //Initialize the chart widget
        SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                  text: 'Epochs',
                  textStyle: TextStyle(
                      // color: Colors.black,
                      // fontFamily: 'Roboto',
                      fontSize: 12,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400)),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                  text: 'Accuracy',
                  textStyle: TextStyle(
                      // color: Colors.black,
                      // fontFamily: 'Roboto',
                      fontSize: 12,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400)),
            ),
            // Chart title
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<_SalesData, String>>[
          SplineSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Sales',
              // Enable data label
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                showZeroValue: false,
                offset: Offset(0, 1),
              ))
        ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
