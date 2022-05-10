part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSending extends AuthenticationState {}

class AuthenticationSendSuccessfully extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {}
