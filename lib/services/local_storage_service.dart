import 'package:budget_tracker/model/transaction_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String transactionBoxKey = "transactionsBox";
  static const String balanceBoxKey = "balanceBox";
  static const String budgetBoxKey = "budgetBoxKey";

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransActionItemAdapter());
    }
    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransActionItem>(transactionBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  Future<void> saveBalance(TransActionItem item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance + item.amount);
    } else {
      balanceBox.put("balance", currentBalance - item.amount);
    }
  }

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ?? 0.0;
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 2000.0;
  }

  Future<void> saveBudget(double budget) {
    return Hive.box<double>(budgetBoxKey).put("budget", budget);
  }

  void saveTransActionItem(TransActionItem transaction) {
    Hive.box<TransActionItem>(transactionBoxKey).add(transaction);
    saveBalance(transaction);
  }

  List<TransActionItem> getAllTransActions() {
    return Hive.box<TransActionItem>(transactionBoxKey).values.toList();
  }

  void deleteTransactionItem(TransActionItem transaction) {
    // Get a list of our transactions
    final transactions = Hive.box<TransActionItem>(transactionBoxKey);
    // Create a map out of it
    final Map<dynamic, TransActionItem> map = transactions.toMap();
    dynamic desiredKey;
    // For each key in the map, we check if the transaction is the same as the one we want to delete
    map.forEach((key, value) {
      if (value.itemTitle == transaction.itemTitle) desiredKey = key;
    });
    // If we found the key, we delete it
    transactions.delete(desiredKey);
    // And we update the balance
    saveBalanceOnDelete(transaction);
  }

  Future<void> saveBalanceOnDelete(TransActionItem item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0.0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance - item.amount);
    } else {
      balanceBox.put("balance", currentBalance + item.amount);
    }
  }
}
