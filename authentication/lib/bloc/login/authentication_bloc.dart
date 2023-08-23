import 'package:bloc/bloc.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_event.dart';
import 'package:diplomski_rad_user_module/bloc/login/authentication_state.dart';
import 'package:diplomski_rad_user_module/model/authentication_data.dart';
import 'package:diplomski_rad_user_module/network/rest.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<OnLoginButtonPressed>(_onLoginButtonPressed);
    on<OnRegisterButtonPressed>(_onRegisterButtonPressed);
  }

  Future<void> _onLoginButtonPressed(OnLoginButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationProcessRequest());
    try {
        AuthenticationData authData = await fetchUser(event.formModel);
        emit(AuthenticationSuccess(data: authData));
    } catch (e) {
      print(e);
      emit(AuthenticationFailure());
    }
  }

  Future<void> _onRegisterButtonPressed(OnRegisterButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationProcessRequest());
    try {
      AuthenticationData authenticationData = await registerUser(event.registerModel);
      emit(AuthenticationSuccess(data: authenticationData));
    } catch (e) {
      print(e);
      emit(AuthenticationFailure());
    }
  }
}





