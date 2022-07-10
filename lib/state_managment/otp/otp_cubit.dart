import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

import '../../logic/general_values.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  late AuthApi authApi;

  OtpCubit() : super(OtpInitial()) {
    authApi = AuthApi(interfaceOfUser);
  }

  Future<bool> sendCodeOtp(int userId, String code) async {
    emit(OtpLoadingCodeState());
    try {
      print("--- sending otp ----");

      AuthVerifyOtpCodeCreate200Response? response2004 = await authApi
          .authVerifyOtpCodeCreate(userId.toString(), OtpCode(otpCode: code));
      if (response2004!.success && response2004.valid!) {
        emit(OtpLoadedCodeState());
        ConfigGeneralValues.getInstance().putToken(response2004.accessToken!);

        HttpBearerAuth auth = HttpBearerAuth();
        auth.accessToken = response2004.accessToken;
        interfaceOfUser = ApiClient(authentication: auth);

        CategoryApi categoryApi = CategoryApi(interfaceOfUser);
        ConfigGeneralValues.getInstance()
            .setListCategory((await categoryApi.categoryGetAllList())!);
        AuthMeList200Response response200 = (await authApi.authMeList())!;
        ConfigGeneralValues.getInstance().setUserId(response200.userId!);
        print(response200.userId);
        late ProfileApi profileApi = ProfileApi(interfaceOfUser);
        profileApi = ProfileApi(interfaceOfUser);
        FullUser? fullUser = await profileApi.profileRead(response200.userId!);
        print(fullUser);
        ConfigGeneralValues.getInstance().setProfile(fullUser!);
        return true;
      } else {
        emit(OtpBadCode());
        return false;
      }
    } catch (error) {
      print(error);
      emit(OtpBadCode());
      return false;
    }
  }

  Future<bool> resendCode(int userId) async {
    try {
      await authApi.authSendOtpCodeCreate(userId.toString());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<void> changeState() async {
    emit(OtpInitial());
  }
}
