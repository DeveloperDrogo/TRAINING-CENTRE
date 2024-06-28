part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class ListMenu extends NavigationEvent{}

class BackToBottomPageEvent extends NavigationEvent{}

class NavigateToProfilePageEvent extends NavigationEvent{}

final class NavigateToLogoutEvent extends NavigationEvent{}

final class BackToLoginPage extends NavigationEvent{}