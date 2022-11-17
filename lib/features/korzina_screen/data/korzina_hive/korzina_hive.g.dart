// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korzina_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KorzinaCardAdapter extends TypeAdapter<KorzinaCard> {
  @override
  final int typeId = 1;

  @override
  KorzinaCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KorzinaCard(
      bloklarSoni: fields[10] as double?,
      blok: fields[11] as int?,
      residue: fields[6] as int?,
      price: fields[5] as num?,
      name: fields[1] as String?,
      dona: fields[9] as double?,
      quantity: fields[12] as double?,
      id: fields[0] as int?,
      category: fields[2] as String?,
      size: fields[7] as String?,
      currencyId: fields[3] as int?,
      currencyName: fields[4] as String?,
      image: fields[8] as String?,
      priceTypeId: fields[13] as int?,
      incomePrice: fields[14] as num?,
      incomePriceCurrencyId: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, KorzinaCard obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.currencyId)
      ..writeByte(4)
      ..write(obj.currencyName)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.residue)
      ..writeByte(7)
      ..write(obj.size)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.dona)
      ..writeByte(10)
      ..write(obj.bloklarSoni)
      ..writeByte(11)
      ..write(obj.blok)
      ..writeByte(12)
      ..write(obj.quantity)
      ..writeByte(13)
      ..write(obj.priceTypeId)
      ..writeByte(14)
      ..write(obj.incomePrice)
      ..writeByte(15)
      ..write(obj.incomePriceCurrencyId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KorzinaCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
