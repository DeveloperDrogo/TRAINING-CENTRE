// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StaffListModel {
  final String userId;
  final String staffId;
  final String name;
  final String dob;
  final String email;
  final String gender;
  final String blood;
  final String address;
  final String qualification;
  final String workExperience;
  final String governmentId;
  final String contact;
  final String roleid;
  final String roleName;

  StaffListModel(
      {required this.userId,
      required this.staffId,
      required this.name,
      required this.dob,
      required this.email,
      required this.gender,
      required this.blood,
      required this.address,
      required this.qualification,
      required this.workExperience,
      required this.governmentId,
      required this.contact,
      required this.roleid,
      required this.roleName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'name': name,
      'dob': dob,
      'email': email,
      'gender': gender,
      'blood': blood,
      'address': address,
      'qualification': qualification,
      'work_experience': workExperience,
      'governmentId': governmentId,
      'contact': contact,
      'roleid': roleid,
      'roleName': roleName,
      'staffId': staffId
    };
  }

  factory StaffListModel.fromMap(Map<String, dynamic> map) {
    return StaffListModel(
        name: map['name'] ?? '',
        dob: map['dob'] ?? '',
        email: map['email'] ?? '',
        gender: map['gender'] ?? '',
        blood: map['bloodGroup'] ?? '',
        address: map['address'] ?? '',
        qualification: map['qualification'] ?? '',
        workExperience: map['work_experience'] ?? '',
        governmentId: map['government_id'] ?? '',
        contact: map['mblnumber'] ?? '',
        roleid: map['role_id'] ?? '',
        roleName: map['role'] ?? '',
        staffId: map['staff_id'] ?? '',
        userId: map['_id'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory StaffListModel.fromJson(String source) =>
      StaffListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
