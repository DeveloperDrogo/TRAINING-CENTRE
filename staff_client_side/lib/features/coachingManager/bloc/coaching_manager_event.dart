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

class ListAllStaffEvent extends CoachingManagerEvent {}

class NavigateToAddStaff extends CoachingManagerEvent {}

class NavigateToStaffsList extends CoachingManagerEvent {}

final class OnClickEditStaffEvent extends CoachingManagerEvent {
  final String userId;
  final String staffId;
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
  final String roleName;

  OnClickEditStaffEvent(
      {required this.userId,
      required this.staffId,
      required this.name,
      required this.dob,
      required this.email,
      required this.gender,
      required this.blood,
      required this.address,
      required this.qualification,
      required this.workExperience,
      required this.governmentId,
      required this.contact,
      required this.roleid,
      required this.roleName});
}

class OnClickStaffDeleteEvent extends CoachingManagerEvent {}

class CreateClassSheduleEvent extends CoachingManagerEvent {}

class OnClickCreateClassSheduleEvent extends CoachingManagerEvent {
  final String staffId;
  final String subjectId;
  final String batchId;
  final String classRoomId;
  final String day;

  OnClickCreateClassSheduleEvent(
      {required this.staffId,
      required this.subjectId,
      required this.batchId,
      required this.classRoomId,required this.day});
}

class OnClickAddSubjectEvent extends CoachingManagerEvent {}

class OnclickAddClassroomEvent extends CoachingManagerEvent {}

class InsertSubjectEvent extends CoachingManagerEvent {
  final String subjectName;

  InsertSubjectEvent({required this.subjectName});
}

class InsertBatchEvent extends CoachingManagerEvent {
  final String batchTime;

  InsertBatchEvent({required this.batchTime});
}

class InsertClassRoomEvent extends CoachingManagerEvent {
  final String classRoom;

  InsertClassRoomEvent({required this.classRoom});
}

final class OnClickDeleteActionEvent extends CoachingManagerEvent {
  final String description;
  final String value;
  final String type;
  final String id;

  OnClickDeleteActionEvent(
      {required this.type,
      required this.description,
      required this.value,
      required this.id});
}

final class DeleteEventActionEvent extends CoachingManagerEvent {
  final String type;
  final String id;

  DeleteEventActionEvent({required this.type, required this.id});
}

final class CreateTimeTableEvent extends CoachingManagerEvent{
  
}

final class AddTimeTableEvent extends CoachingManagerEvent{
  
}

final class TimeTableFetchState extends CoachingManagerEvent{}