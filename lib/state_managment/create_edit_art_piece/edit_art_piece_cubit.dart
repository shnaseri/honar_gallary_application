import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petstore_api/api.dart';

import '../../data_managment/core/upload_networkservice.dart';
import '../../logic/consts.dart';

part 'edit_art_piece_state.dart';

class EditArtPieceCubit extends Cubit<EditArtPieceState> {
  late UploadNetworkService uploadNetworkService;
  late ArtApi artApi;

  EditArtPieceCubit() : super(EditArtPieceInitial()) {
    uploadNetworkService = UploadNetworkService();
    artApi = ArtApi(interfaceOfUser);
  }

  Future<void> flowOfCreateArtPiece(
      File cover, String type, String title, String description,
      {int price = 0}) async {
    int? coverId = await uploadImage(cover);
    int? artId;
    if (coverId != null) {
      artId = await sendInfoConver(coverId, type);
    }
    if (artId != null) {
      await sendInfoArtPiece(artId, title, description, price);
    }
  }

  Future<int?> uploadImage(File file) async {
    try {
      emit(EditArtPieceUploadingCover());

      Map output = await uploadNetworkService.uploadImage(file);
      print(output);
      return output['id'];
    } catch (e) {
      emit(EditArtPieceError());
      return null;
    }
  }

  Future<int?> sendInfoConver(int cover, String type) async {
    try {
      emit(EditArtPieceSendingCover());

      InlineResponse200 response200 = await artApi.artArtPieceCoverCreate(
          ArtPieceCover(cover: cover, type: getTypeOfArtPiece(type)));
      print('----- post information done --------');
      print(response200.artPieceId);
      return response200.artPieceId;
    } catch (e) {
      emit(EditArtPieceError());
      return null;
    }
  }

  getTypeOfArtPiece(type) {
    var items = [
      'عکس',
      'فیلم',
      'موسیقی',
    ];
    if (type == items[0]) {
      return ArtPieceCoverTypeEnum.P;
    }
    if (type == items[1]) {
      return ArtPieceCoverTypeEnum.V;
    }
    return ArtPieceCoverTypeEnum.M;
  }

  Future<bool?> sendInfoArtPiece(
      int artPieceId, String title, String description, int price) async {
    try {
      emit(EditArtPieceSendingInformation());

      InlineResponse2001 response200 = await artApi.artArtPieceUpdate(
          artPieceId.toString(),
          ArtPieceDetail(description: description, title: title, price: price));
      print('----- post information done --------');
      print(response200.success);
      return response200.success;
    } catch (e) {
      emit(EditArtPieceError());
      return null;
    }
  }
}
