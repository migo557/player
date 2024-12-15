// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PictureModelAdapter extends TypeAdapter<PictureModel> {
  @override
  final int typeId = 3;

  @override
  PictureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PictureModel(
      bytes: fields[0] as Uint8List,
      mimetype: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PictureModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.bytes)
      ..writeByte(1)
      ..write(obj.mimetype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
