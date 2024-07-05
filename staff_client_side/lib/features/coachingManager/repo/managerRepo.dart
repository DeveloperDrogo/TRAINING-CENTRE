// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/coachingManager/model/batchListModel.dart';
import 'package:staff_client_side/features/coachingManager/model/classRoomModel.dart';
import 'package:staff_client_side/features/coachingManager/model/staffListModel.dart';
import 'package:staff_client_side/features/coachingManager/model/subjectListModel.dart';
import 'package:staff_client_side/server/server.dart';

class ManagerRepo {
  static Future<List> listAllRoles() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        '${Server.api}listRoles',
      );

      if (response.statusCode == 200) {
        return response.data['fetchAllRoles'];
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future insertStaffDetails({
    required name,
    required contact,
    required dob,
    required email,
    required gender,
    required roleId,
    required blood,
    required address,
    required qualification,
    required workExperience,
    required govermentID,
  }) async {
    var url = '${Server.api}insertStaff';
    Dio dio = Dio();
    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'name': name,
          'contact': contact,
          'roleId': roleId,
          'dob': dob,
          'email': email,
          'gender': gender,
          'bloodGroup': blood,
          'address': address,
          'qualification': qualification,
          'work_experience': workExperience,
          'government_id': govermentID,
          'user_id': SharedPrefs().id,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      dio.close();
    }
  }

  static Future<List<StaffListModel>> listAllStaffs() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${Server.api}listAllStaffs',
        data: {'user_id': SharedPrefs().id},
      );

      var listAllStaffs = response.data['staffsWithRoles'];

      List<StaffListModel> allStaffs = [];

      // Iterate through the list of job postings in the API response
      for (var staffData in listAllStaffs) {
        // Create a PostedJobModel instance for each job posting
        StaffListModel staffs = StaffListModel.fromMap(staffData);
        // Add the PostedJobModel instance to the allStaffs
        allStaffs.add(staffs);
      }

      // Return the list of job postings
      return allStaffs;
    } catch (e) {
      return [];
    }
  }

  static Future updateStaffDetails({
    required userId,
    required staffId,
    required name,
    required contact,
    required dob,
    required email,
    required gender,
    required roleId,
    required blood,
    required address,
    required qualification,
    required workExperience,
    required govermentID,
  }) async {
    var url = '${Server.api}updateStaff';
    Dio dio = Dio();
    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'user_id': userId,
          'staff_id': staffId,
          'name': name,
          'contact': contact,
          'roleId': roleId,
          'dob': dob,
          'email': email,
          'gender': gender,
          'bloodGroup': blood,
          'address': address,
          'qualification': qualification,
          'work_experience': workExperience,
          'government_id': govermentID,
          'my_id': SharedPrefs().id,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      dio.close();
    }
  }

  static Future listStaffs() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${Server.api}listStaffs',
        data: {'id': SharedPrefs().id},
      );

      if (response.statusCode == 200) {
        var listAllStaffs = response.data;

        List<StaffListModel> allStaffs = [];

        // Iterate through the list of job postings in the API response
        for (var staffData in listAllStaffs) {
          // Create a PostedJobModel instance for each job posting
          StaffListModel staffs = StaffListModel.fromMap(staffData);
          // Add the PostedJobModel instance to the allStaffs
          allStaffs.add(staffs);
        }

        // Return the list of job postings
        return allStaffs;
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future listAllSubjects() async {
    Dio dio = Dio();

    try {
      final response = await dio
          .post('${Server.api}listSubjects', data: {'id': SharedPrefs().id});

      if (response.statusCode == 200) {
        var listAllSubjects = response.data;

        List<SubjectListModel> allsubjects = [];

        // Iterate through the list of job postings in the API response
        for (var subjectData in listAllSubjects) {
          // Create a PostedJobModel instance for each job posting
          SubjectListModel subject = SubjectListModel.fromMap(subjectData);
          // Add the PostedJobModel instance to the allStaffs
          allsubjects.add(subject);
        }

        // Return the list of job postings
        return allsubjects;
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future listBatchTimings() async {
    Dio dio = Dio();

    try {
      final response = await dio
          .post('${Server.api}listBatchTime', data: {'id': SharedPrefs().id});

      if (response.statusCode == 200) {
        var listAllBatches = response.data;

        List<BatchListModel> allBatches = [];

        // Iterate through the list of job postings in the API response
        for (var batchData in listAllBatches) {
          // Create a PostedJobModel instance for each job posting
          BatchListModel batch = BatchListModel.fromMap(batchData);
          // Add the PostedJobModel instance to the allStaffs
          allBatches.add(batch);
        }

        // Return the list of job postings
        return allBatches;
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future listClassrooms() async {
    Dio dio = Dio();

    try {
      final response = await dio
          .post('${Server.api}classRoomList', data: {'id': SharedPrefs().id});

      if (response.statusCode == 200) {
        var listAllClass = response.data;

        List<ClassRoomModel> allClassess = [];

        // Iterate through the list of job postings in the API response
        for (var classData in listAllClass) {
          // Create a PostedJobModel instance for each job posting
          ClassRoomModel batch = ClassRoomModel.fromMap(classData);
          // Add the PostedJobModel instance to the allStaffs
          allClassess.add(batch);
        }

        // Return the list of job postings
        return allClassess;
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future insertClassShedule(
      {required staffId,
      required subjectId,
      required batchId,
      required classId}) async {
    Dio dio = Dio();

    try {
      final response = await dio.post('${Server.api}insertClassShedule', data: {
        'user_id': SharedPrefs().id,
        'staff_id': staffId,
        'subject_id': subjectId,
        'batch_id': batchId,
        'class_id': classId
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //  print(e);
      return false;
    }
  }
}
