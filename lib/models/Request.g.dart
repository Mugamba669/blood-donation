// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestsAdapter extends TypeAdapter<Requests> {
  @override
  final int typeId = 1;

  @override
  Requests read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Requests(
      name: fields[0] as String,
      date: fields[1] as String,
      group: fields[2] as String,
      phone: fields[4] as double,
      quantity: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Requests obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
