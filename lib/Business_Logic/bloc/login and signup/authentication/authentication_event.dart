part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final LoginData loginData;

  const LoggedIn({required this.loginData});

  @override
  List<Object> get props => [loginData];

  @override
  String toString() => 'LoggedIn { token: $loginData }';
}

class LoggedOut extends AuthenticationEvent {
  final String userId;
  final String token;

  const LoggedOut(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];

  @override
  String toString() => 'LoggedOut';
}
