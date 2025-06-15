// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:money_maneger_provider_sqflite/model/category_model.dart';

class TransactionModel {
  String purpose;
  String amount;
  int? key;
  CategoryType type;
  CategoryModel category;
  DateTime date;
  TransactionModel({
    required this.purpose,
    required this.amount,
    this.key,
    required this.type,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'purpose': purpose,
      'amount': amount,

      'type': type == CategoryType.income ? 'income' : 'expense',
      'category': category.name,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      purpose: map['purpose'],
      amount: map['amount'],
      key: map['key'],
      type: map['type'] == 'income'
          ? CategoryType.income
          : CategoryType.expence,
      category: CategoryModel(name: map['category']),
      date: DateTime.parse(map['date']),
    );
  }
}
