import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
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
      //print('response is ${response.data}');

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
}
