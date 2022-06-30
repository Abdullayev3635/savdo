// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyurtma_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyurtmaModelAdapter extends TypeAdapter<BuyurtmaModel> {
  @override
  final int typeId = 7;

  @override
  BuyurtmaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyurtmaModel(
      currency: (fields[0] as List?)?.cast<CurrencyModel>(),
      priceType: (fields[1] as List?)?.cast<PriceTypeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BuyurtmaModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.priceType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyurtmaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
