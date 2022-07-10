import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:honar_api_v18/api.dart';
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

  Future<bool> flowOfCreateArtPiece(File file, String type, String title,
      String description, List<File> imageSliderFiles, int categoryId,
      {int price = 0}) async {
    try {
      emit(EditArtPieceUploadingCover());
      int? coverId = await uploadImage(
          getTypeOfArtPiece(type) == ArtPieceCoverTypeEnum.P
              ? file
              : imageSliderFiles[0]);
      int? artId;
      if (coverId != null) {
        artId = await sendInfoConver(coverId, type);
      }
      if (artId != null) {
        List<int> imageIds = [];
        if (ArtPieceCoverTypeEnum.V == getTypeOfArtPiece(type) ||
            ArtPieceCoverTypeEnum.M == getTypeOfArtPiece(type)) {
          emit(EditArtPieceUploadingImages());
          for (File file in imageSliderFiles) {
            imageIds.add(await uploadImage(file) ?? 1);
          }
        }
        await sendInfoArtPiece(
            artId, title, description, price, categoryId, imageIds);
      }
      if (ArtPieceCoverTypeEnum.V == getTypeOfArtPiece(type) ||
          ArtPieceCoverTypeEnum.M == getTypeOfArtPiece(type)) {
        print('---- Start Uploading ------');
        emit(EditArtPieceUploadingContent());
        CoreContentUpdate200Response? response =
            await coreApi.coreContentUpdate(
                await http.MultipartFile.fromPath('file', file.path));
        print(response!.success);
        ArtArtPieceUpdate200Response? response2001 =
            await artApi.artArtPieceContentUpdate(artId.toString(),
                ArtPieceContent(contentId: response.contentId!));
        print('---- End Uploading ------');
      }
      emit(EditArtPieceSuccessfully());
      return true;
    } catch (e) {
      emit(EditArtPieceInitial());
      print(e);
      return false;
    }
  }

  Future<bool> flowOfEditArtPiece(int artId, String type, String title,
      String description, List<File> imageSliderFiles, int categoryId,
      {int price = 0}) async {
    try {
      int? coverId = 1;
      // if (getTypeOfArtPiece(type) != ArtPieceCoverTypeEnum.P) {
      //   coverId = await uploadImage(imageSliderFiles[0]);
      //   if (coverId != null) {
      //     artId = await sendInfoConver(coverId, type);
      //   }
      // }
      // int? artId;

      if (artId != null) {
        await sendInfoArtPiece(
            artId, title, description, price, categoryId, []);
      }
      // if (ArtPieceCoverTypeEnum.V == getTypeOfArtPiece(type) ||
      //     ArtPieceCoverTypeEnum.M == getTypeOfArtPiece(type)) {
      //   print('---- Start Uploading ------');
      //   InlineResponse2006 response = await coreApi.coreContentUpdate(
      //       await http.MultipartFile.fromPath('file', file.path));
      //   print(response.success);
      //   InlineResponse2001 response2001 = await artApi.artArtPieceContentUpdate(
      //       artId.toString(), ArtPieceContent(contentId: response.contentId));
      //   print('---- End Uploading ------');
      // }
      emit(EditArtPieceSuccessfully());
      return true;
    } catch (e) {
      emit(EditArtPieceInitial());
      print(e);
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
      emit(EditArtPieceError());
      return null;
    }
  }

  Future<int?> sendInfoConver(int cover, String type) async {
    try {
      emit(EditArtPieceSendingCover());

      ArtArtPieceCoverCreate200Response? response200 =
          await artApi.artArtPieceCoverCreate(
              ArtPieceCover(cover: cover, type: getTypeOfArtPiece(type)));
      print('----- post information done --------');
      print(response200!.artPieceId);
      return response200.artPieceId;
    } catch (e) {
      print(e);
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

  Future<bool?> sendInfoArtPiece(int artPieceId, String title,
      String description, int price, int categoryId, List<int> ImageIds) async {
    try {
      emit(EditArtPieceSendingInformation());

      ArtArtPieceUpdate200Response? response200 =
          await artApi.artArtPieceUpdate(
              artPieceId.toString(),
              ArtPieceDetail(
                  description: description,
                  title: title,
                  price: price,
                  categoryId: categoryId,
                  imageIds: ImageIds));
      print('----- post information done --------');
      print(response200!.success);
      return response200.success;
    } catch (e) {
      print('send info');
      print(e);
      emit(EditArtPieceError());
      return null;
    }
  }

  void resetState() {
    emit(EditArtPieceInitial());
  }
}
