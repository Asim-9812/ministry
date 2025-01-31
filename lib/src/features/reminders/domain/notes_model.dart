import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 3)
class NoteModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String? notes;

  @HiveField(3)
  List<Uint8List>? attachments;

  NoteModel({required this.id, required this.title, this.notes, this.attachments});
}