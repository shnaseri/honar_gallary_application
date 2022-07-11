//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:honar_api_v22/api.dart';
import 'package:test/test.dart';

/// tests for CommentApi
Future<void> main() async {
  // final instance = CommentApi();
  var user = ApiClient();
  var authApi = AuthApi();
  final response = await authApi.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  final instance = CommentApi(user);
  String artPieceId = "1";
  group('tests for CommentApi', () {
    //Future<SingleComment> commentAddCommentCreate(String artPieceId, AddComment data) async
    test('test commentAddCommentCreate', () async {
      final response = await instance.commentAddCommentCreate(
          artPieceId, AddComment(content: "test"));
      expect(response.runtimeType, SingleComment);
    });

    //Future<List<Comments>> commentAllCommentsList(String artPieceId) async
    test('test commentAllCommentsList', () async {
      final response = await instance.commentAllCommentsList(artPieceId);
      expect(response!.first.runtimeType, Comments);
    });
  });
}
