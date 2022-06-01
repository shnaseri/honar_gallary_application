import 'package:bloc/bloc.dart';
import 'package:honar_api_v3/api.dart';
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
      InlineResponse2003 response2003 = await authApi.authVerifyOtpCodeCreate(
          userId.toString(), OtpCode(otpCode: code));
      if (response2003.success && response2003.valid) {
        emit(OtpLoadedCodeState());
        ConfigGeneralValues.getInstance().putToken(response2003.accessToken);
        interfaceOfUser.getAuthentication<ApiKeyAuth>(r'Bearer')
          ..apiKeyPrefix = 'Bearer'
          ..apiKey = response2003.accessToken;
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
