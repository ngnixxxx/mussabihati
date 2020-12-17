// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tassabih_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyTassabihModelAdapter extends TypeAdapter<MyTassabihModel> {
  @override
  final int typeId = 1;

  @override
  MyTassabihModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyTassabihModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MyTassabihModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tassbih)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.requiredCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyTassabihModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
