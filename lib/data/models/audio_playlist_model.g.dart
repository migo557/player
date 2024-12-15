// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioPlaylistModelAdapter extends TypeAdapter<AudioPlaylistModel> {
  @override
  final int typeId = 2;

  @override
  AudioPlaylistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioPlaylistModel(
      name: fields[0] as String,
      created: fields[1] as DateTime,
      modified: fields[2] as DateTime,
      audios: (fields[3] as List).cast<AudioModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AudioPlaylistModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.modified)
      ..writeByte(3)
      ..write(obj.audios);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioPlaylistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
