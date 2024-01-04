part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class Initial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Error extends AuthState {
  final String error;
  Error(this.error);

  @override
  List<Object?> get props => [error];
}

class Authenticated extends AuthState {
  final String token;
  Authenticated(this.token);

  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
