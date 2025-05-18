import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:flutter_application_1/ui/widgets/food_model.dart';
import 'package:provider/provider.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    final VM = context.watch<FoodModel>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('FoodWidget'),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _ListWidget(themeVM: themeVM, VM: VM),
      ),
    );
  }
}

class _ListWidget extends StatelessWidget {
  const _ListWidget({
    super.key,
    required this.themeVM,
    required this.VM,
  });

  final ThemeViewModel themeVM;
  final FoodModel VM;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CalWidget(themeVM: themeVM, VM: VM),
          _PFCWidget(themeVM: themeVM, VM: VM),
        ],
      ),
    );
  }
}

class _PFCWidget extends StatelessWidget {
  const _PFCWidget({
    super.key,
    required this.themeVM,
    required this.VM,
  });

  final ThemeViewModel themeVM;
  final FoodModel VM;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: themeVM.isDarkTheme ? Colors.black : Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PFCTitlesWidget(),
            SizedBox(height: 15,),
            _PFCDetailsWidget()
          ],
        ),
      ),
    );
  }
}

class _PFCDetailsWidget extends StatelessWidget {
  const _PFCDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(
          child: CircularProgressIndicator(
            value: 0.7, // 70% заполнения
            strokeWidth: 10.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        )),
        Expanded(child: Center(
          child: CircularProgressIndicator(
            value: 0.7, // 70% заполнения
            strokeWidth: 10.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        )),
        Expanded(child: Center(
          child: CircularProgressIndicator(
            value: 0.7, // 70% заполнения
            strokeWidth: 10.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        )),
      ],
    );
  }
}

class _PFCTitlesWidget extends StatelessWidget {
  const _PFCTitlesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(child: Text('Белки', style: TextStyle(),))),
        Expanded(child: Center(child: Text('Жиры'))),
        Expanded(child: Center(child: Text('Углеводы'))),
      ],
    );
  }
}

class _CalWidget extends StatelessWidget {
  const _CalWidget({
    super.key,
    required this.themeVM,
    required this.VM,
  });

  final ThemeViewModel themeVM;
  final FoodModel VM;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: themeVM.isDarkTheme ? Colors.black : Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Калории', style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(VM.CallValue, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
          ],
        ),
      ),
    );
  }
}