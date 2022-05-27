import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Future<bool> sendCodeOtp(String code) async {
    emit(OtpLoadingCodeState());
    try {
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> resendCode() async {
    try {
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> changeState() async {
    emit(OtpInitial());
  }
}
