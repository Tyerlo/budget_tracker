import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const AddBudgetDialog({required this.budgetToAdd, Key? key})
      : super(key: key);

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "Add a budget",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Budget in \$"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (amountController.text.isNotEmpty) {
                      widget.budgetToAdd(double.parse(amountController.text));

                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
