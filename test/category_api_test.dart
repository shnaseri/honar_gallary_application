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

/// tests for CategoryApi
Future<void> main() async {
  var user = ApiClient();
  var authApi = AuthApi();
  final response = await authApi.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  final instance = CategoryApi(user);
  group('tests for CategoryApi', () {
    //Future<List<Category>> categoryGetAllList() async
    test('test categoryGetAllList', () async {
      final response = await instance.categoryGetAllList();
      expect(response!.first.runtimeType, Category);
    });
  });
}
