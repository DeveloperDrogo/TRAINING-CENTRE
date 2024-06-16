part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class OtpButtonOnPressedEvent extends OtpEvent{}

class OtpInitialScreenEvent extends OtpEvent{}

class BackToLoginPage extends OtpEvent{}