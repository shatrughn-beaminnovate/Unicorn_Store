import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Login/login_data.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Logout/logout_details.dart';
import 'package:unicorn_store/Data/Repositories/login%20and%20signup/login_details_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    final LoginDetailsRepository loginDetailsRepository =
        LoginDetailsRepository();

    on<AppStarted>((event, emit) async {
      final bool hasToken = await loginDetailsRepository.hasToken();
      final bool hasOnBoarding =
          await loginDetailsRepository.hasOnBoardingScreenData();

      if (hasOnBoarding) {
        if (hasToken) {
          final loginData = await loginDetailsRepository.getTokenData();

          emit(AuthenticationAuthenticated(
              loginData: LoginData.fromJson(jsonDecode(loginData!))));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } else {
        await loginDetailsRepository.addingOnBoardingScreenData();
        emit(AuthenticatedOnboardingIncomplete());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());

      await loginDetailsRepository.persistToken(event.loginData);

      emit(AuthenticationAuthenticated(loginData: event.loginData));
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());

      // ignore: unused_local_variable
      final logoutData = await loginDetailsRepository.getLogoutDetails(
          event.token);
      await loginDetailsRepository.deleteToken();
     // emit(AuthenticatedUserLoggedout(logoutDetails: logoutData));
      emit(AuthenticationUnauthenticated());
    });
  }
}
