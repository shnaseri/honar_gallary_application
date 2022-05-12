// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger1.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Swagger1 extends Swagger1 {
  _$Swagger1([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Swagger1;

  @override
  Future<Response<ArtArtPieceCoverPost$Response>> _artArtPieceCoverPost(
      {required ArtPieceCover? data}) {
    final $url = '/art/art-piece/cover/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<ArtArtPieceCoverPost$Response,
        ArtArtPieceCoverPost$Response>($request);
  }

  @override
  Future<Response<ArtPiece>> _artArtPieceIdGet({required String? id}) {
    final $url = '/art/art-piece/${id}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ArtPiece, ArtPiece>($request);
  }

  @override
  Future<Response<ArtArtPieceIdPut$Response>> _artArtPieceIdPut(
      {required ArtPieceDetail? data, required String? id}) {
    final $url = '/art/art-piece/${id}/';
    final $body = data;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client
        .send<ArtArtPieceIdPut$Response, ArtArtPieceIdPut$Response>($request);
  }

  @override
  Future<Response<ArtArtPieceIdContentPut$Response>> _artArtPieceIdContentPut(
      {required List<String>? file, required String? id}) {
    final $url = '/art/art-piece/${id}/content/';
    final $body = <String, dynamic>{'file': file};
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<ArtArtPieceIdContentPut$Response,
        ArtArtPieceIdContentPut$Response>($request);
  }

  @override
  Future<Response<ArtArtPieceIdLikePut$Response>> _artArtPieceIdLikePut(
      {required String? id}) {
    final $url = '/art/art-piece/${id}/like/';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<ArtArtPieceIdLikePut$Response,
        ArtArtPieceIdLikePut$Response>($request);
  }

  @override
  Future<Response<AccessRefresh>> _authLoginPost(
      {required TokenObtainPair? data}) {
    final $url = '/auth/login/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AccessRefresh, AccessRefresh>($request);
  }

  @override
  Future<Response<TokenRefresh>> _authLogoutPost(
      {required TokenRefresh? data}) {
    final $url = '/auth/logout/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<TokenRefresh, TokenRefresh>($request);
  }

  @override
  Future<Response<UserId>> _authRegisterPost({required Register? data}) {
    final $url = '/auth/register/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<UserId, UserId>($request);
  }

  @override
  Future<Response<TokenVerify>> _authVerifyPost({required TokenVerify? data}) {
    final $url = '/auth/verify/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<TokenVerify, TokenVerify>($request);
  }

  @override
  Future<Response<List<ImageSerializer>>> _coreImageUploadGet() {
    final $url = '/core/image/upload/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<ImageSerializer>, ImageSerializer>($request);
  }

  @override
  Future<Response<ImageSerializer>> _coreImageUploadPost(
      {required ImageSerializer? data}) {
    final $url = '/core/image/upload/';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<ImageSerializer, ImageSerializer>($request);
  }

  @override
  Future<Response<ImageSerializer>> _coreImageUploadIdGet({required int? id}) {
    final $url = '/core/image/upload/${id}/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<ImageSerializer, ImageSerializer>($request);
  }

  @override
  Future<Response<ImageSerializer>> _coreImageUploadIdPut(
      {required ImageSerializer? data, required int? id}) {
    final $url = '/core/image/upload/${id}/';
    final $body = data;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<ImageSerializer, ImageSerializer>($request);
  }

  @override
  Future<Response<ImageSerializer>> _coreImageUploadIdPatch(
      {required ImageSerializer? data, required int? id}) {
    final $url = '/core/image/upload/${id}/';
    final $body = data;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<ImageSerializer, ImageSerializer>($request);
  }

  @override
  Future<Response<dynamic>> _coreImageUploadIdDelete({required int? id}) {
    final $url = '/core/image/upload/${id}/';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
