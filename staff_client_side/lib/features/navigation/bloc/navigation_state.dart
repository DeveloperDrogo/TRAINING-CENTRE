part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

sealed class NavigationActionState extends NavigationState{}

final class NavigationInitial extends NavigationState {}

final class NavigationLoadState extends NavigationState{}

final class ListMenuState extends NavigationState {
  final List<DashboardMenu> menuList;

  ListMenuState({required this.menuList});
}

final class BackToBottomPageState extends NavigationActionState{}

final class NavigateToProfilePageState extends NavigationActionState{}

final class NavigateToLoginPageState extends NavigationActionState{}

final class NavigateToLoginPage extends NavigationActionState{}