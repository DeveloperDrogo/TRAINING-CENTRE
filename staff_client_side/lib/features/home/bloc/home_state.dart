part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState{}

final class HomeLoadState extends HomeState{}

final class HomeInitial extends HomeState {}

final class DashboardMenuListState extends HomeState{
  final List<DashboardMenu> dashboardMenuList;

  DashboardMenuListState({required this.dashboardMenuList});
}

