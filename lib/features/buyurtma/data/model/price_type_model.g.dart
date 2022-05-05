// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceTypeModelAdapter extends TypeAdapter<PriceTypeModel> {
  @override
  final int typeId = 9;

  @override
  PriceTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceTypeModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PriceTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
