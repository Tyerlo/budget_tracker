import 'package:hive/hive.dart';
part 'transaction_item.g.dart';

@HiveType(typeId: 1)
class TransActionItem {
  @HiveField(0)
  String itemTitle;
  @HiveField(1)
  double amount;
  @HiveField(2)
  bool isExpense;

  TransActionItem(
      {required this.itemTitle, required this.amount, this.isExpense = true});
}
