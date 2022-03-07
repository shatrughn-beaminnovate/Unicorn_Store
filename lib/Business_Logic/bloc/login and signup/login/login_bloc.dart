import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Business_Logic/bloc/login%20and%20signup/authentication/authentication_bloc.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Forgot%20Password/forgot_password_response.dart';
import 'package:unicorn_store/Data/Models/Login%20and%20Signup/Forgot%20Password/response_data.dart';
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

        if (loginData.token == "Token Not Generated") 
        {
           emit(const LoginFailure(error:"UserName and Password Failed"));
        } 
        else 
        {
          authenticationBloc.add(LoggedIn(loginData: loginData));
          emit(LoginInitial());
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });


      on<SignupButtonPressed>((event, emit) async {
      try {
        emit(LoginLoading());

        final registerResponse = await loginDetailsRepository.registerUserDetails(event.registerData);

        if(registerResponse.response!="id: 0" && registerResponse.response!="User Already Exist")
        {
          emit(RegistrationSuccess(registerResponse));
        }
        else{
           emit(LoginFailure(error:registerResponse.response!));
        }
     
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });

     

  }
}
