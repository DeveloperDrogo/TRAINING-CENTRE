part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String dob;
  final String email;
  final String gender;
  final String blood;
  final String address;
  final String qualification;
  final String workExperience;
  final String governmentId;

  UpdateProfileEvent(
      {required this.name,
      required this.dob,
      required this.email,
      required this.gender,
      required this.blood,
      required this.address,
      required this.qualification,
      required this.workExperience,
      required this.governmentId});
}

final class BacktoDashboardPage extends ProfileEvent{}

