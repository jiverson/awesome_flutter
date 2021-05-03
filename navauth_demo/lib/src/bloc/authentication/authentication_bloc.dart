import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jiverson_navauth_demo/src/bloc/authentication/authentication_event.dart';
import 'package:jiverson_navauth_demo/src/bloc/authentication/authentication_state.dart';
import 'package:jiverson_navauth_demo/src/core/authentication/authentication_manager.dart';
import 'package:jiverson_navauth_demo/src/resource/login_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository _repository;

  AuthenticationBloc(this._repository) : super(InitialAuthenticationState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    yield AuthenticationProcessingState();
    if (event is LoginEvent) {
      if (await _repository.login()) {
        AuthenticationManager.instance.isLoggedIn = true;
        yield AuthenticationSuccessState();
      } else {
        AuthenticationManager.instance.isLoggedIn = false;
        yield AuthenticationErrorState(error: 'Login failed');
      }
    }
    if (event is LogoutEvent) {
      await _repository.logout();
      AuthenticationManager.instance.isLoggedIn = false;
      yield LoggedOutState();
    }
  }
}
