// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientBrandModelAdapter extends TypeAdapter<ClientBrandModel> {
  @override
  final int typeId = 13;

  @override
  ClientBrandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientBrandModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      count: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientBrandModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientBrandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
