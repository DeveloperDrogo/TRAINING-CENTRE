// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/coachingManager/model/staffListModel.dart';
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
        List result = response.data;
        return result;
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
      final response = await dio.get(
        '${Server.api}listSubjects',
      );

      if (response.statusCode == 200) {
        List result = response.data;
        return result;
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
      final response = await dio.get(
        '${Server.api}listBatchTime',
      );

      if (response.statusCode == 200) {
        List result = response.data;
        return result;
      } else {
        return [];
      }
    } catch (e) {
      //  print(e);
      return [];
    }
  }
}
