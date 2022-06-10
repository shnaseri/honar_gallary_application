import 'package:bloc/bloc.dart';
import 'package:honar_api_v4/api.dart';
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
      InlineResponse2004 response2004 = await authApi.authVerifyOtpCodeCreate(
          userId.toString(), OtpCode(otpCode: code));
      if (response2004.success && response2004.valid) {
        emit(OtpLoadedCodeState());
        ConfigGeneralValues.getInstance().putToken(response2004.accessToken);
        interfaceOfUser.getAuthentication<ApiKeyAuth>(r'Bearer')
          ..apiKeyPrefix = 'Bearer'
          ..apiKey = response2004.accessToken;
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
