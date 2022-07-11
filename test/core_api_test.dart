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

/// tests for CoreApi
Future<void> main() async {
  var user = ApiClient();
  var authApi = AuthApi();
  final response = await authApi.authLoginCreate(
      TokenObtainPair(email: "test@gmail.com", password: "123456"));
  user = ApiClient(
      authentication: HttpBearerAuth()..accessToken = response!.access);
  final instance = CoreApi(user);
  group('tests for CoreApi', () {
    test('test coreHomePage', () async {
      final response  = await instance.coreHomepageList(pageCount: 10,page: 1);
      expect(response!.stats.runtimeType , CoreHomepageList200ResponseStats );
      expect(response.offers.runtimeType , CoreHomepageList200ResponseOffers );
    });
  });
}
