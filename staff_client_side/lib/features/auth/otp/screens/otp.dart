import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:staff_client_side/features/auth/login/screens/login.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  static String? verifyId;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _seconds = 30;
  Timer? _timer;
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_seconds == 0) {
            timer.cancel();
          } else {
            _seconds--;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 54,
      height: 54,
      textStyle: const TextStyle(
          fontSize: 20,
          //color: Color(0xff597AAB),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 192, 192, 193)),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      //color: Colors.white,
      border: Border.all(color: const Color.fromARGB(255, 45, 78, 107)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          // color: const Color.fromARGB(255, 252, 254, 255),
          ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 380,
                  width: MediaQuery.of(context).size.width,
                  child: Opacity(
                    opacity: 1,
                    child: Image.asset(
                      'assets/images/bglast.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: Text("OTP",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontFamily: 'Lato',
                                  // color: Color(0xff495F81),
                                  color: Color.fromARGB(255, 43, 43, 43),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600))),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 0, top: 8),
                  child: Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Enter the OTP sent to  ",
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                color: Color.fromARGB(255, 150, 150, 150),
                              ),
                              children: [
                            TextSpan(
                                text: LoginPage.completeNumber,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600))
                          ]))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 20),
                  child: Pinput(
                    //controller: OtpPage.pinController,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,

                    showCursor: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter OTP";
                      }
                      return null;
                    },
                    // ignore: avoid_print
                    onCompleted: (pin) {
                      // otpBloc.add(OtpButtonOnPressed());
                    },
                    onChanged: (value) {
                      // OtpPage.code = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: double
                        .infinity, // Set width to take up the entire screen width
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 59, 97, 168),
                          // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)) // Set the button's background color to green
                          ),
                      child: Row(
                        children: [
                          Text('CONTINUE',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      'Lato', // Set the text color to white
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          const Spacer(),
                          SizedBox(
                            height: 20,
                            child: Lottie.asset(
                              'assets/lottie/right.json',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                _seconds != 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Send OTP again in ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 150, 150, 150),
                                  ),
                                ),
                                TextSpan(
                                  text: '00.$_seconds',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:  Color.fromARGB(255, 59, 97, 168),
                                  ),
                                ),
                                const TextSpan(
                                  text: ' sec',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 150, 150, 150),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn't receive the OTP ?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 150, 150, 150),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  //otpBloc.add(ResendOtp());
                                },
                                child: const Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color:  Color.fromARGB(255, 59, 97, 168),
                                  ),
                                ))
                          ],
                        ),
                      ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 56,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'MANOMAY TRAINING \nCENTRE',
                  style: GoogleFonts.fingerPaint(
                      height: 1.7,
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
