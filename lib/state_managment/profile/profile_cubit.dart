import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/data_managment/core/upload_networkservice.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:honar_gallary/logic/general_values.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  late ProfileApi profileApi;
  late UploadNetworkService uploadNetworkService;

  ProfileCubit() : super(ProfileInitial()) {
    profileApi = ProfileApi(interfaceOfUser);
    uploadNetworkService = UploadNetworkService();
  }

  Future<bool> uploadProfile(File file) async {
    try {
      emit(ProfileSendingState());
      int image = await uploadImage(file) ?? -1;
      ArtArtPieceUpdate200Response? artArtPieceUpdate200Response =
          await profileApi
              .profileAddProfileImageCreate(AddImage(profileImageId: image));
      return artArtPieceUpdate200Response!.success;
    } catch (e) {
      return false;
    }
  }

  Future<int?> uploadImage(File file) async {
    try {
      Map output = await uploadNetworkService.uploadImage(file);
      print(output);
      return output['id'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future sendInfoProfile(
      String firstname, String lastname, String email, String phone) async {
    try {
      emit(ProfileSendingState());
      FullUser? profile = await profileApi.profileUpdate(
          ConfigGeneralValues.getInstance().userId!,
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
      ConfigGeneralValues.getInstance().setProfile(profile!);
      emit(ProfileSendState());
      return profile;
    } catch (e) {
      emit(ProfileErrorState());
      rethrow;
    }
  }
}
