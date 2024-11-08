//
//  Generated code. Do not modify.
//  source: cardio.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CardioRequest extends $pb.GeneratedMessage {
  factory CardioRequest({
    $core.String? clientId,
  }) {
    final $result = create();
    if (clientId != null) {
      $result.clientId = clientId;
    }
    return $result;
  }
  CardioRequest._() : super();
  factory CardioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CardioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CardioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CardioRequest clone() => CardioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CardioRequest copyWith(void Function(CardioRequest) updates) => super.copyWith((message) => updates(message as CardioRequest)) as CardioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CardioRequest create() => CardioRequest._();
  CardioRequest createEmptyInstance() => create();
  static $pb.PbList<CardioRequest> createRepeated() => $pb.PbList<CardioRequest>();
  @$core.pragma('dart2js:noInline')
  static CardioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CardioRequest>(create);
  static CardioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => clearField(1);
}

class CardioData extends $pb.GeneratedMessage {
  factory CardioData({
    $core.int? timestamp,
    $core.Iterable<$core.double>? vector,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (vector != null) {
      $result.vector.addAll(vector);
    }
    return $result;
  }
  CardioData._() : super();
  factory CardioData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CardioData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CardioData', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.O3)
    ..p<$core.double>(2, _omitFieldNames ? '' : 'vector', $pb.PbFieldType.KF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CardioData clone() => CardioData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CardioData copyWith(void Function(CardioData) updates) => super.copyWith((message) => updates(message as CardioData)) as CardioData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CardioData create() => CardioData._();
  CardioData createEmptyInstance() => create();
  static $pb.PbList<CardioData> createRepeated() => $pb.PbList<CardioData>();
  @$core.pragma('dart2js:noInline')
  static CardioData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CardioData>(create);
  static CardioData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get timestamp => $_getIZ(0);
  @$pb.TagNumber(1)
  set timestamp($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.double> get vector => $_getList(1);
}

class SetWorkingDirectoryRequest extends $pb.GeneratedMessage {
  factory SetWorkingDirectoryRequest({
    $core.String? workingDirectory,
  }) {
    final $result = create();
    if (workingDirectory != null) {
      $result.workingDirectory = workingDirectory;
    }
    return $result;
  }
  SetWorkingDirectoryRequest._() : super();
  factory SetWorkingDirectoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetWorkingDirectoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetWorkingDirectoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workingDirectory')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetWorkingDirectoryRequest clone() => SetWorkingDirectoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetWorkingDirectoryRequest copyWith(void Function(SetWorkingDirectoryRequest) updates) => super.copyWith((message) => updates(message as SetWorkingDirectoryRequest)) as SetWorkingDirectoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetWorkingDirectoryRequest create() => SetWorkingDirectoryRequest._();
  SetWorkingDirectoryRequest createEmptyInstance() => create();
  static $pb.PbList<SetWorkingDirectoryRequest> createRepeated() => $pb.PbList<SetWorkingDirectoryRequest>();
  @$core.pragma('dart2js:noInline')
  static SetWorkingDirectoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetWorkingDirectoryRequest>(create);
  static SetWorkingDirectoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workingDirectory => $_getSZ(0);
  @$pb.TagNumber(1)
  set workingDirectory($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkingDirectory() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkingDirectory() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
