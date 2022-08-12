import 'package:budget_tracker/services/local_storage_service.dart';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => LocalStorageService().getBudget();

  double getBalance() => LocalStorageService().getBalance();

  List<TransActionItem> get items => LocalStorageService().getAllTransActions();

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void addItem(TransActionItem item) {
    final localStorage = LocalStorageService();
    localStorage.saveTransActionItem(item);
    notifyListeners();
  }

  void deleteItem(TransActionItem item) {
    final localStorage = LocalStorageService();
    // Call our localstorage service to delete the item
    localStorage.deleteTransactionItem(item);
    // Notify the listeners
    notifyListeners();
  }
}
