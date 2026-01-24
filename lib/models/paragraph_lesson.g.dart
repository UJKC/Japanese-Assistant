// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParagraphLessonAdapter extends TypeAdapter<ParagraphLesson> {
  @override
  final int typeId = 4;

  @override
  ParagraphLesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParagraphLesson(
      lessonNumber: fields[0] as int,
      lessonTitle: fields[1] as String,
      lessonPages: fields[2] as String,
      slug: fields[3] as String,
      units: (fields[4] as List).cast<ParagraphUnit>(),
    );
  }

  @override
  void write(BinaryWriter writer, ParagraphLesson obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lessonNumber)
      ..writeByte(1)
      ..write(obj.lessonTitle)
      ..writeByte(2)
      ..write(obj.lessonPages)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphLessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
