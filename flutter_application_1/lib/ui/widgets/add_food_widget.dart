import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/domain/entity/food.dart';
import 'package:flutter_application_1/domain/entity/themeviewmodel.dart';
import 'package:flutter_application_1/ui/widgets/add_food_model.dart';
import 'package:provider/provider.dart';

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VM = context.watch<AddFoodModel>();
    final themeVM = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Новая позиция'),
      ),
      body: SizedBox(
        child: PageView(
          children:[
            SizedBox(
              height: 500,
              child: _AddWidget(themeVM: themeVM, VM: VM)
            ),
            _ChooseWidget(themeVM: themeVM, VM: VM)
          ]
        ),
      )
    );
  }
}

class _ChooseWidget extends StatelessWidget {
  const _ChooseWidget({
    required this.themeVM,
    required this.VM,
  });

  final ThemeViewModel themeVM;
  final AddFoodModel VM;

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Список выбранных продуктов'),
            
            SizedBox(
              height: 690,
              child: _ListFoodsWidget(VM: VM, themeVM: themeVM,)
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              await VM.addChooseFood();
              Navigator.pop(context);
            }, child: Text('Выбрать выбранные позиции'))
          ],
        ),
      ),
    );
  }
}

class _ListFoodsWidget extends StatelessWidget {
  _ListFoodsWidget({
    required this.VM, required this.themeVM,
  });

  final AddFoodModel VM;
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
      return Center(child: Text('Список целей пуст'));
    }

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (BuildContext context, int index)
      {
        final food = foods[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
            child: 
            ListTile(
              title: _TitleListFoodsWidget(food: food),
              subtitle: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('Калории: '),
                          Text(food.calories.toString()),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('Белки: '),
                          Text(food.proteins.toString() + ' гр.'),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('Жиры: '),
                          Text(food.fats.toString() + ' гр.'),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('Углеводы: '),
                          Text(food.carbohydrates.toString() + ' гр.'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
        );
      }
    );
  }
}

class _TitleListFoodsWidget extends StatefulWidget {
  const _TitleListFoodsWidget({
    required this.food,
  });

  final Food food;

  @override
  State<_TitleListFoodsWidget> createState() => _TitleListFoodsWidgetState();
}

class _TitleListFoodsWidgetState extends State<_TitleListFoodsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.food.isCheckForAdd, onChanged: (val){
            widget.food.isCheckForAdd = val!;
            setState(() {
              
            });
          }),
        SizedBox(width: 5,),
        Text(
          widget.food.name.length > 20 ?
          '${widget.food.name.substring(0,20)}..' : 
          widget.food.name, 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _AddWidget extends StatelessWidget {
  const _AddWidget({
    required this.themeVM,
    required this.VM,
  });

  final ThemeViewModel themeVM;
  final AddFoodModel VM;

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(controller: VM.nameController,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Наименование продукта',
                alignLabelWithHint: true, // <-- Это нужно, чтобы label не плавал в центре
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: VM.caloriesController,
              keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Калорийность, гр',
                ),
            ),
            SizedBox(height: 15,),
            TextField(controller: VM.proteinsController,
              keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Белки, гр',
                ),
            ),
            SizedBox(height: 15,),
            TextField(controller: VM.fatsController,
              keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Жиры, гр',
                ),
            ),
            SizedBox(height: 15,),
            TextField(controller: VM.carbohydratesController,
              keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // <-- только цифры
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Углеводы, гр',
                ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: () async{
                await VM.addNewFood();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
              elevation: 4,
              shadowColor: Colors.grey,
            ), 
              child: Text('Добавить'),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: Text('')),
                Text('Swipe ➡️'),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}