import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/provider/category_provider.dart';
import 'package:provider/provider.dart';

class Incomecategorylistview extends StatelessWidget {
  const Incomecategorylistview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, providerValue, child) {
        return ListView.separated(
          itemCount: providerValue.getIcomeCategory.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (BuildContext context, int index) {
            final category = providerValue.getIcomeCategory[index];
            return ListTile(
              title: Text(category.name),
              trailing: IconButton(
                onPressed: () {
                  providerValue.deleteCategory(category.key!);
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        );
      },
    );
  }
}
