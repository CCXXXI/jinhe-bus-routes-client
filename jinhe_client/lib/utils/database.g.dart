// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogAdapter extends TypeAdapter<_Log> {
  @override
  final int typeId = 0;

  @override
  _Log read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Log()
      ..level = fields[0] as String
      ..stackTraceLevel = fields[1] as String
      ..includeCallerInfo = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, _Log obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.stackTraceLevel)
      ..writeByte(2)
      ..write(obj.includeCallerInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeAdapter extends TypeAdapter<_Theme> {
  @override
  final int typeId = 2;

  @override
  _Theme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Theme()
      .._primary = fields[0] as int
      .._secondary = fields[1] as int
      .._surface = fields[2] as int
      .._background = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, _Theme obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._primary)
      ..writeByte(1)
      ..write(obj._secondary)
      ..writeByte(2)
      ..write(obj._surface)
      ..writeByte(3)
      ..write(obj._background);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
