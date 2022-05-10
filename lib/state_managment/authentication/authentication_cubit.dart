import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<bool> sendInformationLogin() async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
