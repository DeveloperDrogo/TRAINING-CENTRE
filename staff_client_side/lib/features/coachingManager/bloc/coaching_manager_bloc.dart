import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/coachingManager/model/staffListModel.dart';
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
    final List listAllStaffs = await ManagerRepo.listStaffs();
    final List listAllSubjects = await ManagerRepo.listAllSubjects();
    final List batchTime = await ManagerRepo.listBatchTimings();
  }

  FutureOr<void> onClickStaffDeleteEvent(
      OnClickStaffDeleteEvent event, Emitter<CoachingManagerState> emit) {
        emit(AskPermissionforDeleteStaffState());
      }
}
