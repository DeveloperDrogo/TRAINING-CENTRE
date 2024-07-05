// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class SubjectListModel {
  final String subjectId;
  final String subjectName;

  SubjectListModel({required this.subjectId, required this.subjectName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectId': subjectId,
      'subjectName': subjectName,
    };
  }

  factory SubjectListModel.fromMap(Map<String, dynamic> map) {
    return SubjectListModel(
      subjectId: map['_id'] as String,
      subjectName: map['subject_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectListModel.fromJson(String source) =>
      SubjectListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
