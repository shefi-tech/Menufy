// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchHistoryAdapter extends TypeAdapter<SearchHistory> {
  @override
  final int typeId = 0;

  @override
  SearchHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchHistory(
      from: fields[0] as String,
      to: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
