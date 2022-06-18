import 'package:bloc/bloc.dart';
import 'package:honar_api_v13/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  late ProfileApi profileApi;

  ProfileCubit() : super(ProfileInitial()) {
    profileApi = ProfileApi(interfaceOfUser);
  }

  Future sendInfoProfile(
      String firstname, String lastname, String email, String phone) async {
    try {
      emit(ProfileSendingState());
      FullUser profile = await profileApi.profileUpdate(
          ConfigGeneralValues.getInstance().userId,
          FullUser(
              email: email,
              firstName: firstname,
              lastName: lastname,
              userProfile: UserProfile(
                gender: UserProfileGenderEnum.M,
                phoneNumber: phone,
                nationalCode: "98",
                birthdate: "2001/06/22",
              )));
      emit(ProfileSendState());
      return profile;
    } catch (e) {
      emit(ProfileErrorState());
      rethrow;
    }
  }
}
