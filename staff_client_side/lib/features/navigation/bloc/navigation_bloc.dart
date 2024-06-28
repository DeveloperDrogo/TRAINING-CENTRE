import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/home/model/dashboardModel.dart';
import 'package:staff_client_side/features/home/repo/homeRepo.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<ListMenu>(listMenu);
    on<BackToBottomPageEvent>(backToBottomPageEvent);
    on<NavigateToProfilePageEvent>(navigateToProfilePageEvent);
    on<NavigateToLogoutEvent>(navigateToLogoutEvent);
    on<BackToLoginPage>(backToLoginPage);
  }

  FutureOr<void> listMenu(ListMenu event, Emitter<NavigationState> emit) async {
    emit(NavigationLoadState());
    final List<DashboardMenu> menuLists = await HomeRepo.dashboardMenu();
    emit(ListMenuState(menuList: menuLists));
  }

  FutureOr<void> backToBottomPageEvent(
      BackToBottomPageEvent event, Emitter<NavigationState> emit) {
    emit(BackToBottomPageState());
  }

  FutureOr<void> navigateToProfilePageEvent(
      NavigateToProfilePageEvent event, Emitter<NavigationState> emit) {
    emit(NavigateToProfilePageState());
  }

  FutureOr<void> navigateToLogoutEvent(
      NavigateToLogoutEvent event, Emitter<NavigationState> emit) {
    emit(NavigateToLoginPageState());
  }

  FutureOr<void> backToLoginPage(
      BackToLoginPage event, Emitter<NavigationState> emit) {
        emit(NavigateToLoginPage());
      }
}
