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

/// tests for ProfileApi
Future<void> main() async {
  // final instance = ProfileApi();
  var user = ApiClient();
  var authApi = AuthApi();
  final response = await authApi.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  final instance = ProfileApi(user);
  group('tests for ProfileApi', () {

    //Future<ProfileFollowUpdate200Response> profileFollowUpdate(String id) async
    test('test profileFollowUpdate', () async {
      final response = await instance.profileFollowUpdate("3");
      expect(response!.follow.runtimeType,bool);
    });

    //Future<FullUser> profilePartialUpdate(int id, FullUser data) async
    test('test profilePartialUpdate', () async {
      final response = await instance.profilePartialUpdate(10,FullUser(email: "test@gmail.com",firstName: "1"));
      expect(response.runtimeType, FullUser);
    });

    //Future<FullUser> profileRead(int id) async
    test('test profileRead', () async {
      final response = await instance.profileRead(10);
      expect(response.runtimeType, FullUser);
    });

    //Future<FullUser> profileUpdate(int id, FullUser data) async
    test('test profileUpdate', () async {
      final response = await instance.profilePartialUpdate(10,FullUser(email: "test@gmail.com",firstName: "1"));
      expect(response.runtimeType, FullUser);
    });
  });
}
