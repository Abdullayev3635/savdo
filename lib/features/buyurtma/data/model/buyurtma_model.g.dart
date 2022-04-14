// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'buyurtma_model.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class BuyurtmaModelAdapter extends TypeAdapter<BuyurtmaModel> {
//   @override
//   final int typeId = 4;
//
//   @override
//   BuyurtmaModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return BuyurtmaModel(
//       id: fields[0] as int?,
//       name: fields[1] as String?,
//       qarz: fields[3] as int?,
//       narxTuri: fields[4] as String?,
//       savdoTuri: fields[5] as String?,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, BuyurtmaModel obj) {
//     writer
//       ..writeByte(5)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(3)
//       ..write(obj.qarz)
//       ..writeByte(4)
//       ..write(obj.narxTuri)
//       ..writeByte(5)
//       ..write(obj.savdoTuri);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is BuyurtmaModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
