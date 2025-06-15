import 'package:flutter/material.dart';
import 'package:money_maneger_provider_sqflite/provider/category_provider.dart';
import 'package:money_maneger_provider_sqflite/provider/transaction_provider.dart';
import 'package:money_maneger_provider_sqflite/screans/homeScrean.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> args) async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) {
            return CategoryProvider();
          },
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (context) {
            return TransactionProvider();
          },
        ),
      ],
      child: MaterialApp(home: Homescrean()),
    );
  }
}
