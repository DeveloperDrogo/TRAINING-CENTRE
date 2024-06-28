// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/features/home/model/dashboardModel.dart';
import 'package:staff_client_side/features/home/repo/homeRepo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<NavigateToNavigationPage>(navigateToNavigationPage);
    on<NavigateToNotificationPage>(navigateToNotificationPage);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadState());
    final List<DashboardMenu> dashboard = await HomeRepo.dashboardMenu();
    emit(DashboardMenuListState(dashboardMenuList: dashboard));
  }

  FutureOr<void> navigateToNavigationPage(
      NavigateToNavigationPage event, Emitter<HomeState> emit) {
    emit(NavigationPageState());
  }

  FutureOr<void> navigateToNotificationPage(
      NavigateToNotificationPage event, Emitter<HomeState> emit) {
        emit(NavigationToNotificationState());
      }
}
