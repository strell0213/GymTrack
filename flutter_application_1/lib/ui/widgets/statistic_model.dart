import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/exercise.dart';
import 'package:flutter_application_1/domain/entity/history.dart';
import 'package:flutter_application_1/domain/services/history_service.dart';

class StatisticViewModel extends ChangeNotifier {
  final HistoryService _service;
  final Exercise exercise;
  late List<History> listHistory = [];
  late List<FlSpot> weightSpots = [];
  late List<FlSpot> countSpots = [];

  StatisticViewModel(this.exercise, this._service){
    getHistoryList();
  }

  Future<void> getHistoryList() async
  {
    try{
      final fullList = await _service.loadHistory();
      listHistory = fullList.where((x) => x.name == exercise.name).toList();
      await getChartSpots();  
    } catch(e){
    }
    notifyListeners();
  }

  Future<void> getChartSpots() async
  {
      weightSpots = await getWeightSpot();
      countSpots = await getCountSpot();
  }

  Future<List<FlSpot>> getWeightSpot() async{
    return listHistory.asMap().entries.map((entry) {
      int index = entry.key;
      double weight = entry.value.weigth.toDouble();
      return FlSpot(index.toDouble(), weight);
    }).toList();
  }

  Future<List<FlSpot>> getCountSpot() async{
    return listHistory.asMap().entries.map((entry) {
      int index = entry.key;
      double count = entry.value.count.toDouble();
      return FlSpot(index.toDouble(), count);
    }).toList();
  }


}