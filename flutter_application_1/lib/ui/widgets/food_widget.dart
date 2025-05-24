import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:flutter_application_1/ui/widgets/food_model.dart';
import 'package:flutter_application_1/ui/widgets/settingsFoods_model.dart';
import 'package:flutter_application_1/ui/widgets/settingsFoods_widget.dart';
import 'package:provider/provider.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeViewModel>(context);
    final VM = context.watch<FoodModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title: Row(
          children: [
            SizedBox(width: 48, height: 48,),
            Expanded(child: Center(child: Text('FoodWidget'))),
            IconButton(
              onPressed: () async{
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => SettingsfoodsModel(),
                      child: SettingsFoodsWidget(),
                    ),
                  ),
                );
              }, 
              icon: Icon(Icons.settings)
            ),
            IconButton(
              onPressed: (){

              }, 
              icon: Icon(Icons.add)
            )
          ],
        ),
      ),
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
          _FoodsWidget(themeVM: themeVM, VM: VM)
        ],
      ),
    );
  }
}

class _FoodsWidget extends StatelessWidget {
  const _FoodsWidget({
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
            Text('Сегодняшняя еда', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 15,),
            SizedBox(
              height: 250,
              child: _FoodsListWidget(VM: VM, themeVM: themeVM,)
            )
          ],
        ),
      ),
    );
  }
}

class _FoodsListWidget extends StatelessWidget {
  const _FoodsListWidget({
    super.key,
    required this.VM, required this.themeVM,
  });

  final FoodModel VM;
  final ThemeViewModel themeVM;

  @override
  Widget build(BuildContext context) {
    final state = VM.state;
    final foods = state.foods;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(child: Text('Ошибка: ${state.errorMessage}'));
    }

    if(foods.isEmpty){
      return Center(child: Text('Список пуст'));
    }

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (BuildContext context, int index){
        final food = foods[index];
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
            child: Column(
              children: [
                Row(
                  children: [
                    Text(food.name),
                    Divider(),
                    Text(food.calories.toString()),
                    Divider(),
                    Text(food.proteins.toString()),
                    Divider(),
                  ],
                )
              ],
            ),
        );
      }
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _PFCTitlesWidget(),
            SizedBox(height: 3,),
            _PFCValueWidget(VM: VM),
            SizedBox(height: 10,),
            _PFCDetailsWidget(VM: VM,),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}

class _PFCValueWidget extends StatelessWidget {
  const _PFCValueWidget({
    super.key,
    required this.VM,
  });

  final FoodModel VM;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(child: Text(VM.ProteinValue.toString()),)),
        Expanded(child: Center(child: Text(VM.FatsValue.toString()),)),
        Expanded(child: Center(child: Text(VM.Carbohydrates.toString()),))
      ],
    );
  }
}

class _PFCDetailsWidget extends StatelessWidget {
  const _PFCDetailsWidget({
    super.key, required this.VM,
  });

  final FoodModel VM;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: VM.GetNowProteins(), // 70% заполнения
              strokeWidth: 3.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
        )),
        Expanded(child: Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: 0.7, // 70% заполнения
              strokeWidth: 3.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
        )),
        Expanded(child: Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              value: 0.7, // 70% заполнения
              strokeWidth: 3.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
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
            Text(VM.CallValue.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
          ],
        ),
      ),
    );
  }
}