part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

sealed class LoginActionState extends LoginState{}

final class LoginInitialState extends LoginState {}

final class NumberIsExistState extends LoginActionState{}

final class NumberIsNotExistState extends LoginActionState{}

final class OtpErrorState extends LoginActionState{
  final String mobile;

  OtpErrorState({required this.mobile});
}

final class LoginPageLoadState extends LoginState{}