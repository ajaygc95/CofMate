import 'package:bloc/bloc.dart';
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
    try {
      final token = await _authRepository.authenticate(
          username: event.username, password: event.password);
      print("Inside bloc token received");
      await _authRepository.persistToken(token: token);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
