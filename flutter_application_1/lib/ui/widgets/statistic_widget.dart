import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widgets/statistic_model.dart';
import 'package:provider/provider.dart';

class StatisticWidget extends StatefulWidget {
  const StatisticWidget({super.key});

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StatisticViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Статистика'),
      ),
      body: Column(
        children: [
          _ChartWidget(viewModel: viewModel),
          _InfoChartWidget()
        ],
      ),
    );
  }
}

class _InfoChartWidget extends StatelessWidget {
  const _InfoChartWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        children: [
          Container(
            color: Colors.red,
            width: 25,
            height: 25,
          ),
          SizedBox(width: 10,),
          Text('Вес'),
          Expanded(child: SizedBox()),
          Container(
            color: Colors.blue,
            width: 25,
            height: 25,
          ),
          SizedBox(width: 10,),
          Text('Повторения')
        ],
      ),
    );
  }
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({
    required this.viewModel,
  });

  final StatisticViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 300,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              // 🔴 Первая линия (вес)
              LineChartBarData(
                spots: viewModel.weightSpots, // список FlSpot (ось X — индекс, Y — вес)
                isCurved: true,
                barWidth: 2,
                color: Colors.red,
                dotData: FlDotData(show: true),
              ),
    
              // 🔵 Вторая линия (повторения)
              LineChartBarData(
                spots: viewModel.countSpots, // другой список FlSpot (ось X — индекс, Y — количество)
                isCurved: true,
                barWidth: 2,
                color: Colors.blue,
                dotData: FlDotData(show: true),
              ),
            ],
            titlesData: FlTitlesData(show: true),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        )
      ),
    );
  }
}