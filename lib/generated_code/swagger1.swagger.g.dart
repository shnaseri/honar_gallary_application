// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swagger1.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtPieceCover _$ArtPieceCoverFromJson(Map<String, dynamic> json) =>
    ArtPieceCover(
      cover: json['cover'] as int? ?? 36,
      type: ArtPieceCover.artPieceCoverTypeTypeFromJson(json['type']),
    );

Map<String, dynamic> _$ArtPieceCoverToJson(ArtPieceCover instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'type': artPieceCoverTypeToJson(instance.type),
    };

ImageSerializer _$ImageSerializerFromJson(Map<String, dynamic> json) =>
    ImageSerializer(
      id: json['id'] as int? ?? 36,
      image: json['image'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$ImageSerializerToJson(ImageSerializer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int? ?? 36,
      fullName: json['full_name'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
    };

ArtPiece _$ArtPieceFromJson(Map<String, dynamic> json) => ArtPiece(
      id: json['id'] as int? ?? 36,
      title: json['title'] as String? ?? 'defaut',
      price: json['price'] as int? ?? 36,
      description: json['description'] as String? ?? 'defaut',
      cover: ImageSerializer.fromJson(json['cover'] as Map<String, dynamic>),
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      likeCount: json['like_count'] as String? ?? 'defaut',
      type: json['type'] as String? ?? 'defaut',
      isUserLiked: json['is_user_liked'] as String? ?? 'defaut',
      url: json['url'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$ArtPieceToJson(ArtPiece instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'cover': instance.cover.toJson(),
      'owner': instance.owner.toJson(),
      'like_count': instance.likeCount,
      'type': instance.type,
      'is_user_liked': instance.isUserLiked,
      'url': instance.url,
    };

ArtPieceDetail _$ArtPieceDetailFromJson(Map<String, dynamic> json) =>
    ArtPieceDetail(
      price: json['price'] as int? ?? 36,
      title: json['title'] as String? ?? 'defaut',
      description: json['description'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$ArtPieceDetailToJson(ArtPieceDetail instance) =>
    <String, dynamic>{
      'price': instance.price,
      'title': instance.title,
      'description': instance.description,
    };

TokenObtainPair _$TokenObtainPairFromJson(Map<String, dynamic> json) =>
    TokenObtainPair(
      email: json['email'] as String? ?? 'defaut',
      password: json['password'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$TokenObtainPairToJson(TokenObtainPair instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

AccessRefresh _$AccessRefreshFromJson(Map<String, dynamic> json) =>
    AccessRefresh(
      access: json['access'] as String? ?? 'defaut',
      refresh: json['refresh'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$AccessRefreshToJson(AccessRefresh instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
    };

TokenRefresh _$TokenRefreshFromJson(Map<String, dynamic> json) => TokenRefresh(
      refresh: json['refresh'] as String? ?? 'defaut',
      access: json['access'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$TokenRefreshToJson(TokenRefresh instance) =>
    <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
    };

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      email: json['email'] as String? ?? 'defaut',
      password: json['password'] as String? ?? 'defaut',
      firstName: json['first_name'] as String? ?? 'defaut',
      lastName: json['last_name'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

UserId _$UserIdFromJson(Map<String, dynamic> json) => UserId(
      id: json['id'] as int? ?? 36,
    );

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      'id': instance.id,
    };

TokenVerify _$TokenVerifyFromJson(Map<String, dynamic> json) => TokenVerify(
      token: json['token'] as String? ?? 'defaut',
    );

Map<String, dynamic> _$TokenVerifyToJson(TokenVerify instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

ArtArtPieceCoverPost$Response _$ArtArtPieceCoverPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    ArtArtPieceCoverPost$Response(
      artPieceId: json['art_piece_id'] as int? ?? 36,
    );

Map<String, dynamic> _$ArtArtPieceCoverPost$ResponseToJson(
        ArtArtPieceCoverPost$Response instance) =>
    <String, dynamic>{
      'art_piece_id': instance.artPieceId,
    };

ArtArtPieceIdPut$Response _$ArtArtPieceIdPut$ResponseFromJson(
        Map<String, dynamic> json) =>
    ArtArtPieceIdPut$Response(
      success: json['success'] as bool? ?? true,
    );

Map<String, dynamic> _$ArtArtPieceIdPut$ResponseToJson(
        ArtArtPieceIdPut$Response instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

ArtArtPieceIdContentPut$Response _$ArtArtPieceIdContentPut$ResponseFromJson(
        Map<String, dynamic> json) =>
    ArtArtPieceIdContentPut$Response(
      success: json['success'] as bool? ?? true,
    );

Map<String, dynamic> _$ArtArtPieceIdContentPut$ResponseToJson(
        ArtArtPieceIdContentPut$Response instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

ArtArtPieceIdLikePut$Response _$ArtArtPieceIdLikePut$ResponseFromJson(
        Map<String, dynamic> json) =>
    ArtArtPieceIdLikePut$Response(
      like: json['like'] as bool? ?? true,
    );

Map<String, dynamic> _$ArtArtPieceIdLikePut$ResponseToJson(
        ArtArtPieceIdLikePut$Response instance) =>
    <String, dynamic>{
      'like': instance.like,
    };
