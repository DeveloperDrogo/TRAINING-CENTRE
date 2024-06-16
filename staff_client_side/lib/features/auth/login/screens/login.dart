import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:staff_client_side/colors/colors.dart';
import 'package:staff_client_side/features/auth/login/bloc/login_bloc.dart';
import 'package:staff_client_side/features/auth/otp/screens/otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.number});
  final String number;

  static String ?completeNumber;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    mobileNumber.text=widget.number;
    loginBloc.add(LoginInitialPage());
    onlyNumber=widget.number!=''?widget.number:'';
    completeNumber=LoginPage.completeNumber;
    super.initState();
  }

  TextEditingController mobileNumber = TextEditingController();

  LoginBloc loginBloc = LoginBloc();

  String? onlyNumber;
  String? completeNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is NumberIsExistState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  OtpPage(mobileNumber:onlyNumber!,),
              ));
        } else if (state is NumberIsNotExistState) {
          final snackBar = SnackBar(
            /// need to set following properties for best effect of awesome_snackbar_content
            elevation: 0,
            behavior: SnackBarBehavior.floating,

            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Failed',
              message:
                  'Invalid number or If the issue persists, contact your institution for further assistance.',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else if (state is OtpErrorState) {
          final successState = state;
          QuickAlert.show(
            barrierDismissible: false,
            context: context,
            confirmBtnColor: Colors.red,
            confirmBtnText: "Ok",
            onConfirmBtnTap: () {
              //  loginBloc.add(OtpErrorClick());
            },
            type: QuickAlertType.error,
            title: 'Oops...',
            text:
                'The OTP was not sent to your number (${successState.mobile}). Please try again after some time.!!!',
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginPageLoadState:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          case LoginInitialState:
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
                              'assets/images/bg_check.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 40),
                              child: Text("Staff Login",
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          fontFamily: 'Lato',
                                          // color: Color(0xff495F81),
                                          color:
                                              Color.fromARGB(255, 43, 43, 43),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600))),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 8),
                                  child: Text(
                                    'Hi,Im waiting for you,please enter your number .',
                                    style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            fontFamily: 'Lato',
                                            // color: Color(0xff495F81),
                                            color: Color.fromARGB(
                                                255, 159, 159, 159),
                                            fontSize: 15)),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 0, right: 0),
                            child: IntlPhoneField(
                              controller: mobileNumber,
                              flagsButtonPadding:
                                  const EdgeInsets.only(left: 5),
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
                                      color:
                                          Color.fromARGB(255, 193, 194, 195)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1.2,
                                      color: Colors.red), //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                setState(() {
                                  onlyNumber = phone.number;
                                  completeNumber = phone.completeNumber;
                                  LoginPage.completeNumber=phone.completeNumber;
                                  
                                });
                              },
                            ),
                          ),
                        ),
                        mobileNumber.text.length < 10
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SizedBox(
                                  height: 50,
                                  width: double
                                      .infinity, // Set width to take up the entire screen width
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
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
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SizedBox(
                                  height: 50,
                                  width: double
                                      .infinity, // Set width to take up the entire screen width
                                  child: ElevatedButton(
                                    onPressed: () {
                                      loginBloc.add(LoginButtonOnPressed(
                                          mblNumber: onlyNumber!,
                                          completeNumber: completeNumber!));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.primaryColor,
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

          default:
            return const SizedBox();
        }
      },
    );
  }
}
