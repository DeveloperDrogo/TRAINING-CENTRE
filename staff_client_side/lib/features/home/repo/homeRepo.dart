// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/home/model/dashboardModel.dart';
import 'package:staff_client_side/server/server.dart';

class HomeRepo {
  static Future<List<DashboardMenu>> dashboardMenu() async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        '${Server.api}dashboardMenu',
        data: {'role': SharedPrefs().role},
      );

      List<DashboardMenu> dashboardList = [];

      // Iterate through the list of job postings in the API response
      for (var dashboarddata in response.data) {
        // Create a PostedJobModel instance for each job posting
        DashboardMenu dashboardMenuList = DashboardMenu.fromMap(dashboarddata);
        // Add the PostedJobModel instance to the dashboardList
        dashboardList.add(dashboardMenuList);
      }

      // Return the list of job postings
      return dashboardList;
    } catch (e) {
      //  print(e);
      return [];
    }
  }
}
