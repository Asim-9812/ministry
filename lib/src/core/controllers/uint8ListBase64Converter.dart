
import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

class Uint8ListBase64Converter implements JsonConverter<Uint8List?, String?> {
  const Uint8ListBase64Converter();

  @override
  Uint8List? fromJson(String? json) =>
      json == null ? null : base64Decode(json);

  @override
  String? toJson(Uint8List? object) =>
      object == null ? null : base64Encode(object);
}


class Uint8ListListBase64Converter
    implements JsonConverter<List<Uint8List>?, List<String>?> {
  const Uint8ListListBase64Converter();

  @override
  List<Uint8List>? fromJson(List<String>? json) =>
      json?.map((e) => base64Decode(e)).toList();

  @override
  List<String>? toJson(List<Uint8List>? object) =>
      object?.map((e) => base64Encode(e)).toList();
}
