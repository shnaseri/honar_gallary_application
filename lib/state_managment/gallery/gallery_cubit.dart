import 'package:bloc/bloc.dart';
import 'package:honar_api_v13/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  late ArtApi artApi;

  GalleryCubit() : super(GalleryInitial()) {
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> fetchGallery(int userId) async {
    emit(GalleryLoading());
    try {
      InlineResponse2003 response2003 =
          await artApi.artGalleryRead(userId.toString());
      emit(GalleryLoaded(
          response2003.owner, response2003.postsCount, response2003.posts));
    } catch (e) {
      print(e);
      emit(GalleryError());
    }
  }
}
