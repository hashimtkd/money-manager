import 'package:flutter/material.dart';
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
              print('List length:${providerValue.allCategory.length}');
              return ListView.separated(
                itemCount: providerValue.allCategory.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10,
                    child: ListTile(
                      title: CircleAvatar(
                        child: Text(
                          providerValue.allCategory[index].date.toString(),
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
}
