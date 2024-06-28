import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:staff_client_side/features/home/screens/bottomNavigation.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? const Color.fromARGB(255, 56, 56, 56)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark
            ? const Color.fromARGB(255, 56, 56, 56)
            : Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Notification",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  color: AdaptiveTheme.of(context).mode.isDark
                      ? Colors.white
                      : Colors.black,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold),
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationPage()));
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AdaptiveTheme.of(context).mode.isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage(
                    //         'assets/images/nonoti.jpg'))
                    ),
                child: Lottie.asset('assets/lottie/notification.json'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "No Notification",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("No notification found at the moment.",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500),
                )),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
