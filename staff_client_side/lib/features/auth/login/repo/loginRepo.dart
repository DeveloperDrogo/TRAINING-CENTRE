// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:staff_client_side/server/server.dart';

class LoginRepo {
  static Future checkMNumberIsExist({
    required mobile,
  }) async {
    var url = '${Server.api}checkNumberIsExist';
    Dio dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'mobile': mobile,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['jwtToken']);
        await prefs.setString('name', response.data['name']);
        await prefs.setString('mobile', response.data['mblnumber']);
        await prefs.setString('email', response.data['email']);
        await prefs.setString('role', response.data['role']);
        await prefs.setString('id', response.data['user_id']);
        await prefs.setString('dob', response.data['dob'] ?? '');
        await prefs.setString('address', response.data['address'] ?? '');
        await prefs.setString('image_path', response.data['image_path'] ?? '');
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
}
