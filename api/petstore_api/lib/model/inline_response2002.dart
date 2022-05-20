//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart = 2.8

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InlineResponse2002 {
  /// Returns a new [InlineResponse2002] instance.
  InlineResponse2002({
    this.like = true,
  });

  bool like;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineResponse2002 && other.like == like;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (like == null ? 0 : like.hashCode);

  @override
  String toString() => 'InlineResponse2002[like=$like]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (like != null) {
      json[r'like'] = like;
    }
    return json;
  }

  /// Returns a new [InlineResponse2002] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InlineResponse2002 fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();
      return InlineResponse2002(
        like: mapValueOfType<bool>(json, r'like'),
      );
    }
    return null;
  }

  static List<InlineResponse2002> listFromJson(
    dynamic json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json is List && json.isNotEmpty
          ? json
              .map(InlineResponse2002.fromJson)
              .toList(growable: true == growable)
          : true == emptyIsNull
              ? null
              : <InlineResponse2002>[];

  static Map<String, InlineResponse2002> mapFromJson(dynamic json) {
    final map = <String, InlineResponse2002>{};
    if (json is Map && json.isNotEmpty) {
      json.cast<String, dynamic>().forEach((key, dynamic value) =>
          map[key] = InlineResponse2002.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of InlineResponse2002-objects as value to a dart map
  static Map<String, List<InlineResponse2002>> mapListFromJson(
    dynamic json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<InlineResponse2002>>{};
    if (json is Map && json.isNotEmpty) {
      json.cast<String, dynamic>().forEach((key, dynamic value) {
        map[key] = InlineResponse2002.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
