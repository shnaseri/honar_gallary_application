part of 'art_piece_cubit.dart';

@immutable
abstract class ArtPieceState {}

class ArtPieceInitial extends ArtPieceState {}

class ArtPieceLoading extends ArtPieceState {}

class ArtPieceLoaded extends ArtPieceState {
  final ArtPiece artPiece;

  ArtPieceLoaded(this.artPiece);
}

class ArtPieceError extends ArtPieceState {}
