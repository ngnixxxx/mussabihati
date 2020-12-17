// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_athkar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyAthkarModelAdapter extends TypeAdapter<MyAthkarModel> {
  @override
  final int typeId = 0;

  @override
  MyAthkarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyAthkarModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyAthkarModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.thekr)
      ..writeByte(1)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyAthkarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
