import 'package:bloc/bloc.dart';
import 'package:diplomski_rad_user_module/exceptions/authentication_exception.dart';
import 'package:diplomski_rad_user_module/model/authentication_data.dart';
import 'package:diplomski_rad_user_module/model/login_form.dart';
import 'package:diplomski_rad_user_module/model/register_form.dart';
import 'package:diplomski_rad_user_module/network/rest.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/authentication_event.dart';
import '../login/authentication_state.dart';

abstract class IAuthenticationBloc implements StateStreamableSource<AuthenticationState>  {
  Future<void> onLoginButtonPressed(OnLoginButtonPressed event, Emitter<AuthenticationState> emit);
  Future<void> onRegisterButtonPressed(OnRegisterButtonPressed event, Emitter<AuthenticationState> emit);
}


class GoogleAuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> implements IAuthenticationBloc {
  GoogleSignIn google = GoogleSignIn();
  GoogleAuthenticationBloc(): super(AuthenticationInitial()) {
    on<OnLoginButtonPressed>(onLoginButtonPressed);
    on<OnRegisterButtonPressed>(onRegisterButtonPressed);
  }

  @override
  Future<void> onLoginButtonPressed(OnLoginButtonPressed event, Emitter<AuthenticationState> emit) async {
    try {
      GoogleSignInAccount? account = await google.signIn();
      if(account == null) {
        throw AuthenticationException(message: "Google auth failed");
      }
      print(account.email);
      LoginFormModel formModel = LoginFormModel(email: account.email, password: "password");
      AuthenticationData authData = await fetchUser(formModel);
      emit(AuthenticationSuccess(data: authData));
    } catch (e) {
      print(e);
      emit(AuthenticationFailure());
    }
  }

  @override
  Future<void> onRegisterButtonPressed(OnRegisterButtonPressed event, Emitter<AuthenticationState> emit) async {
   try {
     GoogleSignInAccount? account = await google.signIn();
     if(account == null) {
       throw new AuthenticationException(message: "Google auth failed");
     }
       RegisterFormModel formModel = RegisterFormModel(name: "Google", surname: "User", email: account.email, password: "password");
       AuthenticationData authData = await registerUser(formModel);
       emit(AuthenticationSuccess(data: authData));
   } catch (e) {
     print(e);
     emit(AuthenticationFailure());
   }
  }
}

class RestAPIAuthentication extends Bloc<AuthenticationEvent, AuthenticationState> implements IAuthenticationBloc {
  RestAPIAuthentication(): super(AuthenticationInitial()) {
    on<OnLoginButtonPressed>(onLoginButtonPressed);
    on<OnRegisterButtonPressed>(onRegisterButtonPressed);
  }
  @override
  Future<void> onLoginButtonPressed(OnLoginButtonPressed event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationProcessRequest());
    try {
      AuthenticationData authData = await fetchUser(event.formModel);
      emit(AuthenticationSuccess(data: authData));
    } catch (e) {
      print(e);
      emit(AuthenticationFailure());
    }
  }

  @override
  Future<void> onRegisterButtonPressed(OnRegisterButtonPressed event, Emitter<AuthenticationState> emit) async {
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
