import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/auth/otp/screens/otp.dart';
import 'package:staff_client_side/features/auth/login/repo/loginRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonOnPressed>(loginButtonOnPressed);
    on<LoginInitialPage>(loginInitialPage);
  }

  Future<void> loginButtonOnPressed(
      LoginButtonOnPressed event, Emitter<LoginState> emit) async {
    emit(LoginPageLoadState());
    final bool success =
        await LoginRepo.checkMNumberIsExist(mobile: event.mblNumber);

    if (success) {
      final completer = Completer<void>();

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.completeNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle automatic code verification (if needed)
          if (!completer.isCompleted) completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!completer.isCompleted) completer.complete();
          emit(OtpErrorState(mobile: event.mblNumber));
          emit(LoginInitialState());
        },
        codeSent: (String verificationId, int? resendToken) {
          OtpPage.verifyId = verificationId;
          if (!completer.isCompleted) completer.complete();
          emit(NumberIsExistState());
          
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) completer.complete();
        },
      );

      await completer.future;
    } else {
      emit(NumberIsNotExistState());
      emit(LoginInitialState());
    }
  }

  FutureOr<void> loginInitialPage(
      LoginInitialPage event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }
}
