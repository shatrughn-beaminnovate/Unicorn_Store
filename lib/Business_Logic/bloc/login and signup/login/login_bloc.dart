import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Register/register_data.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Register/register_response.dart';
import 'package:unicorn_store/Data/Repositories/login%20and%20signup/login_details_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final loginDetailsRepository = LoginDetailsRepository();
    final authenticationBloc = AuthenticationBloc();

    on<LoginButtonPressed>((event, emit) async {
      try {
        emit(LoginLoading());

        final loginData = await loginDetailsRepository.getLoginDetails(
            event.username, event.password);
    
        if (loginData.status!) {
          authenticationBloc.add(LoggedIn(loginData: loginData));
          emit(LoginInitial());
    
        } else {
          emit(const LoginFailure(error: "UserName and Password Failed"));
        }
      } catch (e) {
        emit(const LoginFailure(error: "Something went wrong!"));
      }
    });

    on<SignupButtonPressed>((event, emit) async {
      try {
        emit(LoginLoading());

        final registerResponse = await loginDetailsRepository
            .registerUserDetails(event.registerData);

        if (registerResponse.response != "id: 0" &&
            registerResponse.response != "User Already Exist") {
          emit(RegistrationSuccess(registerResponse));
        } else {
          emit(LoginFailure(error: registerResponse.response!));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
