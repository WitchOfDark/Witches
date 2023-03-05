// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiAdapter extends TypeAdapter<Api> {
  @override
  final int typeId = 0;

  @override
  Api read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Api(
      url: fields[0] as String,
      data: fields[1] as String,
      expire: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Api obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.expire);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
