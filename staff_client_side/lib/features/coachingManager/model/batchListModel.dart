// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
import 'dart:convert';

class BatchListModel {
  final String batchId;
  final String batchTime;

  BatchListModel({required this.batchId, required this.batchTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batchId': batchId,
      'batchTime': batchTime,
    };
  }

  factory BatchListModel.fromMap(Map<String, dynamic> map) {
    return BatchListModel(
      batchId: map['_id'] as String,
      batchTime: map['batch_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchListModel.fromJson(String source) => BatchListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
