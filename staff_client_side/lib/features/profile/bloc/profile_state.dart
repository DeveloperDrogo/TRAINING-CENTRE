part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

sealed class ProfileActionState extends ProfileState{}

final class ProfileInitial extends ProfileState {}

final class UpdateSuccess extends ProfileActionState{}

final class UpdateSuccessNavigate extends ProfileActionState{}

final class UpdateFailed extends ProfileActionState{}

final class NavigateToDahsboardPage extends ProfileActionState{}

final class UpdateLoading extends ProfileActionState{}