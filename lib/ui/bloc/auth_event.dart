part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnInitial extends AuthEvent {}

class OnLogin extends AuthEvent {}

class OnLogout extends AuthEvent {}
