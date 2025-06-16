import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_maneger_provider_sqflite/model/category_model.dart';
import 'package:money_maneger_provider_sqflite/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<TransactionProvider>(
        context,
        listen: false,
      ).getAllCategories(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error:${snapshot.error}'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TransactionProvider>(
            builder: (context, providerValue, child) {
              return ListView.separated(
                itemCount: providerValue.allCategory.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color:
                        providerValue.allCategory[index].type ==
                            CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    elevation: 10,
                    child: ListTile(
                      title: CircleAvatar(
                        child: Text(
                          dateParse(providerValue.allCategory[index].date),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(providerValue.allCategory[index].amount),
                          Text(
                            '${providerValue.allCategory[index].category.name} : ${providerValue.allCategory[index].purpose}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  String dateParse(DateTime date) {
    final _date = DateFormat.MMMd().format(date).split(' ');
    return '${_date.last}\n${_date.first}';
  }
}
