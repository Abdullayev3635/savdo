// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model1.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatalogModelAdapter extends TypeAdapter<CatalogModel> {
  @override
  final int typeId = 0;

  @override
  CatalogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatalogModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      repetition: fields[2] as String?,
      status: fields[3] as int?,
      isCheck: fields[4] as bool,
      count: fields[5] as int?,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CatalogModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.repetition)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.isCheck)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatalogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
