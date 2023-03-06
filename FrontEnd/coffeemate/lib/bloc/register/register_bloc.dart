import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coffeemate/constants/api.dart';
import 'package:coffeemate/models/register_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Register register = Register();
  RegisterBloc() : super(RegisterInitial()) {
    on<UpdateRegisterEvent>(onRegisterUpdate);
    on<SubmitRegisterEvent>(onSubmitRegister);
  }

  void onRegisterUpdate(RegisterEvent event, Emitter<RegisterState> emit) {
    if (event is UpdateRegisterEvent) {
      if (event.label == 'username') {
        register = register.copyWith(username: event.value);
      } else if (event.label == "email") {
        register = register.copyWith(email: event.value);
      } else if (event.label == "password") {
        register = register.copyWith(password: event.value);
      } else if (event.label == "password2") {
        register = register.copyWith(password2: event.value);
      } else if (event.label == "phoneNumber") {
        register = register.copyWith(phoneNumber: event.value);
      }
    }
    emit(UpdateRegisterState(register: register));
  }

  void onSubmitRegister(
      RegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      emit(SubmittingRegisterState());
      final registerJson = jsonEncode(register); // encode register as JSON
      final response = await http.post(Uri.parse(registerApi),
          headers: {'Content-Type': 'application/json'}, body: registerJson);
      print("++++++++++++++++++++ THIS IS ${response.body}");
      if (response.statusCode == 200) {
      } else {
        print("======== Error Message =============");
        print(response.body);
        emit(RegisterError(
            errorMessage: "Registration failed: ${response.body}"));
      }
      emit(CompleteRegisterState());
    } catch (error) {
      emit(RegisterError(errorMessage: "Registration failed: $error"));
    }
  }
}
