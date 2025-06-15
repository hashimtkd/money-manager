import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/DB/transaction_db.dart';
import 'package:money_maneger_provider_sqflite/model/category_model.dart';
import 'package:money_maneger_provider_sqflite/model/transaction_model.dart';

import 'package:money_maneger_provider_sqflite/provider/category_provider.dart';
import 'package:provider/provider.dart';

class TransactionProvider with ChangeNotifier {
  CategoryModel? dropDownValue;
  CategoryType? categoryTypeProvider = CategoryType.income;
  DateTime? transactionDate;
  List<TransactionModel> allCategory = [];

  void date(DateTime date) async {
    transactionDate = date;
    notifyListeners();
  }

  void radioButtonType(CategoryType value) {
    categoryTypeProvider = value;
    notifyListeners();
  }

  List<CategoryModel> incomeCategoryList(BuildContext context) {
    return Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).getIcomeCategory;
  }

  List<CategoryModel> expenseCategoryList(BuildContext context) {
    return Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).getExpenseCategory;
  }

  void dropDownSelectedValue(CategoryModel value) {
    dropDownValue = value;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transactionValues) async {
    await TransactionDb.instance.insertTransaction(transactionValues);
    await getAllCategories();
  }

  Future<void> getAllCategories() async {
    try {
      allCategory = await TransactionDb.instance.getAllTransaction();
    } catch (e) {
      print('error fetching transaction:$e');
    }
    notifyListeners();
  }
}
