import 'package:budget_tracker/model/transaction_item.dart';

import 'package:budget_tracker/view_model/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransActionCard extends StatelessWidget {
  final TransActionItem item;
  const TransActionCard({required this.item, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    const Text("Delete item"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          final budgetViewModel = Provider.of<BudgetViewModel>(
                              context,
                              listen: false);
                          budgetViewModel.deleteItem(item);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"))
                  ]),
                ),
              );
            },
          )),
    );
  }
}
