// ignore_for_file: type=lint

import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'client_mapping.dart';
import 'swagger1.enums.swagger.dart' as enums;

export 'swagger1.enums.swagger.dart';

part 'swagger1.swagger.chopper.dart';

part 'swagger1.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger1 extends ChopperService {
  static Swagger1 create(
      {ChopperClient? client,
      Authenticator? authenticator,
      String? baseUrl,
      Iterable<dynamic>? interceptors}) {
    if (client != null) {
      return _$Swagger1(client);
    }

    final newClient = ChopperClient(
        services: [_$Swagger1()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        authenticator: authenticator,
        baseUrl: baseUrl ?? 'http://188.121.110.151:8000/api');
    return _$Swagger1(newClient);
  }

  ///
  ///@param data
  Future<chopper.Response<ArtArtPieceCoverPost$Response>> artArtPieceCoverPost(
      {required ArtPieceCover? data}) {
    generatedMapping.putIfAbsent(
        ArtPieceCover, () => ArtPieceCover.fromJsonFactory);

    return _artArtPieceCoverPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/art/art-piece/cover/')
  Future<chopper.Response<ArtArtPieceCoverPost$Response>> _artArtPieceCoverPost(
      {@Body() required ArtPieceCover? data});

  ///
  Future<chopper.Response<ArtPiece>> artArtPieceIdGet({required String? id}) {
    generatedMapping.putIfAbsent(ArtPiece, () => ArtPiece.fromJsonFactory);

    return _artArtPieceIdGet(id: id);
  }

  ///
  @Get(path: '/art/art-piece/{id}/')
  Future<chopper.Response<ArtPiece>> _artArtPieceIdGet(
      {@Path('id') required String? id});

  ///
  ///@param data
  Future<chopper.Response<ArtArtPieceIdPut$Response>> artArtPieceIdPut(
      {required ArtPieceDetail? data, required String? id}) {
    generatedMapping.putIfAbsent(
        ArtPieceDetail, () => ArtPieceDetail.fromJsonFactory);

    return _artArtPieceIdPut(data: data, id: id);
  }

  ///
  ///@param data
  @Put(path: '/art/art-piece/{id}/')
  Future<chopper.Response<ArtArtPieceIdPut$Response>> _artArtPieceIdPut(
      {@Body() required ArtPieceDetail? data, @Path('id') required String? id});

  ///
  ///@param file
  Future<chopper.Response<ArtArtPieceIdContentPut$Response>>
      artArtPieceIdContentPut(
          {required List<String>? file, required String? id}) {
    return _artArtPieceIdContentPut(file: file, id: id);
  }

  ///
  ///@param file
  @Put(path: '/art/art-piece/{id}/content/', optionalBody: true)
  Future<chopper.Response<ArtArtPieceIdContentPut$Response>>
      _artArtPieceIdContentPut(
          {@Field('file') required List<String>? file,
          @Path('id') required String? id});

  ///
  Future<chopper.Response<ArtArtPieceIdLikePut$Response>> artArtPieceIdLikePut(
      {required String? id}) {
    return _artArtPieceIdLikePut(id: id);
  }

  ///
  @Put(path: '/art/art-piece/{id}/like/', optionalBody: true)
  Future<chopper.Response<ArtArtPieceIdLikePut$Response>> _artArtPieceIdLikePut(
      {@Path('id') required String? id});

  ///
  ///@param data
  Future<chopper.Response<AccessRefresh>> authLoginPost(
      {required TokenObtainPair? data}) {
    generatedMapping.putIfAbsent(
        TokenObtainPair, () => TokenObtainPair.fromJsonFactory);
    generatedMapping.putIfAbsent(
        AccessRefresh, () => AccessRefresh.fromJsonFactory);

    return _authLoginPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/auth/login/')
  Future<chopper.Response<AccessRefresh>> _authLoginPost(
      {@Body() required TokenObtainPair? data});

  ///
  ///@param data
  Future<chopper.Response<TokenRefresh>> authLogoutPost(
      {required TokenRefresh? data}) {
    generatedMapping.putIfAbsent(
        TokenRefresh, () => TokenRefresh.fromJsonFactory);

    return _authLogoutPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/auth/logout/')
  Future<chopper.Response<TokenRefresh>> _authLogoutPost(
      {@Body() required TokenRefresh? data});

  ///
  ///@param data
  Future<chopper.Response<UserId>> authRegisterPost({required Register? data}) {
    generatedMapping.putIfAbsent(Register, () => Register.fromJsonFactory);
    generatedMapping.putIfAbsent(UserId, () => UserId.fromJsonFactory);

    return _authRegisterPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/auth/register/')
  Future<chopper.Response<UserId>> _authRegisterPost(
      {@Body() required Register? data});

  ///
  ///@param data
  Future<chopper.Response<TokenVerify>> authVerifyPost(
      {required TokenVerify? data}) {
    generatedMapping.putIfAbsent(
        TokenVerify, () => TokenVerify.fromJsonFactory);

    return _authVerifyPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/auth/verify/')
  Future<chopper.Response<TokenVerify>> _authVerifyPost(
      {@Body() required TokenVerify? data});

  ///
  Future<chopper.Response<List<ImageSerializer>>> coreImageUploadGet() {
    generatedMapping.putIfAbsent(
        ImageSerializer, () => ImageSerializer.fromJsonFactory);

    return _coreImageUploadGet();
  }

  ///
  @Get(path: '/core/image/upload/')
  Future<chopper.Response<List<ImageSerializer>>> _coreImageUploadGet();

  ///
  ///@param data
  Future<chopper.Response<ImageSerializer>> coreImageUploadPost(
      {required ImageSerializer? data}) {
    generatedMapping.putIfAbsent(
        ImageSerializer, () => ImageSerializer.fromJsonFactory);

    return _coreImageUploadPost(data: data);
  }

  ///
  ///@param data
  @Post(path: '/core/image/upload/')
  Future<chopper.Response<ImageSerializer>> _coreImageUploadPost(
      {@Body() required ImageSerializer? data});

  ///
  Future<chopper.Response<ImageSerializer>> coreImageUploadIdGet(
      {required int? id}) {
    generatedMapping.putIfAbsent(
        ImageSerializer, () => ImageSerializer.fromJsonFactory);

    return _coreImageUploadIdGet(id: id);
  }

  ///
  @Get(path: '/core/image/upload/{id}/')
  Future<chopper.Response<ImageSerializer>> _coreImageUploadIdGet(
      {@Path('id') required int? id});

  ///
  ///@param data
  Future<chopper.Response<ImageSerializer>> coreImageUploadIdPut(
      {required ImageSerializer? data, required int? id}) {
    generatedMapping.putIfAbsent(
        ImageSerializer, () => ImageSerializer.fromJsonFactory);

    return _coreImageUploadIdPut(data: data, id: id);
  }

  ///
  ///@param data
  @Put(path: '/core/image/upload/{id}/')
  Future<chopper.Response<ImageSerializer>> _coreImageUploadIdPut(
      {@Body() required ImageSerializer? data, @Path('id') required int? id});

  ///
  ///@param data
  Future<chopper.Response<ImageSerializer>> coreImageUploadIdPatch(
      {required ImageSerializer? data, required int? id}) {
    generatedMapping.putIfAbsent(
        ImageSerializer, () => ImageSerializer.fromJsonFactory);

    return _coreImageUploadIdPatch(data: data, id: id);
  }

  ///
  ///@param data
  @Patch(path: '/core/image/upload/{id}/')
  Future<chopper.Response<ImageSerializer>> _coreImageUploadIdPatch(
      {@Body() required ImageSerializer? data, @Path('id') required int? id});

  ///
  Future<chopper.Response> coreImageUploadIdDelete({required int? id}) {
    return _coreImageUploadIdDelete(id: id);
  }

  ///
  @Delete(path: '/core/image/upload/{id}/')
  Future<chopper.Response> _coreImageUploadIdDelete(
      {@Path('id') required int? id});
}

@JsonSerializable(explicitToJson: true)
class ArtPieceCover {
  ArtPieceCover({
    required this.cover,
    this.type,
  });

  factory ArtPieceCover.fromJson(Map<String, dynamic> json) =>
      _$ArtPieceCoverFromJson(json);

  @JsonKey(name: 'cover', defaultValue: 36)
  final int cover;
  @JsonKey(
      name: 'type',
      toJson: artPieceCoverTypeToJson,
      fromJson: artPieceCoverTypeTypeFromJson)
  final enums.ArtPieceCoverType? type;

  static enums.ArtPieceCoverType artPieceCoverTypeTypeFromJson(Object? value) =>
      artPieceCoverTypeFromJson(value, enums.ArtPieceCoverType.p);

  static const fromJsonFactory = _$ArtPieceCoverFromJson;
  static const toJsonFactory = _$ArtPieceCoverToJson;

  Map<String, dynamic> toJson() => _$ArtPieceCoverToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtPieceCover &&
            (identical(other.cover, cover) ||
                const DeepCollectionEquality().equals(other.cover, cover)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cover) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $ArtPieceCoverExtension on ArtPieceCover {
  ArtPieceCover copyWith({int? cover, enums.ArtPieceCoverType? type}) {
    return ArtPieceCover(cover: cover ?? this.cover, type: type ?? this.type);
  }
}

@JsonSerializable(explicitToJson: true)
class ImageSerializer {
  ImageSerializer({
    this.id,
    this.image,
  });

  factory ImageSerializer.fromJson(Map<String, dynamic> json) =>
      _$ImageSerializerFromJson(json);

  @JsonKey(name: 'id', defaultValue: 36)
  final int? id;
  @JsonKey(name: 'image', defaultValue: 'defaut')
  final String? image;
  static const fromJsonFactory = _$ImageSerializerFromJson;
  static const toJsonFactory = _$ImageSerializerToJson;

  Map<String, dynamic> toJson() => _$ImageSerializerToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ImageSerializer &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(image) ^
      runtimeType.hashCode;
}

extension $ImageSerializerExtension on ImageSerializer {
  ImageSerializer copyWith({int? id, String? image}) {
    return ImageSerializer(id: id ?? this.id, image: image ?? this.image);
  }
}

@JsonSerializable(explicitToJson: true)
class User {
  User({
    this.id,
    this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: 'id', defaultValue: 36)
  final int? id;
  @JsonKey(name: 'full_name', defaultValue: 'defaut')
  final String? fullName;
  static const fromJsonFactory = _$UserFromJson;
  static const toJsonFactory = _$UserToJson;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(fullName) ^
      runtimeType.hashCode;
}

extension $UserExtension on User {
  User copyWith({int? id, String? fullName}) {
    return User(id: id ?? this.id, fullName: fullName ?? this.fullName);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtPiece {
  ArtPiece({
    this.id,
    this.title,
    this.price,
    this.description,
    required this.cover,
    required this.owner,
    this.likeCount,
    this.type,
    this.isUserLiked,
    this.url,
  });

  factory ArtPiece.fromJson(Map<String, dynamic> json) =>
      _$ArtPieceFromJson(json);

  @JsonKey(name: 'id', defaultValue: 36)
  final int? id;
  @JsonKey(name: 'title', defaultValue: 'defaut')
  final String? title;
  @JsonKey(name: 'price', defaultValue: 36)
  final int? price;
  @JsonKey(name: 'description', defaultValue: 'defaut')
  final String? description;
  @JsonKey(name: 'cover')
  final ImageSerializer cover;
  @JsonKey(name: 'owner')
  final User owner;
  @JsonKey(name: 'like_count', defaultValue: 'defaut')
  final String? likeCount;
  @JsonKey(name: 'type', defaultValue: 'defaut')
  final String? type;
  @JsonKey(name: 'is_user_liked', defaultValue: 'defaut')
  final String? isUserLiked;
  @JsonKey(name: 'url', defaultValue: 'defaut')
  final String? url;
  static const fromJsonFactory = _$ArtPieceFromJson;
  static const toJsonFactory = _$ArtPieceToJson;

  Map<String, dynamic> toJson() => _$ArtPieceToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtPiece &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.cover, cover) ||
                const DeepCollectionEquality().equals(other.cover, cover)) &&
            (identical(other.owner, owner) ||
                const DeepCollectionEquality().equals(other.owner, owner)) &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality()
                    .equals(other.likeCount, likeCount)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isUserLiked, isUserLiked) ||
                const DeepCollectionEquality()
                    .equals(other.isUserLiked, isUserLiked)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(cover) ^
      const DeepCollectionEquality().hash(owner) ^
      const DeepCollectionEquality().hash(likeCount) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isUserLiked) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $ArtPieceExtension on ArtPiece {
  ArtPiece copyWith(
      {int? id,
      String? title,
      int? price,
      String? description,
      ImageSerializer? cover,
      User? owner,
      String? likeCount,
      String? type,
      String? isUserLiked,
      String? url}) {
    return ArtPiece(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        cover: cover ?? this.cover,
        owner: owner ?? this.owner,
        likeCount: likeCount ?? this.likeCount,
        type: type ?? this.type,
        isUserLiked: isUserLiked ?? this.isUserLiked,
        url: url ?? this.url);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtPieceDetail {
  ArtPieceDetail({
    required this.price,
    required this.title,
    required this.description,
  });

  factory ArtPieceDetail.fromJson(Map<String, dynamic> json) =>
      _$ArtPieceDetailFromJson(json);

  @JsonKey(name: 'price', defaultValue: 36)
  final int price;
  @JsonKey(name: 'title', defaultValue: 'defaut')
  final String title;
  @JsonKey(name: 'description', defaultValue: 'defaut')
  final String description;
  static const fromJsonFactory = _$ArtPieceDetailFromJson;
  static const toJsonFactory = _$ArtPieceDetailToJson;

  Map<String, dynamic> toJson() => _$ArtPieceDetailToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtPieceDetail &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $ArtPieceDetailExtension on ArtPieceDetail {
  ArtPieceDetail copyWith({int? price, String? title, String? description}) {
    return ArtPieceDetail(
        price: price ?? this.price,
        title: title ?? this.title,
        description: description ?? this.description);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenObtainPair {
  TokenObtainPair({
    required this.email,
    required this.password,
  });

  factory TokenObtainPair.fromJson(Map<String, dynamic> json) =>
      _$TokenObtainPairFromJson(json);

  @JsonKey(name: 'email', defaultValue: 'defaut')
  final String email;
  @JsonKey(name: 'password', defaultValue: 'defaut')
  final String password;
  static const fromJsonFactory = _$TokenObtainPairFromJson;
  static const toJsonFactory = _$TokenObtainPairToJson;

  Map<String, dynamic> toJson() => _$TokenObtainPairToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenObtainPair &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $TokenObtainPairExtension on TokenObtainPair {
  TokenObtainPair copyWith({String? email, String? password}) {
    return TokenObtainPair(
        email: email ?? this.email, password: password ?? this.password);
  }
}

@JsonSerializable(explicitToJson: true)
class AccessRefresh {
  AccessRefresh({
    required this.access,
    required this.refresh,
  });

  factory AccessRefresh.fromJson(Map<String, dynamic> json) =>
      _$AccessRefreshFromJson(json);

  @JsonKey(name: 'access', defaultValue: 'defaut')
  final String access;
  @JsonKey(name: 'refresh', defaultValue: 'defaut')
  final String refresh;
  static const fromJsonFactory = _$AccessRefreshFromJson;
  static const toJsonFactory = _$AccessRefreshToJson;

  Map<String, dynamic> toJson() => _$AccessRefreshToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AccessRefresh &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)) &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(access) ^
      const DeepCollectionEquality().hash(refresh) ^
      runtimeType.hashCode;
}

extension $AccessRefreshExtension on AccessRefresh {
  AccessRefresh copyWith({String? access, String? refresh}) {
    return AccessRefresh(
        access: access ?? this.access, refresh: refresh ?? this.refresh);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenRefresh {
  TokenRefresh({
    required this.refresh,
    this.access,
  });

  factory TokenRefresh.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshFromJson(json);

  @JsonKey(name: 'refresh', defaultValue: 'defaut')
  final String refresh;
  @JsonKey(name: 'access', defaultValue: 'defaut')
  final String? access;
  static const fromJsonFactory = _$TokenRefreshFromJson;
  static const toJsonFactory = _$TokenRefreshToJson;

  Map<String, dynamic> toJson() => _$TokenRefreshToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenRefresh &&
            (identical(other.refresh, refresh) ||
                const DeepCollectionEquality()
                    .equals(other.refresh, refresh)) &&
            (identical(other.access, access) ||
                const DeepCollectionEquality().equals(other.access, access)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(refresh) ^
      const DeepCollectionEquality().hash(access) ^
      runtimeType.hashCode;
}

extension $TokenRefreshExtension on TokenRefresh {
  TokenRefresh copyWith({String? refresh, String? access}) {
    return TokenRefresh(
        refresh: refresh ?? this.refresh, access: access ?? this.access);
  }
}

@JsonSerializable(explicitToJson: true)
class Register {
  Register({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  @JsonKey(name: 'email', defaultValue: 'defaut')
  final String email;
  @JsonKey(name: 'password', defaultValue: 'defaut')
  final String password;
  @JsonKey(name: 'first_name', defaultValue: 'defaut')
  final String firstName;
  @JsonKey(name: 'last_name', defaultValue: 'defaut')
  final String lastName;
  static const fromJsonFactory = _$RegisterFromJson;
  static const toJsonFactory = _$RegisterToJson;

  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Register &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      runtimeType.hashCode;
}

extension $RegisterExtension on Register {
  Register copyWith(
      {String? email, String? password, String? firstName, String? lastName}) {
    return Register(
        email: email ?? this.email,
        password: password ?? this.password,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName);
  }
}

@JsonSerializable(explicitToJson: true)
class UserId {
  UserId({
    this.id,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);

  @JsonKey(name: 'id', defaultValue: 36)
  final int? id;
  static const fromJsonFactory = _$UserIdFromJson;
  static const toJsonFactory = _$UserIdToJson;

  Map<String, dynamic> toJson() => _$UserIdToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserId &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $UserIdExtension on UserId {
  UserId copyWith({int? id}) {
    return UserId(id: id ?? this.id);
  }
}

@JsonSerializable(explicitToJson: true)
class TokenVerify {
  TokenVerify({
    required this.token,
  });

  factory TokenVerify.fromJson(Map<String, dynamic> json) =>
      _$TokenVerifyFromJson(json);

  @JsonKey(name: 'token', defaultValue: 'defaut')
  final String token;
  static const fromJsonFactory = _$TokenVerifyFromJson;
  static const toJsonFactory = _$TokenVerifyToJson;

  Map<String, dynamic> toJson() => _$TokenVerifyToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TokenVerify &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^ runtimeType.hashCode;
}

extension $TokenVerifyExtension on TokenVerify {
  TokenVerify copyWith({String? token}) {
    return TokenVerify(token: token ?? this.token);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtArtPieceCoverPost$Response {
  ArtArtPieceCoverPost$Response({
    this.artPieceId,
  });

  factory ArtArtPieceCoverPost$Response.fromJson(Map<String, dynamic> json) =>
      _$ArtArtPieceCoverPost$ResponseFromJson(json);

  @JsonKey(name: 'art_piece_id', defaultValue: 36)
  final int? artPieceId;
  static const fromJsonFactory = _$ArtArtPieceCoverPost$ResponseFromJson;
  static const toJsonFactory = _$ArtArtPieceCoverPost$ResponseToJson;

  Map<String, dynamic> toJson() => _$ArtArtPieceCoverPost$ResponseToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtArtPieceCoverPost$Response &&
            (identical(other.artPieceId, artPieceId) ||
                const DeepCollectionEquality()
                    .equals(other.artPieceId, artPieceId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(artPieceId) ^ runtimeType.hashCode;
}

extension $ArtArtPieceCoverPost$ResponseExtension
    on ArtArtPieceCoverPost$Response {
  ArtArtPieceCoverPost$Response copyWith({int? artPieceId}) {
    return ArtArtPieceCoverPost$Response(
        artPieceId: artPieceId ?? this.artPieceId);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtArtPieceIdPut$Response {
  ArtArtPieceIdPut$Response({
    this.success,
  });

  factory ArtArtPieceIdPut$Response.fromJson(Map<String, dynamic> json) =>
      _$ArtArtPieceIdPut$ResponseFromJson(json);

  @JsonKey(name: 'success', defaultValue: true)
  final bool? success;
  static const fromJsonFactory = _$ArtArtPieceIdPut$ResponseFromJson;
  static const toJsonFactory = _$ArtArtPieceIdPut$ResponseToJson;

  Map<String, dynamic> toJson() => _$ArtArtPieceIdPut$ResponseToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtArtPieceIdPut$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $ArtArtPieceIdPut$ResponseExtension on ArtArtPieceIdPut$Response {
  ArtArtPieceIdPut$Response copyWith({bool? success}) {
    return ArtArtPieceIdPut$Response(success: success ?? this.success);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtArtPieceIdContentPut$Response {
  ArtArtPieceIdContentPut$Response({
    this.success,
  });

  factory ArtArtPieceIdContentPut$Response.fromJson(
          Map<String, dynamic> json) =>
      _$ArtArtPieceIdContentPut$ResponseFromJson(json);

  @JsonKey(name: 'success', defaultValue: true)
  final bool? success;
  static const fromJsonFactory = _$ArtArtPieceIdContentPut$ResponseFromJson;
  static const toJsonFactory = _$ArtArtPieceIdContentPut$ResponseToJson;

  Map<String, dynamic> toJson() =>
      _$ArtArtPieceIdContentPut$ResponseToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtArtPieceIdContentPut$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $ArtArtPieceIdContentPut$ResponseExtension
    on ArtArtPieceIdContentPut$Response {
  ArtArtPieceIdContentPut$Response copyWith({bool? success}) {
    return ArtArtPieceIdContentPut$Response(success: success ?? this.success);
  }
}

@JsonSerializable(explicitToJson: true)
class ArtArtPieceIdLikePut$Response {
  ArtArtPieceIdLikePut$Response({
    this.like,
  });

  factory ArtArtPieceIdLikePut$Response.fromJson(Map<String, dynamic> json) =>
      _$ArtArtPieceIdLikePut$ResponseFromJson(json);

  @JsonKey(name: 'like', defaultValue: true)
  final bool? like;
  static const fromJsonFactory = _$ArtArtPieceIdLikePut$ResponseFromJson;
  static const toJsonFactory = _$ArtArtPieceIdLikePut$ResponseToJson;

  Map<String, dynamic> toJson() => _$ArtArtPieceIdLikePut$ResponseToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ArtArtPieceIdLikePut$Response &&
            (identical(other.like, like) ||
                const DeepCollectionEquality().equals(other.like, like)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(like) ^ runtimeType.hashCode;
}

extension $ArtArtPieceIdLikePut$ResponseExtension
    on ArtArtPieceIdLikePut$Response {
  ArtArtPieceIdLikePut$Response copyWith({bool? like}) {
    return ArtArtPieceIdLikePut$Response(like: like ?? this.like);
  }
}

String? artPieceCoverTypeToJson(enums.ArtPieceCoverType? artPieceCoverType) {
  return enums.$ArtPieceCoverTypeMap[artPieceCoverType];
}

enums.ArtPieceCoverType artPieceCoverTypeFromJson(
  Object? artPieceCoverType, [
  enums.ArtPieceCoverType? defaultValue,
]) {
  if (artPieceCoverType is String) {
    return enums.$ArtPieceCoverTypeMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == artPieceCoverType.toLowerCase(),
            orElse: () => const MapEntry(
                enums.ArtPieceCoverType.swaggerGeneratedUnknown, ''))
        .key;
  }

  final pasredResult = enums.$ArtPieceCoverTypeMap.entries
      .firstWhereOrNull((element) => element.value == defaultValue)
      ?.key;

  return pasredResult ??
      defaultValue ??
      enums.ArtPieceCoverType.swaggerGeneratedUnknown;
}

List<String> artPieceCoverTypeListToJson(
    List<enums.ArtPieceCoverType>? artPieceCoverType) {
  if (artPieceCoverType == null) {
    return [];
  }

  return artPieceCoverType.map((e) => enums.$ArtPieceCoverTypeMap[e]!).toList();
}

List<enums.ArtPieceCoverType> artPieceCoverTypeListFromJson(
  List? artPieceCoverType, [
  List<enums.ArtPieceCoverType>? defaultValue,
]) {
  if (artPieceCoverType == null) {
    return defaultValue ?? [];
  }

  return artPieceCoverType
      .map((e) => artPieceCoverTypeFromJson(e.toString()))
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
