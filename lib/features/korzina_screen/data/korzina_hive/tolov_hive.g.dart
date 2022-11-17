// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tolov_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TolovHiveAdapter extends TypeAdapter<TolovHive> {
  @override
  final int typeId = 15;

  @override
  TolovHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TolovHive(
      id: fields[0] as int?,
      cash: fields[1] as String?,
      paymentTypeId: fields[2] as int?,
      currencyId: fields[3] as int?,
      currencyValue: fields[4] as String?,
      description: fields[5] as String?,
      paymentTypeName: fields[6] as String?,
      currencyName: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TolovHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cash)
      ..writeByte(2)
      ..write(obj.paymentTypeId)
      ..writeByte(3)
      ..write(obj.currencyId)
      ..writeByte(4)
      ..write(obj.currencyValue)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.paymentTypeName)
      ..writeByte(7)
      ..write(obj.currencyName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TolovHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
