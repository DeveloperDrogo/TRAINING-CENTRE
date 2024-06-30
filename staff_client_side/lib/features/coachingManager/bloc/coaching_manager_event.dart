part of 'coaching_manager_bloc.dart';

@immutable
sealed class CoachingManagerEvent {}

class CoachingInitialEvent extends CoachingManagerEvent {}

final class BacktoDashboardPage extends CoachingInitialEvent {}

final class OnClickAddStaffEvent extends CoachingManagerEvent {
  final String name;
  final String dob;
  final String email;
  final String gender;
  final String blood;
  final String address;
  final String qualification;
  final String workExperience;
  final String governmentId;
  final String contact;
  final String roleid;

  OnClickAddStaffEvent(
      {required this.name,
      required this.dob,
      required this.email,
      required this.gender,
      required this.blood,
      required this.address,
      required this.qualification,
      required this.workExperience,
      required this.governmentId,
      required this.contact,
      required this.roleid});
}

class ListAllStaffEvent extends CoachingManagerEvent{}

class NavigateToAddStaff extends CoachingManagerEvent{}

class NavigateToStaffsList extends CoachingManagerEvent{}
