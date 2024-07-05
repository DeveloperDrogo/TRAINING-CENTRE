// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class ClassRoomModel {
  final String classId;
  final String classRoom;

  ClassRoomModel({required this.classId, required this.classRoom});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classId': classId,
      'classRoom': classRoom,
    };
  }

  factory ClassRoomModel.fromMap(Map<String, dynamic> map) {
    return ClassRoomModel(
      classId: map['_id'] as String,
      classRoom: map['class_room'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassRoomModel.fromJson(String source) =>
      ClassRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
