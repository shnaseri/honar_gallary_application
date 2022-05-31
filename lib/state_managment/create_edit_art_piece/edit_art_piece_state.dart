part of 'edit_art_piece_cubit.dart';

@immutable
abstract class EditArtPieceState {}

class EditArtPieceInitial extends EditArtPieceState {}

class EditArtPieceUploadingCover extends EditArtPieceState {}

class EditArtPieceSendingCover extends EditArtPieceState {}

class EditArtPieceSendingInformation extends EditArtPieceState {}

class EditArtPieceSendingContent extends EditArtPieceState {}

class EditArtPieceSuccessfully extends EditArtPieceState {}

class EditArtPieceError extends EditArtPieceState {}
