import 'package:bloc/bloc.dart';
import 'package:honar_api_v4/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'art_piece_state.dart';

class ArtPieceCubit extends Cubit<ArtPieceState> {
  ArtPieceCubit() : super(ArtPieceInitial());

  Future<void> fetchArtPiece(int id) async {
    emit(ArtPieceLoading());
    ArtApi artApi = ArtApi(interfaceOfUser);
    try {
      print(id);
      ArtPiece artPiece = await artApi.artArtPieceRead(id.toString());
      emit(ArtPieceLoaded(artPiece));
    } catch (e) {
      print(e);
      emit(ArtPieceError());
    }
  }
}
