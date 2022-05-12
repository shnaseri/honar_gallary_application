import 'package:json_annotation/json_annotation.dart';

enum ArtPieceCoverType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('M')
  m,
  @JsonValue('V')
  v,
  @JsonValue('P')
  p
}

const $ArtPieceCoverTypeMap = {
  ArtPieceCoverType.m: 'M',
  ArtPieceCoverType.v: 'V',
  ArtPieceCoverType.p: 'P'
};
