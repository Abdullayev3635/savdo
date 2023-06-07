// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viloyat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViloyatModelAdapter extends TypeAdapter<ViloyatModel> {
  @override
  final int typeId = 11;

  @override
  ViloyatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ViloyatModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ViloyatModel obj) {
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
      other is ViloyatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
