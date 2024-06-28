part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class NavigateToNavigationPage extends HomeEvent{}

class NavigateToNotificationPage extends HomeEvent{}