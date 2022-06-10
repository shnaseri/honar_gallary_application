import 'package:bloc/bloc.dart';
import 'package:honar_api_v5/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'art_piece_state.dart';

class ArtPieceCubit extends Cubit<ArtPieceState> {
  ArtPieceCubit() : super(ArtPieceInitial());

  Future<void> fetchArtPiece({int id = 1}) async {
    emit(ArtPieceLoading());
    ArtApi artApi = ArtApi(interfaceOfUser);
    try {
      ArtPiece artPiece = await artApi.artArtPieceRead("6");
      emit(ArtPieceLoaded(artPiece));
    } catch (e) {
      emit(ArtPieceError());
    }
  }
}
