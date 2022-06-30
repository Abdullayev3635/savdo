// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_korzina_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientKorzinaCardAdapter extends TypeAdapter<ClientKorzinaCard> {
  @override
  final int typeId = 1;

  @override
  ClientKorzinaCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientKorzinaCard(
      bloklarSoni: fields[10] as int?,
      blok: fields[11] as int?,
      residue: fields[6] as int?,
      price: fields[5] as num?,
      name: fields[1] as String?,
      dona: fields[9] as int?,
      quantity: fields[12] as int?,
      id: fields[0] as int?,
      category: fields[2] as String?,
      size: fields[7] as String?,
      currencyId: fields[3] as int?,
      currencyName: fields[4] as String?,
      image: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ClientKorzinaCard obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientKorzinaCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
