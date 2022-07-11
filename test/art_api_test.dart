//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:honar_api_v22/api.dart';
import 'package:test/test.dart';

/// tests for ArtApi
Future<void> main() async {
  var user = ApiClient();
  var authApi = AuthApi();
  final response = await authApi.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  final instance = ArtApi(user);
  String artcode = "1";
  group('tests for ArtApi', () {
    //Future<ArtArtPieceUpdate200Response> artArtPieceContentUpdate(String id, ArtPieceContent data) async
    //Future<ArtArtPieceLikeUpdate200Response> artArtPieceLikeUpdate(String id) async
    test('test artArtPieceLikeUpdate', () async {
      final response = await instance.artArtPieceLikeUpdate(artcode);
      expect(response!.like.runtimeType,bool);
    });

    //Future<ArtPiece> artArtPieceRead(String id) async
    test('test artArtPieceRead', () async {
      final response = await instance.artArtPieceRead(artcode);
      expect(response.runtimeType, ArtPiece);
      expect(response!.id.runtimeType,int);
      expect(response.title.runtimeType, String);
      expect(response.id, int.parse(artcode));
      expect(response.title,"مجسمهه");
    });

    //Future<ArtArtPieceUpdate200Response> artArtPieceUpdate(String id, ArtPieceDetail data) async
    test('test artArtPieceUpdate', () async {
      final response = await instance.artArtPieceUpdate(artcode,ArtPieceDetail(price: 0));
      expect(response!.success.runtimeType,bool);
    });

    //Future<List<ArtPiece>> artExploreList({ int page, int pageCount, int categoryId }) async
    test('test artExploreList', () async {
      final response = await instance.artExploreList(page: 1,pageCount: 10);
      expect(response!.isNotEmpty ,true);
      expect(response[0].runtimeType,ArtPiece);
    });

    //Future<ArtGalleryRead200Response> artGalleryRead(String id, { bool business }) async
    test('test artGalleryRead', () async {
      final response = await instance.artExploreList(page: 1,pageCount: 10);
      expect(response!.isNotEmpty,true);
    });

    //Future<SearchResult> artSearchList({ String query }) async
    test('test artSearchList', () async {
      final response = await instance.artSearchList(query: "مج");
      expect(response!.artPieces.isNotEmpty, true);
      expect(response.artPieces.first.runtimeType,ArtPieceCompact);
    });
  });
}
