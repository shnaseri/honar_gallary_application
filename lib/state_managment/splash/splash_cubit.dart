import 'package:bloc/bloc.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';
import 'package:petstore_api/api.dart';

import '../../logic/consts.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> verifyToken() async {
    try {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 2));
      interfaceOfUser = ApiClient();
      AuthApi authApi = AuthApi(interfaceOfUser);
      if (ConfigGeneralValues.getInstance()
              .sharedPreferencesHandler
              .getToken() ==
          null) {
        emit(SplashGoToAuth());
      }
      try {
        TokenVerify verify = await authApi.authVerifyCreate(TokenVerify(
            token: ConfigGeneralValues.getInstance()
                .sharedPreferencesHandler
                .getToken()!));

        interfaceOfUser.getAuthentication<ApiKeyAuth>(r'Bearer')
          ..apiKeyPrefix = 'Bearer'
          ..apiKey = ConfigGeneralValues.getInstance()
              .sharedPreferencesHandler
              .getToken()!;
        emit(SplashGoToHome());
        return;
      } catch (e) {
        emit(SplashGoToAuth());
        return;
      }
    } catch (e) {
      emit(SplashError());
    }
  }
}