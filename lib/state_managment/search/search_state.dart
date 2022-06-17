part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  List<User> artists;
  List<ArtPieceCompact> artPieces;

  SearchLoaded(this.artists, this.artPieces);
}

class SearchError extends SearchState {}
