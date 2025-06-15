import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/model/category_model.dart';
import 'package:money_maneger_provider_sqflite/model/transaction_model.dart';

import 'package:money_maneger_provider_sqflite/provider/transaction_provider.dart';

import 'package:provider/provider.dart';

CategoryType? transactionCategoryType;

// ignore: must_be_immutable
class TransactionAddPage extends StatelessWidget {
  TransactionAddPage({super.key});

  final _pueposeControlller = TextEditingController();

  final _amountControlller = TextEditingController();

  CategoryModel? dropdownOnTapValue;
  DateTime? transactionDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'ADD YOUR TRANSACTION',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _pueposeControlller,
                decoration: InputDecoration(hint: Text('type purpose...')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _amountControlller,
                decoration: InputDecoration(hint: Text('type amount...')),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TransactionRadioButton(categoryValue: CategoryType.income),
                Text('income'),
                TransactionRadioButton(categoryValue: CategoryType.expence),
                Text('expense'),
              ],
            ),

            Consumer<TransactionProvider>(
              builder: (context, providerValue, child) {
                final incomeList = providerValue.incomeCategoryList(context);
                final expenseList = providerValue.expenseCategoryList(context);
                final categoryList =
                    providerValue.categoryTypeProvider == CategoryType.income
                    ? incomeList
                    : expenseList;
                return DropdownButton<CategoryModel>(
                  value: providerValue.dropDownValue,
                  hint: Text('select category'),
                  items: categoryList.map((categoryList) {
                    return DropdownMenuItem<CategoryModel>(
                      onTap: () {
                        dropdownOnTapValue = categoryList;
                        print(dropdownOnTapValue);
                      },
                      value: categoryList,
                      child: Text(categoryList.name),
                    );
                  }).toList(),

                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    providerValue.dropDownSelectedValue(value);
                  },
                );
              },
            ),
            Consumer<TransactionProvider>(
              builder: (context, providerValue, child) {
                return TextButton.icon(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    if (date == null) {
                      return;
                    }
                    providerValue.date(date);
                    transactionDate = providerValue.transactionDate;
                  },
                  label: Text(
                    providerValue.transactionDate == null
                        ? 'select date'
                        : providerValue.transactionDate.toString(),
                  ),
                  icon: Icon(Icons.calendar_month),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction(context);
                Navigator.pop(context);
              },
              child: Text('save'),
            ),
          ],
        ),
      ),
    );
  }

  void addTransaction(BuildContext context) {
    if (_pueposeControlller.text.isEmpty) {
      return;
    }

    if (_amountControlller.text.isEmpty) {
      return;
    }

    if (transactionCategoryType == null) {
      return;
    }
    if (transactionDate == null) {
      return;
    }

    if (dropdownOnTapValue == null) {
      return;
    }
    Provider.of<TransactionProvider>(context, listen: false).addTransaction(
      TransactionModel(
        purpose: _pueposeControlller.text,
        type: transactionCategoryType!,
        category: dropdownOnTapValue!,
        date: transactionDate!,
        amount: _amountControlller.text,
      ),
    );
  }
}

// ignore: must_be_immutable
class TransactionRadioButton extends StatelessWidget {
  TransactionRadioButton({super.key, required this.categoryValue});
  CategoryType? categoryValue;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, providerValue, child) {
        return Radio(
          value: categoryValue,
          groupValue: providerValue.categoryTypeProvider,
          onChanged: (value) {
            providerValue.dropDownValue = null;
            providerValue.radioButtonType(value!);
            transactionCategoryType = providerValue.categoryTypeProvider;
          },
        );
      },
    );
  }
}
