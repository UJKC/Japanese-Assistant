// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParagraphAdapter extends TypeAdapter<Paragraph> {
  @override
  final int typeId = 6;

  @override
  Paragraph read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paragraph(
      title: fields[0] as String,
      content: fields[1] as String,
      questions: (fields[2] as List).cast<QuestionAnswer>(),
    );
  }

  @override
  void write(BinaryWriter writer, Paragraph obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
