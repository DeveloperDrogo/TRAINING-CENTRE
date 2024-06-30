import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/server/server.dart';

class ProfileRepo {
  static Future updateUserWithoutDoc({
    required name,
    required dob,
    required email,
    required gender,
    required blood,
    required address,
    required qualification,
    required workExperience,
    required govermentID,
  }) async {
    var url = '${Server.api}userInfoUpdateWithoutDoc';
    Dio dio = Dio();
    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'name': name,
          'dob': dob,
          'email': email,
          'gender': gender,
          'bloodGroup': blood,
          'address': address,
          'qualification': qualification,
          'work_experience': workExperience,
          'government_id': govermentID,
          'user_id': SharedPrefs().id
        }),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
       
        await prefs.setString('name', response.data['name']);
        await prefs.setString('mobile', response.data['mblnumber']);
        await prefs.setString('email', response.data['email']);
        await prefs.setString('id', response.data['_id']);
        await prefs.setString('dob', response.data['dob'] ?? '');
        await prefs.setString('address', response.data['address'] ?? '');
        await prefs.setString('image_path', response.data['image_path'] ?? '');
        await prefs.setString('gender', response.data['gender'] ?? '');
        await prefs.setString('bloodGroup', response.data['bloodGroup'] ?? '');
        await prefs.setString(
            'qualification', response.data['qualification'] ?? '');
        await prefs.setString(
            'work_experience', response.data['work_experience'] ?? '');
        await prefs.setString(
            'governemnt_id', response.data['government_id'] ?? '');
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

  static Future updateUserWithDoc({
    required File empFace,
    required String empCode,
    required name,
    required dob,
    required email,
    required gender,
    required blood,
    required address,
    required qualification,
    required workExperience,
    required govermentID,
  }) async {
    final url = '${Server.api}userInfoUpdateWithDoc';
    Dio dio = Dio();
    try {
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(empFace.path, filename: empCode),
        'name': name,
        'dob': dob,
        'email': email,
        'gender': gender,
        'bloodGroup': blood,
        'address': address,
        'qualification': qualification,
        'work_experience': workExperience,
        'government_id': govermentID,
        'user_id': SharedPrefs().id
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'jwt': SharedPrefs().token
          },
        ),
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', response.data['name']);
        await prefs.setString('mobile', response.data['mblnumber']);
        await prefs.setString('email', response.data['email']);
        await prefs.setString('id', response.data['_id']);
        await prefs.setString('dob', response.data['dob'] ?? '');
        await prefs.setString('address', response.data['address'] ?? '');
        await prefs.setString('image_path', response.data['image_path'] ?? '');
        await prefs.setString('gender', response.data['gender'] ?? '');
        await prefs.setString('bloodGroup', response.data['bloodGroup'] ?? '');
        await prefs.setString(
            'qualification', response.data['qualification'] ?? '');
        await prefs.setString(
            'work_experience', response.data['work_experience'] ?? '');
        await prefs.setString(
            'governemnt_id', response.data['government_id'] ?? '');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
      //throw 'Something Went Wrong';
    } finally {
      dio.close();
    }
  }
}
