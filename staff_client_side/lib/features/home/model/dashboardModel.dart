// ignore_for_file: file_names

import 'dart:convert';

class DashboardMenu {
  final String id;
  final String title;
  final String iconPath;
  final String route;

  DashboardMenu(
      {required this.id,
      required this.title,
      required this.iconPath,
      required this.route});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'iconPath': iconPath,
      'route': route,
    };
  }

  factory DashboardMenu.fromMap(Map<String, dynamic> map) {
    return DashboardMenu(
      id: map['_id'] as String,
      title: map['title'] as String,
      iconPath: map['icon_img_path'] as String,
      route: map['route'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardMenu.fromJson(String source) =>
      DashboardMenu.fromMap(json.decode(source) as Map<String, dynamic>);
}
