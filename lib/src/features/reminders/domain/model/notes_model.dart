import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ministry/src/core/controllers/uint8ListBase64Converter.dart';


part 'notes_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class NoteModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String? notes;

  @HiveField(3)
  @Uint8ListListBase64Converter()
  List<Uint8List>? attachments;

  NoteModel({
    required this.id,
    required this.title,
    this.notes,
    this.attachments,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
