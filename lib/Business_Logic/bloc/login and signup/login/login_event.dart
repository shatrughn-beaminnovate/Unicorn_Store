part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class SignupButtonPressed extends LoginEvent {
  final RegisterData registerData;

  const SignupButtonPressed({required this.registerData});

  @override
  List<Object> get props => [
        registerData,
      ];
}
