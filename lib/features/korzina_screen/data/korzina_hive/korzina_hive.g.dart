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
      title: fields[3] as String,
      valyuta: fields[6] as String,
      hajmi: fields[5] as String,
      image: fields[1] as String,
      number: fields[4] as int,
      id: fields[0] as int,
      price: fields[2] as int,
      rating: fields[7] as int,
      carType: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KorzinaCard obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.number)
      ..writeByte(5)
      ..write(obj.hajmi)
      ..writeByte(6)
      ..write(obj.valyuta)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.carType);
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
