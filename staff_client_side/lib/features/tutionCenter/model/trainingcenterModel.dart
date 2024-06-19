// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingCenterListModel {
  final String trainingCenterId;
  final String trainingCenterName;
  final String trainingCenterAddress;
  final String trainingCenterSubscriptionAmount;
  final String trainingCenterStatus;
  final String managerUserId;
  final String managerName;
  final String managerNumber;
  final String managerEmail;
  final String managerAddress;

  TrainingCenterListModel({required this.trainingCenterId, required this.trainingCenterName, required this.trainingCenterAddress, required this.trainingCenterSubscriptionAmount, required this.trainingCenterStatus, required this.managerUserId, required this.managerName, required this.managerNumber, required this.managerEmail, required this.managerAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trainingCenterId': trainingCenterId,
      'trainingCenterName': trainingCenterName,
      'trainingCenterAddress': trainingCenterAddress,
      'trainingCenterSubscriptionAmount': trainingCenterSubscriptionAmount,
      'trainingCenterStatus': trainingCenterStatus,
      'managerUserId': managerUserId,
      'managerName': managerName,
      'managerNumber': managerNumber,
      'managerEmail': managerEmail,
      'managerAddress': managerAddress,
    };
  }

  factory TrainingCenterListModel.fromMap(Map<String, dynamic> map) {
    return TrainingCenterListModel(
      trainingCenterId: map['training_center_id'] as String,
      trainingCenterName: map['training_center']['training_center_name'] as String,
      trainingCenterAddress: map['training_center']['training_center_address'] as String,
      trainingCenterSubscriptionAmount:  map['training_center']['subscription_amount'] as String,
      trainingCenterStatus:  map['training_center']['status'] as String,
      managerUserId: map['_id'] as String,
      managerName: map['name'] as String,
      managerNumber: map['mblnumber'] as String,
      managerEmail: map['email'] as String,
      managerAddress: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingCenterListModel.fromJson(String source) => TrainingCenterListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
