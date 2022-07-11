//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:honar_api_v22/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:test/test.dart';

/// tests for AuthApi
Future<void> main() async {
  var user = ApiClient();
  var instance = AuthApi();
  final response = await instance.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  instance = AuthApi(user);
  int userId = 10;

  group('tests for AuthApi', () {
    //Future<AccessRefresh> authLoginCreate(TokenObtainPair data) async
    test('test authLoginCreate', () async {
      final response = await instance.authLoginCreate(
          TokenObtainPair(email: "test@gmail.com", password: "123456"));
      expect(response!.access.runtimeType,String);
      user = ApiClient(
          authentication: HttpBearerAuth()..accessToken = response.access);
      instance = AuthApi(user);
    });


    //Future<AuthMeList200Response> authMeList() async
    test('test authMeList', () async {
      final response = await instance.authMeList();
      expect(response!.userId,10);
      userId = response.userId!;
    });

    //Future<UserId> authRegisterCreate(Register data) async
    test('test authRegisterCreate', () async {
      // TODO
      final response = await instance.authRegisterCreate(Register(
          email: 'test@gmail.com',
          lastName: "test",
          firstName: "ftest",
          password: "123456 "));
      expect(response!.id, null);
    });

    //Future<ArtArtPieceUpdate200Response> authSendOtpCodeCreate(String id) async
    test('test authSendOtpCodeCreate', () async {
      final response = await instance.authSendOtpCodeCreate(userId.toString());
      expect(response!.success,true);
    });

    // Takes a token and indicates if it is valid.  This view provides no information about a token's fitness for a particular use.
    //
    //Future<TokenVerify> authVerifyCreate(TokenVerify data) async
    test('test authVerifyCreate', () async {
      // TODO
    });

    //Future<AuthVerifyOtpCodeCreate200Response> authVerifyOtpCodeCreate(String id, OtpCode data) async
    test('test authVerifyOtpCodeCreate', () async {
      // TODO
    });
  });
}
