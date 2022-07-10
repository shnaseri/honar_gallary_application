import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';

import '../../logic/consts.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  late ProfileApi profileApi;

  SplashCubit() : super(SplashInitial());

  Future<void> verifyToken() async {
    try {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 1));
      interfaceOfUser = ApiClient();
      if (ConfigGeneralValues.getInstance()
              .sharedPreferencesHandler
              .getToken() ==
          null) {
        emit(SplashGoToAuth());
      }
      try {
        String? token = ConfigGeneralValues.getInstance()
            .sharedPreferencesHandler
            .getToken();
        AuthApi authApi = AuthApi(interfaceOfUser);

        HttpBearerAuth auth = HttpBearerAuth();
        auth.accessToken = ConfigGeneralValues.getInstance()
            .sharedPreferencesHandler
            .getToken()!;
        print(auth.accessToken);
        interfaceOfUser = ApiClient(authentication: auth);
        CategoryApi categoryApi = CategoryApi(interfaceOfUser);
        ConfigGeneralValues.getInstance()
            .setListCategory((await categoryApi.categoryGetAllList())!);
        authApi = AuthApi(interfaceOfUser);
        AuthMeList200Response response2004 = (await authApi.authMeList())!;
        ConfigGeneralValues.getInstance().setUserId(response2004.userId!);
        print(response2004.userId);

        profileApi = ProfileApi(interfaceOfUser);
        FullUser? fullUser = await profileApi.profileRead(response2004.userId!);
        print(fullUser);
        ConfigGeneralValues.getInstance().setProfile(fullUser!);

        emit(SplashGoToHome());
        return;
      } catch (e) {
        print("------");
        print(e);
        emit(SplashGoToAuth());
        return;
      }
    } catch (e) {
      emit(SplashError());
    }
  }
}
