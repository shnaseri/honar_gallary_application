import 'package:bloc/bloc.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';
import 'package:petstore_api/api.dart';

part 'art_piece_state.dart';

class ArtPieceCubit extends Cubit<ArtPieceState> {
  ArtPieceCubit() : super(ArtPieceInitial());

  Future<void> fetchArtPiece({int id = 1}) async {
    print("sdgdfg");
    emit(ArtPieceLoading());
    ArtApi artApi = ArtApi(interfaceOfUser);
    try {
      ArtPiece artPiece = await artApi.artArtPieceRead("1");
      print(artPiece.title);
      emit(ArtPieceLoaded(artPiece));
    } catch (e) {
      print(e);
      emit(ArtPieceError());
    }
  }
}
