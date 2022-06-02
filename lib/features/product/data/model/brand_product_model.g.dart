// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_local_variable

part of 'brand_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandProductModelAdapter extends TypeAdapter<BrandProductModel> {
  @override
  final int typeId = 3;

  @override
  BrandProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandProductModel();
  }

  @override
  void write(BinaryWriter writer, BrandProductModel obj) {
    // ignore: avoid_single_cascade_in_expression_statements
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
