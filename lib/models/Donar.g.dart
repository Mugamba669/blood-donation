// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Donar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonarAdapter extends TypeAdapter<Donar> {
  @override
  final int typeId = 0;

  @override
  Donar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Donar(
      name: fields[0] as String,
      contact: fields[1] as String,
      bloodGroup: fields[2] as String,
      latitude: fields[4] as double,
      longitude: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Donar obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contact)
      ..writeByte(2)
      ..write(obj.bloodGroup)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.latitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
