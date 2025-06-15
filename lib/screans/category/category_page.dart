import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/model/category_model.dart';
import 'package:money_maneger_provider_sqflite/provider/category_provider.dart';
import 'package:money_maneger_provider_sqflite/screans/category/expenceCategoryListView.dart';
import 'package:money_maneger_provider_sqflite/screans/category/incomeCategoryListView.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context).categoryTypeProvider;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelStyle: TextStyle(fontSize: 25),
            tabs: [Text('Income'), Text('Expense')],
          ),
          Expanded(
            child: TabBarView(
              children: [Incomecategorylistview(), Expencecategorylistview()],
            ),
          ),
        ],
      ),
    );
  }
}

void categoryAddButton(context) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController? categoryTextcontroller = TextEditingController();
      return AlertDialog(
        title: Text('Add Category'),
        content: TextFormField(
          controller: categoryTextcontroller,
          decoration: InputDecoration(hint: Text('Type category...')),
        ),
        actions: [
          Column(
            children: [
              Row(
                children: [
                  CategoryRadioButton(CategoryValue: CategoryType.income),
                  Text('Income'),
                  CategoryRadioButton(CategoryValue: CategoryType.expence),
                  Text('Expence'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (categoryTextcontroller.text.isEmpty) {
                    return;
                  }
                  Provider.of<CategoryProvider>(
                    context,
                    listen: false,
                  ).insertTask(
                    CategoryModel(
                      name: categoryTextcontroller.text,
                      type: Provider.of<CategoryProvider>(
                        context,
                        listen: false,
                      ).categoryTypeProvider!,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

// ignore: must_be_immutable
class CategoryRadioButton extends StatelessWidget {
  CategoryRadioButton({super.key, required this.CategoryValue});
  CategoryType? CategoryValue;
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, providerValue, child) {
        return Radio(
          value: CategoryValue,
          groupValue: providerValue.categoryTypeProvider,
          onChanged: (value) {
            providerValue.newCategoryType(value!);
          },
        );
      },
    );
  }
}
