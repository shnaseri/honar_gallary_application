part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashGoToAuth extends SplashState {}

class SplashGoToHome extends SplashState {}

class SplashError extends SplashState {}
