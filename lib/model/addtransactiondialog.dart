import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(TransActionItem) itemToAdd;
  const AddTransactionDialog({required this.itemToAdd, Key? key})
      : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isExpenseController = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: itemTitleController,
                decoration: const InputDecoration(hintText: "Name of expense"),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Is expense?"),
                  Switch.adaptive(
                      value: _isExpenseController,
                      onChanged: (b) {
                        setState(() {
                          _isExpenseController = b;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (amountController.text.isNotEmpty &&
                        itemTitleController.text.isNotEmpty) {
                      widget.itemToAdd(TransActionItem(
                          amount: double.parse(amountController.text),
                          itemTitle: itemTitleController.text,
                          isExpense: _isExpenseController));
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
