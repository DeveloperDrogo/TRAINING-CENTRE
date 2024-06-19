part of 'tution_center_bloc.dart';

@immutable
sealed class TutionCenterEvent {}

class BackToBottomPage extends TutionCenterEvent {}

class ErrorWithoutAddingMangerInfoEvent extends TutionCenterEvent {}

class OnSubmitTrainingCenterEvent extends TutionCenterEvent {
  final String trainingCenterName;
  final String trainingCenterAddress;
  final String trainingCenterSubscriptionAmount;
  final String managerName;
  final String managerContact;
  final String managerEmail;
  final String managerAddress;

  OnSubmitTrainingCenterEvent(
      {required this.trainingCenterName,
      required this.trainingCenterAddress,
      required this.trainingCenterSubscriptionAmount,
      required this.managerName,
      required this.managerContact,
      required this.managerEmail,
      required this.managerAddress});
}

final class ListAllTrainingCentersEvent extends TutionCenterEvent{}