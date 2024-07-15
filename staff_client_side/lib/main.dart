// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/auth/login/screens/login.dart';
import 'package:staff_client_side/features/coachingManager/screens/classShedule/trainingShedule.dart';
import 'package:staff_client_side/features/coachingManager/screens/staffInfo/addStaff.dart';
import 'package:staff_client_side/features/coachingManager/screens/staffInfo/staffList.dart';
import 'package:staff_client_side/features/coachingManager/screens/timeTable/timeTable.dart';
import 'package:staff_client_side/features/home/screens/bottomNavigation.dart';
import 'package:staff_client_side/features/navigation/screens/navigation.dart';
import 'package:staff_client_side/features/notification/screens/notification.dart';
import 'package:staff_client_side/features/profile/screens/profile.dart';
import 'package:staff_client_side/features/tutionCenter/screens/listtutioncenterInfo.dart';
import 'package:staff_client_side/features/tutionCenter/screens/tutioncenter.dart';
import 'package:staff_client_side/firebase_options.dart';
import 'package:staff_client_side/routes/routes.dart';

extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await SharedPrefs().init();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');
  runApp(MyApp(
    isLoggedIn: isLoggedIn!,
    savedThemeMode: savedThemeMode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.savedThemeMode,
    required this.isLoggedIn,
  });
  final AdaptiveThemeMode? savedThemeMode;
  final bool isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String initialRoute = isLoggedIn ? '/bottom' : '/login';
    return OverlaySupport(
      child: AdaptiveTheme(
        light: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: MyColors.primaryColor),
        dark: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: MyColors.primaryColor),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          //title: 'Adaptive Theme Demo',
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginPage(
                  number: '',
                ),
            MyRoutes.login: (context) => const LoginPage(
                  number: '',
                ),
            MyRoutes.bottom: (context) => const BottomNavigationPage(),
            MyRoutes.addCenter: (context) => const AddTutionCenterPage(),
            MyRoutes.centerInfo: (context) => const TrainingCenterInfo(),
            MyRoutes.navigation: (context) => const NavigationPage(),
            MyRoutes.notification: (context) => const NotificationPage(),
            MyRoutes.profile: (context) => const ProfilePage(),
            MyRoutes.addStaff: (context) => const AddStaffPage(),
            MyRoutes.listAllStaffs: (context) => const AllStaffListPage(),
            MyRoutes.classShedule: (context) => const TrainingShedulePage(
                  subjectStatus: true,
                  batchStatus: false,
                  classStatus: false,
                ),
            MyRoutes.timeTable: (context) => const TimeTablePage(selectedDay: 'mon',)
          },
        ),
      ),
    );
  }
}
