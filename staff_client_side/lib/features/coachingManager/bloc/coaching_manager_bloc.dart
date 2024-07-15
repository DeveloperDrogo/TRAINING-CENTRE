import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/coachingManager/model/batchListModel.dart';
import 'package:staff_client_side/features/coachingManager/model/classRoomModel.dart';
import 'package:staff_client_side/features/coachingManager/model/staffListModel.dart';
import 'package:staff_client_side/features/coachingManager/model/subjectListModel.dart';
import 'package:staff_client_side/features/coachingManager/model/timeTableModel.dart';
import 'package:staff_client_side/features/coachingManager/repo/managerRepo.dart';

part 'coaching_manager_event.dart';
part 'coaching_manager_state.dart';

class CoachingManagerBloc
    extends Bloc<CoachingManagerEvent, CoachingManagerState> {
  CoachingManagerBloc() : super(CoachingManagerInitial()) {
    on<CoachingInitialEvent>(coachingInitialEvent);
    on<BacktoDashboardPage>(backtoDashboardPage);
    on<OnClickAddStaffEvent>(onClickAddStaffEvent);
    on<ListAllStaffEvent>(listAllStaffEvent);
    on<NavigateToAddStaff>(navigateToAddStaff);
    on<NavigateToStaffsList>(navigateToStaffsList);
    on<OnClickEditStaffEvent>(onClickEditStaffEvent);
    on<CreateClassSheduleEvent>(createClassSheduleEvent);
    on<OnClickStaffDeleteEvent>(onClickStaffDeleteEvent);
    on<OnClickCreateClassSheduleEvent>(onClickCreateClassSheduleEvent);
    on<OnClickAddSubjectEvent>(onClickAddSubjectEvent);
    on<InsertSubjectEvent>(insertSubjectEvent);
    on<InsertBatchEvent>(insertBatchEvent);
    on<OnclickAddClassroomEvent>(onclickAddClassroomEvent);
    on<InsertClassRoomEvent>(insertClassRoomEvent);
    on<OnClickDeleteActionEvent>(onClickDeleteActionEvent);
    on<DeleteEventActionEvent>(deleteEventActionEvent);
    on<CreateTimeTableEvent>(createTimeTableEvent);
    on<TimeTableFetchState>(timeTableFetchState);
  }

  FutureOr<void> coachingInitialEvent(
      CoachingInitialEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingLoaderState());
    final List roles = await ManagerRepo.listAllRoles();
    emit(CoachingMangerAddStaffState(roles: roles));
  }

  FutureOr<void> backtoDashboardPage(
      BacktoDashboardPage event, Emitter<CoachingManagerState> emit) {
    emit(BackToDashboardPageState());
  }

  FutureOr<void> onClickAddStaffEvent(
      OnClickAddStaffEvent event, Emitter<CoachingManagerState> emit) async {
    emit(AddStaffLoadState());
    final bool success = await ManagerRepo.insertStaffDetails(
        name: event.name,
        contact: event.contact,
        dob: event.dob,
        email: event.email,
        gender: event.gender,
        roleId: event.roleid,
        blood: event.blood,
        address: event.address,
        qualification: event.qualification,
        workExperience: event.workExperience,
        govermentID: event.governmentId);

    if (success) {
      emit(AddStaffSuccessState());
    } else {
      emit(AddStaffFailedState());
    }
  }

  FutureOr<void> listAllStaffEvent(
      ListAllStaffEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingLoaderState());
    final List<StaffListModel> staffList = await ManagerRepo.listAllStaffs();
    emit(ListAllStaffsState(staffList: staffList));
  }

  FutureOr<void> navigateToAddStaff(
      NavigateToAddStaff event, Emitter<CoachingManagerState> emit) {
    emit(NavigateToAddStaffPageState());
  }

  FutureOr<void> navigateToStaffsList(
      NavigateToStaffsList event, Emitter<CoachingManagerState> emit) {
    emit(NavigateToStaffListState());
  }

  FutureOr<void> onClickEditStaffEvent(
      OnClickEditStaffEvent event, Emitter<CoachingManagerState> emit) async {
    final success = await ManagerRepo.updateStaffDetails(
        userId: event.userId,
        staffId: event.staffId,
        name: event.name,
        contact: event.contact,
        dob: event.dob,
        email: event.email,
        gender: event.gender,
        roleId: event.roleid,
        blood: event.blood,
        address: event.address,
        qualification: event.qualification,
        workExperience: event.workExperience,
        govermentID: event.governmentId);

    if (success) {
      emit(UpdateStaffSuccessState());
    } else {
      emit(UpdateStaffFailedState());
    }
  }

  FutureOr<void> createClassSheduleEvent(
      CreateClassSheduleEvent event, Emitter<CoachingManagerState> emit) async {
    emit(ClassSheduleLoader());
    final List<SubjectListModel> listAllSubjects =
        await ManagerRepo.listAllSubjects();
    final List<BatchListModel> batchTime = await ManagerRepo.listBatchTimings();
    final List<ClassRoomModel> classrooms = await ManagerRepo.listClassrooms();

    emit(CreateClassSheduleState(
        batchTimeList: batchTime,
        subjectList: listAllSubjects,
        classrooms: classrooms));
  }

  FutureOr<void> onClickStaffDeleteEvent(
      OnClickStaffDeleteEvent event, Emitter<CoachingManagerState> emit) {
    emit(AskPermissionforDeleteStaffState());
  }

  FutureOr<void> onClickCreateClassSheduleEvent(
      OnClickCreateClassSheduleEvent event,
      Emitter<CoachingManagerState> emit) async {
    emit(CoachingManagerActionLoader());
    final bool success = await ManagerRepo.insertClassShedule(
        staffId: event.staffId,
        subjectId: event.subjectId,
        day: event.day,
        batchId: event.batchId,
        classId: event.classRoomId);

    if (success) {
      emit(ClassSheduleInsertedSuccessState());
    } else {
      emit(ClassSheduleInsertedFailedState());
    }
  }

  FutureOr<void> onClickAddSubjectEvent(
      OnClickAddSubjectEvent event, Emitter<CoachingManagerState> emit) {
    emit(AddSubjectDialougeBoxState());
  }

  FutureOr<void> insertSubjectEvent(
      InsertSubjectEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingManagerActionLoader());
    final bool success =
        await ManagerRepo.insertSubject(subjectName: event.subjectName);
    if (success) {
      emit(ClassSheduleSuccessState(
          subjectStatus: true,
          batchStatus: false,
          classStatus: false,
          description: "The subject has been successfully added."));
    } else {
      emit(ClassSheduleSuccessState(
          subjectStatus: true,
          batchStatus: false,
          classStatus: false,
          description: "Failed to add the subject."));
    }
  }

  FutureOr<void> insertBatchEvent(
      InsertBatchEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingManagerActionLoader());
    final bool success = await ManagerRepo.insertBatch(batch: event.batchTime);
    if (success) {
      emit(ClassSheduleSuccessState(
          subjectStatus: false,
          batchStatus: true,
          classStatus: false,
          description: "The batch has been successfully added."));
    } else {
      emit(ClassSheduleSuccessState(
          subjectStatus: false,
          batchStatus: true,
          classStatus: false,
          description: "Failed to add the batch."));
    }
  }

  FutureOr<void> onclickAddClassroomEvent(
      OnclickAddClassroomEvent event, Emitter<CoachingManagerState> emit) {
    emit(AddClassRoomDialougeBoxState());
  }

  FutureOr<void> insertClassRoomEvent(
      InsertClassRoomEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingManagerActionLoader());
    final bool success =
        await ManagerRepo.insertclassRoom(classRoom: event.classRoom);

    if (success) {
      emit(ClassSheduleSuccessState(
          subjectStatus: false,
          batchStatus: false,
          classStatus: true,
          description: "The classroom has been successfully added."));
    } else {
      emit(ClassSheduleSuccessState(
          subjectStatus: false,
          batchStatus: false,
          classStatus: true,
          description: "Failed to add the classroom."));
    }
  }

  FutureOr<void> onClickDeleteActionEvent(
      OnClickDeleteActionEvent event, Emitter<CoachingManagerState> emit) {
    emit(OnclickDeleteActionState(
        description: event.description,
        value: event.value,
        id: event.id,
        type: event.type));
  }

  FutureOr<void> deleteEventActionEvent(
      DeleteEventActionEvent event, Emitter<CoachingManagerState> emit) async {
    emit(CoachingManagerActionLoader());

    if (event.type == 'BATCH') {
      final bool success = await ManagerRepo.deleteBatch(deleteId: event.id);
      if (success) {
        emit(ClassSheduleSuccessState(
            subjectStatus: false,
            batchStatus: true,
            classStatus: false,
            description: "The batch has been deleted successfully."));
      } else {
        emit(ClassSheduleSuccessState(
            subjectStatus: false,
            batchStatus: true,
            classStatus: false,
            description: "Failed to delete the batch."));
      }
    } else if (event.type == 'SUBJECT') {
      final bool success = await ManagerRepo.deleteSubject(deleteId: event.id);
      if (success) {
        emit(ClassSheduleSuccessState(
            subjectStatus: true,
            batchStatus: false,
            classStatus: false,
            description: "The subject has been deleted successfully."));
      } else {
        emit(ClassSheduleSuccessState(
            subjectStatus: true,
            batchStatus: false,
            classStatus: false,
            description: "Failed to delete the subject."));
      }
    } else if (event.type == 'CLASS') {
      final bool success =
          await ManagerRepo.deleteClassRoom(deleteId: event.id);
      if (success) {
        emit(ClassSheduleSuccessState(
            subjectStatus: false,
            batchStatus: false,
            classStatus: true,
            description: "The classroom has been deleted successfully."));
      } else {
        emit(ClassSheduleSuccessState(
            subjectStatus: false,
            batchStatus: false,
            classStatus: true,
            description: "Failed to delete the classroom."));
      }
    }
  }

  FutureOr<void> createTimeTableEvent(
      CreateTimeTableEvent event, Emitter<CoachingManagerState> emit) async {
    emit(ClassSheduleLoader());
    final List listAllStaffs = await ManagerRepo.listTimeTableStaffs();
    final List listAllSubjects = await ManagerRepo.listTimeTableSubjects();
    final List batchTime = await ManagerRepo.listTimeTableBatch();
    final List classrooms = await ManagerRepo.listTimeTableClassrooms();
    emit(CreateTimeTableState(
        batchTimeList: batchTime,
        subjectList: listAllSubjects,
        classrooms: classrooms,
        staffAllList: listAllStaffs));
  }

  FutureOr<void> timeTableFetchState(
      TimeTableFetchState event, Emitter<CoachingManagerState> emit) async{
        emit(CoachingLoaderState());
        final List<TimeTableModel> timetable = await ManagerRepo.fetchTimeTable();
       emit(TimeTableCompleteFetchSuccess(timetable: timetable));
      }
}
