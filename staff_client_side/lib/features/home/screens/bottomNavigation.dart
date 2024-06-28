// ignore_for_file: unused_field

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/home/screens/homePage.dart';
import 'package:staff_client_side/features/profile/screens/profile.dart';
import 'package:staff_client_side/features/tutionCenter/screens/listtutioncenterInfo.dart';
import 'package:staff_client_side/features/tutionCenter/screens/tutioncenter.dart';

import 'package:upgrader/upgrader.dart';

/// Flutter code sample for [BottomNavigationBar].

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const AddTutionCenterPage(),
    const TrainingCenterInfo(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AdaptiveTheme.of(context).mode.isDark
                ? AdaptiveTheme.of(context).darkTheme.canvasColor
                : Colors.white,
            elevation: 6,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.paper_plus),
                label: 'Add Center',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.info_circle),
                label: 'Center Info',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.profile),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AdaptiveTheme.of(context).mode.isDark
                ? Colors.white
                :  MyColors.primaryColor,
            unselectedItemColor: const Color.fromARGB(255, 100, 100, 100),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
