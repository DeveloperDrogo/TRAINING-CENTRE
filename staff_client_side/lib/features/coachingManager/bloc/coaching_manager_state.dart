part of 'coaching_manager_bloc.dart';

@immutable
sealed class CoachingManagerState {}

sealed class CoachingManagerActionState extends CoachingManagerState {}

final class CoachingManagerInitial extends CoachingManagerState {}

final class CoachingMangerAddStaffState extends CoachingManagerState {
  final List roles;

  CoachingMangerAddStaffState({required this.roles});
}

final class CoachingLoaderState extends CoachingManagerState {}

final class BackToDashboardPageState extends CoachingManagerActionState {}

final class AddStaffLoadState extends CoachingManagerActionState {}

final class AddStaffSuccessState extends CoachingManagerActionState {}

final class AddStaffFailedState extends CoachingManagerActionState {}

final class ListAllStaffsState extends CoachingManagerState{
 final List<StaffListModel> staffList;

  ListAllStaffsState({required this.staffList});
}

final class NavigateToAddStaffPageState extends CoachingManagerActionState{}

final class NavigateToStaffListState extends CoachingManagerActionState{}

final class UpdateStaffSuccessState extends CoachingManagerActionState {}

final class UpdateStaffFailedState extends CoachingManagerActionState {}

final class AskPermissionforDeleteStaffState extends CoachingManagerActionState{}