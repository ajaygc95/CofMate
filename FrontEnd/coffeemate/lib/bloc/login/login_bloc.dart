import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  final AuthRepository _authRepository = AuthRepository();
  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final token = await _authRepository.authenticate(
          username: event.username, password: event.password);
      await _authRepository.persistToken(token: token);
      final profileExists =
          await _authRepository.checkProfileExistence(token: token);
      emit(LoginSuccess(token: token, hasProfile: profileExists));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
