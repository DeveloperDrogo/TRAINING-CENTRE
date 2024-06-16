part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

sealed class OtpActionState extends OtpState{}

final class OtpInitial extends OtpState {}

final class OtpLoadState extends OtpState{}

final class OtpWrongAlertState extends OtpActionState{}

final class OtpGetSuccessState extends OtpActionState{}

final class BackToLoginPageState extends OtpActionState{}