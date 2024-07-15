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

final class ListAllStaffsState extends CoachingManagerState {
  final List<StaffListModel> staffList;

  ListAllStaffsState({required this.staffList});
}

final class NavigateToAddStaffPageState extends CoachingManagerActionState {}

final class NavigateToStaffListState extends CoachingManagerActionState {}

final class UpdateStaffSuccessState extends CoachingManagerActionState {}

final class UpdateStaffFailedState extends CoachingManagerActionState {}

final class AskPermissionforDeleteStaffState
    extends CoachingManagerActionState {}

final class CreateClassSheduleState extends CoachingManagerState {
  final List<BatchListModel> batchTimeList;
  final List<SubjectListModel> subjectList;
  final List<ClassRoomModel> classrooms;

  CreateClassSheduleState({
    required this.batchTimeList,
    required this.subjectList,
    required this.classrooms,
  });
}

final class ClassSheduleLoader extends CoachingManagerState {}

final class CoachingManagerActionLoader extends CoachingManagerActionState {}

final class ClassSheduleInsertedSuccessState
    extends CoachingManagerActionState {}

final class ClassSheduleInsertedFailedState
    extends CoachingManagerActionState {}

final class AddSubjectDialougeBoxState extends CoachingManagerActionState {}

final class ClassSheduleSuccessState extends CoachingManagerActionState {
  final String description;
  final bool subjectStatus;
  final bool batchStatus;
  final bool classStatus;

  ClassSheduleSuccessState({
    required this.description,
    required this.subjectStatus,
    required this.batchStatus,
    required this.classStatus,
  });
}

final class ClassSheduleFailedState extends CoachingManagerActionState {
  final String description;
  final bool subjectStatus;
  final bool batchStatus;
  final bool classStatus;

  ClassSheduleFailedState({
    required this.description,
    required this.subjectStatus,
    required this.batchStatus,
    required this.classStatus,
  });
}

final class AddClassRoomDialougeBoxState extends CoachingManagerActionState {}

final class OnclickDeleteActionState extends CoachingManagerActionState {
  final String description;
  final String value;
  final String type;
  final String id;

  OnclickDeleteActionState(
      {required this.description,
      required this.value,
      required this.type,
      required this.id});
}

final class CreateTimeTableState extends CoachingManagerState {
  final List staffAllList;
  final List batchTimeList;
  final List subjectList;
  final List classrooms;

  CreateTimeTableState({
    required this.batchTimeList,
    required this.subjectList,
    required this.classrooms,
    required this.staffAllList
  });
}

final class TimeTableCompleteFetchSuccess extends  CoachingManagerState{
   final List<TimeTableModel> timetable;

  TimeTableCompleteFetchSuccess({required this.timetable});
}

