
import 'package:fetch_api_with_bloc/bloc/user_event.dart';
import 'package:fetch_api_with_bloc/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/user_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}