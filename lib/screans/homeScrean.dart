import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/provider/category_provider.dart';
import 'package:money_maneger_provider_sqflite/screans/category/category_page.dart';
import 'package:money_maneger_provider_sqflite/screans/transaction/transaction_add_page.dart';

import 'package:provider/provider.dart';

class Homescrean extends StatelessWidget {
  const Homescrean({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('money ')),
          backgroundColor: Colors.grey,
        ),
        bottomNavigationBar: Consumer<CategoryProvider>(
          builder: (context, providervalue, child) {
            return BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.money),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'categories',
                ),
              ],
              selectedItemColor: Colors.blue,
              currentIndex: providervalue.currentIndexProvider,
              onTap: (value) {
                providervalue.newCurrentIndexProvider(value);
              },
            );
          },
        ),
        floatingActionButton: Consumer<CategoryProvider>(
          builder: (context, providerValue, Widget? child) {
            return FloatingActionButton(
              onPressed: () {
                if (providerValue.currentIndexProvider == 0) {
                  print('transaction add');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TransactionAddPage();
                      },
                    ),
                  );
                } else {
                  print('category add');
                  categoryAddButton(context);
                }
              },
              child: Icon(Icons.add),
            );
          },
        ),
        body: Consumer<CategoryProvider>(
          builder: (context, providereValue, child) {
            return providereValue.categoryPages[providereValue
                .currentIndexProvider];
          },
        ),
      ),
    );
  }
}
