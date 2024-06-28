import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coaching_manager_event.dart';
part 'coaching_manager_state.dart';

class CoachingManagerBloc extends Bloc<CoachingManagerEvent, CoachingManagerState> {
  CoachingManagerBloc() : super(CoachingManagerInitial()) {
    on<CoachingManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
