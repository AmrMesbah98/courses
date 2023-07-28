part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccessHomePage extends LoginState {}
class LoginSuccessLogin extends LoginState {}
class LoginError extends LoginState {}
