//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart = 2.8

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArtApi {
  ArtApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'PUT /art/art-piece/{id}/content/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [MultipartFile] file (required):
  Future<Response> artArtPieceContentUpdateWithHttpInfo(
    String id,
    MultipartFile file,
  ) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }
    if (file == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: file');
    }

    // ignore: prefer_const_declarations
    final path = r'/art/art-piece/{id}/content/'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('PUT', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'PUT',
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
  /// * [String] id (required):
  ///
  /// * [MultipartFile] file (required):
  Future<InlineResponse2001> artArtPieceContentUpdate(
    String id,
    MultipartFile file,
  ) async {
    final response = await artArtPieceContentUpdateWithHttpInfo(
      id,
      file,
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
        'InlineResponse2001',
      ) as InlineResponse2001;
    }
    return Future<InlineResponse2001>.value();
  }

  /// Performs an HTTP 'POST /art/art-piece/cover/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ArtPieceCover] data (required):
  Future<Response> artArtPieceCoverCreateWithHttpInfo(
    ArtPieceCover data,
  ) async {
    // Verify required params are set.
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/art/art-piece/cover/';

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
  /// * [ArtPieceCover] data (required):
  Future<InlineResponse200> artArtPieceCoverCreate(
    ArtPieceCover data,
  ) async {
    final response = await artArtPieceCoverCreateWithHttpInfo(
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
        'InlineResponse200',
      ) as InlineResponse200;
    }
    return Future<InlineResponse200>.value();
  }

  /// Performs an HTTP 'PUT /art/art-piece/{id}/like/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> artArtPieceLikeUpdateWithHttpInfo(
    String id,
  ) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }

    // ignore: prefer_const_declarations
    final path = r'/art/art-piece/{id}/like/'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'PUT',
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
  /// * [String] id (required):
  Future<InlineResponse2002> artArtPieceLikeUpdate(
    String id,
  ) async {
    final response = await artArtPieceLikeUpdateWithHttpInfo(
      id,
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
        'InlineResponse2002',
      ) as InlineResponse2002;
    }
    return Future<InlineResponse2002>.value();
  }

  /// Performs an HTTP 'GET /art/art-piece/{id}/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> artArtPieceReadWithHttpInfo(
    String id,
  ) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }

    // ignore: prefer_const_declarations
    final path = r'/art/art-piece/{id}/'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
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
  /// * [String] id (required):
  Future<ArtPiece> artArtPieceRead(
    String id,
  ) async {
    final response = await artArtPieceReadWithHttpInfo(
      id,
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
        'ArtPiece',
      ) as ArtPiece;
    }
    return Future<ArtPiece>.value();
  }

  /// Performs an HTTP 'PUT /art/art-piece/{id}/' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ArtPieceDetail] data (required):
  Future<Response> artArtPieceUpdateWithHttpInfo(
    String id,
    ArtPieceDetail data,
  ) async {
    // Verify required params are set.
    if (id == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: id');
    }
    if (data == null) {
      throw ApiException(HttpStatus.badRequest, 'Missing required param: data');
    }

    // ignore: prefer_const_declarations
    final path = r'/art/art-piece/{id}/'.replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object postBody = data;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const authNames = <String>['Bearer'];
    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
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
  /// * [String] id (required):
  ///
  /// * [ArtPieceDetail] data (required):
  Future<InlineResponse2001> artArtPieceUpdate(
    String id,
    ArtPieceDetail data,
  ) async {
    final response = await artArtPieceUpdateWithHttpInfo(
      id,
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
        'InlineResponse2001',
      ) as InlineResponse2001;
    }
    return Future<InlineResponse2001>.value();
  }
}