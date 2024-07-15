// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeTableModel {
  final String staffId;
  final String staffName;
  final String subjectId;
  final String subjectName;
  final String batchId;
  final String batchName;
  final String classRoomId;
  final String classRoomName;
  final String day;

  TimeTableModel(
      {required this.staffId,
      required this.staffName,
      required this.subjectId,
      required this.subjectName,
      required this.batchId,
      required this.batchName,
      required this.classRoomId,
      required this.classRoomName,
      required this.day});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'staffId': staffId,
      'staffName': staffName,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'batchId': batchId,
      'batchName': batchName,
      'classRoomId': classRoomId,
      'classRoomName': classRoomName,
      'day': day,
    };
  }

  factory TimeTableModel.fromMap(Map<String, dynamic> map) {
    return TimeTableModel(
      staffId: map['staff_id'] as String,
      staffName: map['staff_name'] as String,
      subjectId: map['subject_id'] as String,
      subjectName: map['subject_name'] as String,
      batchId: map['batch_id'] as String,
      batchName: map['batch_time'] as String,
      classRoomId: map['class_room_id'] as String,
      classRoomName: map['class_name'] as String,
      day: map['day'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeTableModel.fromJson(String source) =>
      TimeTableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
