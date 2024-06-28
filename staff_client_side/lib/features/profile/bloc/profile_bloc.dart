import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:staff_client_side/constant/sharedprefs.dart';
import 'package:staff_client_side/features/profile/repo/profilerepo.dart';
import 'package:staff_client_side/features/profile/screens/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfileEvent>(updateProfileEvent);
    on<BacktoDashboardPage>(backtoDashboardPage);
  }

  FutureOr<void> updateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateLoading());
    bool? success;
    if (ProfilePage.imageFile != null) {
      success = await ProfileRepo.updateUserWithDoc(
          empFace: ProfilePage.imageFile!,
          empCode: SharedPrefs().id,
          name: event.name,
          dob: event.dob,
          email: event.email,
          gender: event.gender,
          blood: event.blood,
          address: event.address,
          qualification: event.qualification,
          workExperience: event.workExperience,
          govermentID: event.governmentId);
    } else {
      success = await ProfileRepo.updateUserWithoutDoc(
          name: event.name,
          dob: event.dob,
          email: event.email,
          gender: event.gender,
          blood: event.blood,
          address: event.address,
          qualification: event.qualification,
          workExperience: event.workExperience,
          govermentID: event.governmentId);
    }

    if (success!) {
      emit(UpdateSuccess());
      emit(UpdateSuccessNavigate());
    } else {
      emit(UpdateFailed());
      emit(UpdateSuccessNavigate());
    }
  }

  FutureOr<void> backtoDashboardPage(
      BacktoDashboardPage event, Emitter<ProfileState> emit) {
    emit(NavigateToDahsboardPage());
  }
}
