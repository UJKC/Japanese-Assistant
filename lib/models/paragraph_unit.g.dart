// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph_unit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParagraphUnitAdapter extends TypeAdapter<ParagraphUnit> {
  @override
  final int typeId = 5;

  @override
  ParagraphUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParagraphUnit(
      title: fields[0] as String,
      slug: fields[1] as String,
      paragraphs: (fields[2] as List).cast<Paragraph>(),
    );
  }

  @override
  void write(BinaryWriter writer, ParagraphUnit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.paragraphs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParagraphUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
