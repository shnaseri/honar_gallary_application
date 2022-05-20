//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart = 2.8

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthApi {
  AuthApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /auth/login/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [TokenObtainPair] data (required):
  Future<Response> authLoginCreateWithHttpInfo(
    TokenObtainPair data,
  ) async {
    // Verify required params are set.
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/auth/login/';

    // ignore: prefer_final_locals
    Object postBody = data;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [TokenObtainPair] data (required):
  Future<AccessRefresh> authLoginCreate(
    TokenObtainPair data,
  ) async {
    final response = await authLoginCreateWithHttpInfo(
      data,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'AccessRefresh',
      ) as AccessRefresh;
    }
    return Future<AccessRefresh>.value();
  }

  /// Takes a refresh type JSON web token and returns an access type JSON web token if the refresh token is valid.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TokenRefresh] data (required):
  Future<Response> authLogoutCreateWithHttpInfo(
    TokenRefresh data,
  ) async {
    // Verify required params are set.
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/auth/logout/';

    // ignore: prefer_final_locals
    Object postBody = data;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );
  }

  /// Takes a refresh type JSON web token and returns an access type JSON web token if the refresh token is valid.
  ///
  /// Parameters:
  ///
  /// * [TokenRefresh] data (required):
  Future<TokenRefresh> authLogoutCreate(
    TokenRefresh data,
  ) async {
    final response = await authLogoutCreateWithHttpInfo(
      data,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TokenRefresh',
      ) as TokenRefresh;
    }
    return Future<TokenRefresh>.value();
  }

  /// Performs an HTTP 'POST /auth/register/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [Register] data (required):
  Future<Response> authRegisterCreateWithHttpInfo(
    Register data,
  ) async {
    // Verify required params are set.
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/auth/register/';

    // ignore: prefer_final_locals
    Object postBody = data;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );
  }

  /// Parameters:
  ///
  /// * [Register] data (required):
  Future<UserId> authRegisterCreate(
    Register data,
  ) async {
    final response = await authRegisterCreateWithHttpInfo(
      data,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'UserId',
      ) as UserId;
    }
    return Future<UserId>.value();
  }

  /// Takes a token and indicates if it is valid.  This view provides no information about a token's fitness for a particular use.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TokenVerify] data (required):
  Future<Response> authVerifyCreateWithHttpInfo(
    TokenVerify data,
  ) async {
    // Verify required params are set.
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/auth/verify/';

    // ignore: prefer_final_locals
    Object postBody = data;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );
  }

  /// Takes a token and indicates if it is valid.  This view provides no information about a token's fitness for a particular use.
  ///
  /// Parameters:
  ///
  /// * [TokenVerify] data (required):
  Future<TokenVerify> authVerifyCreate(
    TokenVerify data,
  ) async {
    final response = await authVerifyCreateWithHttpInfo(
      data,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body != null && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TokenVerify',
      ) as TokenVerify;
    }
    return Future<TokenVerify>.value();
  }
}
