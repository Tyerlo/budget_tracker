// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransActionItemAdapter extends TypeAdapter<TransActionItem> {
  @override
  final int typeId = 1;

  @override
  TransActionItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransActionItem(
      itemTitle: fields[0] as String,
      amount: fields[1] as double,
      isExpense: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransActionItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.itemTitle)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransActionItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
