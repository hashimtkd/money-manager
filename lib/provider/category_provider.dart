import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/model/category_model.dart';
import 'package:money_maneger_provider_sqflite/DB/db_model.dart';

import 'package:money_maneger_provider_sqflite/screans/category/category_page.dart';
import 'package:money_maneger_provider_sqflite/screans/transaction/transaction_page.dart';
import 'package:sqflite/sqflite.dart';

class CategoryProvider with ChangeNotifier {
  int currentIndexProvider = 0;
  List<Widget> categoryPages = [TransactionPage(), CategoryPage()];
  CategoryType? categoryTypeProvider = CategoryType.income;
  List<CategoryModel> getIcomeCategory = [];
  List<CategoryModel> getExpenseCategory = [];

  CategoryProvider() {
    refrushUi();
  }

  void newCurrentIndexProvider(int newIndex) {
    currentIndexProvider = newIndex;
    if (newIndex == 0) {
    } else {
      categoryPages[1];
    }
    notifyListeners();
  }

  void newCategoryType(CategoryType value) {
    categoryTypeProvider = value;
    notifyListeners();
  }

  Future<void> insertTask(CategoryModel category) async {
    final Database db = await DatabaseHelper().database;

    await db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await refrushUi();
  }

  Future<List<CategoryModel>> getAllCategory() async {
    final Database db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await db.query('category');

    return List.generate(maps.length, (i) {
      return CategoryModel(
        name: maps[i]['name'],
        key: maps[i]['key'],
        type: maps[i]['type'] == 'income'
            ? CategoryType.income
            : CategoryType.expence,
      );
    });
  }

  Future<void> deleteCategory(int key) async {
    final Database db = await DatabaseHelper().database;
    await db.delete('category', where: 'key = ?', whereArgs: [key]);
    await refrushUi();
  }

  Future<void> refrushUi() async {
    final allCategory = await getAllCategory();
    getIcomeCategory = allCategory
        .where((element) => element.type == CategoryType.income)
        .toList();
    getExpenseCategory = allCategory
        .where((element) => element.type == CategoryType.expence)
        .toList();
    notifyListeners();
  }
}
