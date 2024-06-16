import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff_client_side/features/auth/otp/screens/otp.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  OtpBloc() : super(OtpInitial()) {
    on<OtpButtonOnPressedEvent>(otpButtonOnPressedEvent);
    on<OtpInitialScreenEvent>(otpInitialScreenEvent);
    on<BackToLoginPage>(backToLoginPage);
  }

  FutureOr<void> otpButtonOnPressedEvent(
      OtpButtonOnPressedEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadState());
  
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: OtpPage.verifyId!, smsCode: OtpPage.code!);
      await auth.signInWithCredential(credential);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      emit(OtpGetSuccessState());

      //print('yes pass');
    } catch (e) {
      emit(OtpInitial());
      emit(OtpWrongAlertState());
    }
  }

  FutureOr<void> otpInitialScreenEvent(
      OtpInitialScreenEvent event, Emitter<OtpState> emit) {
    emit(OtpInitial());
  }

  FutureOr<void> backToLoginPage(BackToLoginPage event, Emitter<OtpState> emit) {
    emit(BackToLoginPageState());
  }
}
