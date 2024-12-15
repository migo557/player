// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioModelAdapter extends TypeAdapter<AudioModel> {
  @override
  final int typeId = 1;

  @override
  AudioModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioModel(
      title: fields[0] as String,
      ext: fields[4] as String,
      path: fields[5] as String,
      size: fields[6] as int,
      thumbnail: (fields[8] as List).cast<Picture>(),
      artists: fields[1] as String,
      album: fields[2] as String,
      genre: (fields[3] as List).cast<String>(),
      bitrate: fields[7] as int?,
      lyrics: fields[9] as String?,
      sampleRate: fields[10] as int?,
      language: fields[11] as String?,
      year: fields[12] as DateTime?,
      file: fields[13] as File,
      quality: fields[14] as Quality,
      lastModified: fields[15] as DateTime,
      lastAccessed: fields[16] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AudioModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.artists)
      ..writeByte(2)
      ..write(obj.album)
      ..writeByte(3)
      ..write(obj.genre)
      ..writeByte(4)
      ..write(obj.ext)
      ..writeByte(5)
      ..write(obj.path)
      ..writeByte(6)
      ..write(obj.size)
      ..writeByte(7)
      ..write(obj.bitrate)
      ..writeByte(8)
      ..write(obj.thumbnail)
      ..writeByte(9)
      ..write(obj.lyrics)
      ..writeByte(10)
      ..write(obj.sampleRate)
      ..writeByte(11)
      ..write(obj.language)
      ..writeByte(12)
      ..write(obj.year)
      ..writeByte(13)
      ..write(obj.file)
      ..writeByte(14)
      ..write(obj.quality)
      ..writeByte(15)
      ..write(obj.lastModified)
      ..writeByte(16)
      ..write(obj.lastAccessed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
