import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:honar_api_v3/api.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../data_managment/core/upload_networkservice.dart';
import '../../logic/consts.dart';

part 'edit_art_piece_state.dart';

class EditArtPieceCubit extends Cubit<EditArtPieceState> {
  late UploadNetworkService uploadNetworkService;
  late ArtApi artApi;
  late CoreApi coreApi;

  EditArtPieceCubit() : super(EditArtPieceInitial()) {
    uploadNetworkService = UploadNetworkService();
    artApi = ArtApi(interfaceOfUser);
    coreApi = CoreApi(interfaceOfUser);
  }

  Future<void> flowOfCreateArtPiece(File file, String type, String title,
      String description, List<File> imageSliderFiles,
      {int price = 0}) async {
    try {
      int? coverId = await uploadImage(
          getTypeOfArtPiece(type) == ArtPieceCoverTypeEnum.P
              ? file
              : imageSliderFiles[0]);
      int? artId;
      if (coverId != null) {
        artId = await sendInfoConver(coverId, type);
      }
      if (artId != null) {
        await sendInfoArtPiece(artId, title, description, price);
      }
      if (ArtPieceCoverTypeEnum.V == getTypeOfArtPiece(type) ||
          ArtPieceCoverTypeEnum.M == getTypeOfArtPiece(type)) {
        print('---- Start Uploading ------');
        InlineResponse2004 response = await coreApi.coreContentUpdate(
            await http.MultipartFile.fromPath('file', file.path));
        print(response.success);
        print('---- End Uploading ------');
      }
      emit(EditArtPieceSuccessfully());
    } catch (e) {
      emit(EditArtPieceInitial());
      print(e);
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

  void resetState() {
    emit(EditArtPieceInitial());
  }
}
