import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/tutionCenter/model/trainingcenterModel.dart';
import 'package:staff_client_side/features/tutionCenter/repo/tutionRepo.dart';

part 'tution_center_event.dart';
part 'tution_center_state.dart';

class TutionCenterBloc extends Bloc<TutionCenterEvent, TutionCenterState> {
  TutionCenterBloc() : super(TutionCenterInitial()) {
    on<BackToBottomPage>(backToBottomPage);
    on<ErrorWithoutAddingMangerInfoEvent>(errorWithoutAddingMangerInfoEvent);
    on<OnSubmitTrainingCenterEvent>(onSubmitTrainingCenterEvent);
    on<ListAllTrainingCentersEvent>(listAllTrainingCentersEvent);
    on<OnUpdateButtonOnPressed>(onUpdateButtonOnPressed);
  }

  FutureOr<void> backToBottomPage(
      BackToBottomPage event, Emitter<TutionCenterState> emit) {
    emit(BackToBottomPageState());
  }

  FutureOr<void> errorWithoutAddingMangerInfoEvent(
      ErrorWithoutAddingMangerInfoEvent event,
      Emitter<TutionCenterState> emit) {
    emit(ErrorWithoutAddingMangerInfoState());
  }

  FutureOr<void> onSubmitTrainingCenterEvent(OnSubmitTrainingCenterEvent event,
      Emitter<TutionCenterState> emit) async {
    emit(TrainingCenterLoadingState());
    final bool success = await TutionCenterRepo.insertTrainingCenter(
        trainingCentername: event.trainingCenterName,
        trainingCenterAddress: event.trainingCenterAddress,
        trainingCenterSubscription: event.trainingCenterSubscriptionAmount,
        managerName: event.managerName,
        managerContact: event.managerContact,
        managerEmail: event.managerEmail,
        managerAddress: event.managerAddress);
    if (success) {
      emit(TrainingCenterSuccessInsertState());
    } else {
      emit(TrainingCenterFailedInsertState());
    }
  }

  FutureOr<void> listAllTrainingCentersEvent(ListAllTrainingCentersEvent event,
      Emitter<TutionCenterState> emit) async {
    emit(ListTrainingCenterLoadState());
    List<TrainingCenterListModel> trainingcenters =
        await TutionCenterRepo.listTrainingCenters();
    emit(ListAllTrainingCentersState(trainingCenters: trainingcenters));
  }

  FutureOr<void> onUpdateButtonOnPressed(
      OnUpdateButtonOnPressed event, Emitter<TutionCenterState> emit) async {
    emit(TrainingCenterLoadingState());
    final bool success = await TutionCenterRepo.updateTrainingCenterInfo(
        status: event.status,
        isActive: event.isActiveTrainingCenter,
        trainingCentername: event.trainingCenterName,
        trainingCenterAddress: event.trainingCenterAddress,
        trainingCenterSubscription: event.trainingCenterSubscriptionAmount,
        managerName: event.managerName,
        managerContact: event.managerContact,
        managerEmail: event.managerEmail,
        trainingcenterId: event.trainingCenterId,
        mangerUserId: event.managerUserId,
        managerAddress: event.managerAddress,
        isSubscribed: event.issubscribed);
    if (success) {
      emit(TrainingCenterSuccessUpdateState());
    } else {
      emit(TrainingCenterFailedUpdateState());
    }
  }
}
