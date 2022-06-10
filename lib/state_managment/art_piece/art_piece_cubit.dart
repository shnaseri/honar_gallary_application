import 'package:bloc/bloc.dart';
import 'package:honar_api_v4/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'art_piece_state.dart';

class ArtPieceCubit extends Cubit<ArtPieceState> {
  late ArtApi artApi;

  ArtPieceCubit() : super(ArtPieceInitial()) {
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> fetchArtPiece(int id) async {
    emit(ArtPieceLoading());
    try {
      print(id);
      ArtPiece artPiece = await artApi.artArtPieceRead(id.toString());
      emit(ArtPieceLoaded(artPiece));
    } catch (e) {
      print(e);
      emit(ArtPieceError());
    }
  }

  Future<bool> changeStatusLikeArtPiece(int artId) async {
    try {
      InlineResponse2002 response2002 =
          await artApi.artArtPieceLikeUpdate(artId.toString());
      print(response2002.like);
      return response2002.like;
    } catch (e) {
      return false;
    }
  }
}
