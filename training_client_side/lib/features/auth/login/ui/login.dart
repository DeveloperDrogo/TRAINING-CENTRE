import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      'assets/images/bg3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 40),
                      child: Text("Staff Login",
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
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 8),
                          child: Text(
                            'Hi,Im waiting for you,please enter your number .',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontFamily: 'Lato',
                                    // color: Color(0xff495F81),
                                    color: Color.fromARGB(255, 159, 159, 159),
                                    fontSize: 15)),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, bottom: 0, right: 0),
                    child: IntlPhoneField(
                      controller: mobileNumber,
                      flagsButtonPadding: const EdgeInsets.only(left: 5),
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(18),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter your mobile number",
                        hintStyle: GoogleFonts.lato(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0.7,
                              color: Color.fromARGB(
                                  255, 193, 194, 195)), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0.8,
                              color: Color.fromARGB(255, 193, 194, 195)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0.5, color: Colors.red), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.2, color: Colors.red), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: double
                        .infinity, // Set width to take up the entire screen width
                    child: ElevatedButton(
                      onPressed: () {
                        // loginBloc.add(OnclickEvent());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 69, 100, 146),
                         // backgroundColor: const Color.fromARGB(255, 69, 160, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)) // Set the button's background color to green
                          ),
                      child: Row(
                        children: [
                          Text('GENERATE OTP',
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
