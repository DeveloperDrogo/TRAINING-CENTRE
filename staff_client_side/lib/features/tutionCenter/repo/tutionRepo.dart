// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/tutionCenter/model/trainingcenterModel.dart';
import 'package:staff_client_side/server/server.dart';

class TutionCenterRepo {
  static Future insertTrainingCenter({
    required trainingCentername,
    required trainingCenterAddress,
    required trainingCenterSubscription,
    required managerName,
    required managerContact,
    required managerEmail,
    required managerAddress,
  }) async {
    var url = '${Server.api}addTrainingCenter';
    Dio dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'training_center_name': trainingCentername,
          'training_center_address': trainingCenterAddress,
          'training_center_subscription': trainingCenterSubscription,
          'manager_name': managerName,
          'manager_email': managerEmail,
          'manager_contact': managerContact,
          'manager_address': managerAddress,
          'user_id': SharedPrefs().id
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
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

  static Future<List<TrainingCenterListModel>> listTrainingCenters() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${Server.api}listTrainingCenters',
        data: {'user_id': SharedPrefs().id},
      );

      List<TrainingCenterListModel> trainingCentersList = [];

      // Iterate through the list of job postings in the API response
      for (var centerData in response.data) {
        // Create a PostedJobModel instance for each job posting
        TrainingCenterListModel ceenters =
            TrainingCenterListModel.fromMap(centerData);
        // Add the PostedJobModel instance to the trainingCentersList
        trainingCentersList.add(ceenters);
      }

      // Return the list of job postings
      return trainingCentersList;
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  static Future updateTrainingCenterInfo(
      {required trainingCentername,
      required trainingCenterAddress,
      required trainingCenterSubscription,
      required managerName,
      required managerContact,
      required managerEmail,
      required managerAddress,
      required trainingcenterId,
      required isActive,
      required status,
      required isSubscribed,
      required mangerUserId}) async {
    var url = '${Server.api}updateTrainingCenter';
    Dio dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: jsonEncode({
          'training_center_name': trainingCentername,
          'training_center_address': trainingCenterAddress,
          'is_active': isActive,
          'training_center_subscription': trainingCenterSubscription,
          'manager_name': managerName,
          'manager_email': managerEmail,
          'manager_contact': managerContact,
          'manager_address': managerAddress,
          'manager_user_id': mangerUserId,
          'status':status,
          'training_center_id': trainingcenterId,
          'is_subscribed':isSubscribed,
          'user_id': SharedPrefs().id
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
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
}
