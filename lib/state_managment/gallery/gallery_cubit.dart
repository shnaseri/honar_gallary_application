import 'package:bloc/bloc.dart';
import 'package:honar_api_v20/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  late ArtApi artApi;
  late ProfileApi profileApi;

  GalleryCubit() : super(GalleryInitial()) {
    artApi = ArtApi(interfaceOfUser);
    profileApi = ProfileApi(interfaceOfUser);
  }

  Future<void> fetchGallery(int userId, {bool isBusiness = false}) async {
    emit(GalleryLoading());
    try {
      // if(userId != ConfigGeneralValues.getInstance().userId){
      //   FullUser? user = await profileApi.profileRead(userId);
      // }
      ArtGalleryRead200Response? response2003 =
          await artApi.artGalleryRead(userId.toString(), business: isBusiness);
      ConfigGeneralValues.getInstance().enableBusiness =
          response2003!.profile!.isBusiness;
      emit(GalleryLoaded(
          response2003.owner!,
          response2003.postsCount!,
          response2003.posts,
          response2003.profile!,
          response2003.profile!.isBusiness));
    } catch (e) {
      print(e);
      emit(GalleryError());
    }
  }

  Future<bool> followUser(int? id) async {
    ProfileFollowUpdate200Response? update200response =
        await profileApi.profileFollowUpdate(id.toString());
    return update200response!.follow;
  }
}
