part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final CoreHomepageList200Response homepage;

  HomeLoaded(this.homepage);
}

class HomeError extends HomeState {}
