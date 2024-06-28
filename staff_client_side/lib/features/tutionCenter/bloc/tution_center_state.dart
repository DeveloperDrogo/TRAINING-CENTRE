part of 'tution_center_bloc.dart';

@immutable
sealed class TutionCenterState {}

sealed class TutionActionCenterState extends TutionCenterState{}

final class TutionCenterInitial extends TutionCenterState {}

final class BackToBottomPageState extends TutionActionCenterState{}

final class ErrorWithoutAddingMangerInfoState extends TutionActionCenterState{}

final class TrainingCenterSuccessInsertState extends TutionActionCenterState{}

final class TrainingCenterFailedInsertState extends TutionActionCenterState{}

final class TrainingCenterLoadingState extends TutionActionCenterState{}

final class ListAllTrainingCentersState extends TutionCenterState{
  final List<TrainingCenterListModel> trainingCenters;

  ListAllTrainingCentersState({required this.trainingCenters});
}

final class ListTrainingCenterLoadState extends TutionCenterState{}

final class TrainingCenterSuccessUpdateState extends TutionActionCenterState{}

final class TrainingCenterFailedUpdateState extends TutionActionCenterState{}