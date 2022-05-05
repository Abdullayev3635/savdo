// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_debit_credit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientDebitCreditModelAdapter
    extends TypeAdapter<ClientDebitCreditModel> {
  @override
  final int typeId = 7;

  @override
  ClientDebitCreditModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientDebitCreditModel(
      name: fields[0] as String?,
      value: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientDebitCreditModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientDebitCreditModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
