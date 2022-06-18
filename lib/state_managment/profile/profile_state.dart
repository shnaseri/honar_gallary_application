part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSendingState extends ProfileState {}

class ProfileSendState extends ProfileState {}

class ProfileErrorState extends ProfileState {}
