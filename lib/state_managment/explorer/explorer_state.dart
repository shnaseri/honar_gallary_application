part of 'explorer_cubit.dart';

@immutable
abstract class ExplorerState {}

class ExplorerInitial extends ExplorerState {}

class ExplorerLoading extends ExplorerState {}

class ExplorerLoaded extends ExplorerState {
  final List<ArtPiece> arts;

  ExplorerLoaded(this.arts);
}

class ExplorerError extends ExplorerState {}
