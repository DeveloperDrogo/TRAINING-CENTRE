part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginInitialPage extends LoginEvent{}

class LoginButtonOnPressed extends LoginEvent {
  final String mblNumber;
  final String completeNumber;

  LoginButtonOnPressed({
    required this.mblNumber,
    required this.completeNumber,
  });
}
