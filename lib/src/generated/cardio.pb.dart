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
  factory CardioRequest() => create();
  CardioRequest._() : super();
  factory CardioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CardioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CardioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
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
}

class CardioData extends $pb.GeneratedMessage {
  factory CardioData({
    $core.Iterable<$core.int>? timestamp,
    $core.Iterable<$core.double>? vector1,
    $core.Iterable<$core.double>? vector2,
    $core.Iterable<$core.double>? vector3,
    $core.String? annotation,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp.addAll(timestamp);
    }
    if (vector1 != null) {
      $result.vector1.addAll(vector1);
    }
    if (vector2 != null) {
      $result.vector2.addAll(vector2);
    }
    if (vector3 != null) {
      $result.vector3.addAll(vector3);
    }
    if (annotation != null) {
      $result.annotation = annotation;
    }
    return $result;
  }
  CardioData._() : super();
  factory CardioData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CardioData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CardioData', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.K3)
    ..p<$core.double>(2, _omitFieldNames ? '' : 'vector1', $pb.PbFieldType.KF)
    ..p<$core.double>(3, _omitFieldNames ? '' : 'vector2', $pb.PbFieldType.KF)
    ..p<$core.double>(4, _omitFieldNames ? '' : 'vector3', $pb.PbFieldType.KF)
    ..aOS(5, _omitFieldNames ? '' : 'annotation')
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
  $core.List<$core.int> get timestamp => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.double> get vector1 => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.double> get vector2 => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.double> get vector3 => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get annotation => $_getSZ(4);
  @$pb.TagNumber(5)
  set annotation($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAnnotation() => $_has(4);
  @$pb.TagNumber(5)
  void clearAnnotation() => clearField(5);
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

class SetWorkingDirectoryResponse extends $pb.GeneratedMessage {
  factory SetWorkingDirectoryResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  SetWorkingDirectoryResponse._() : super();
  factory SetWorkingDirectoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetWorkingDirectoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetWorkingDirectoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetWorkingDirectoryResponse clone() => SetWorkingDirectoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetWorkingDirectoryResponse copyWith(void Function(SetWorkingDirectoryResponse) updates) => super.copyWith((message) => updates(message as SetWorkingDirectoryResponse)) as SetWorkingDirectoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetWorkingDirectoryResponse create() => SetWorkingDirectoryResponse._();
  SetWorkingDirectoryResponse createEmptyInstance() => create();
  static $pb.PbList<SetWorkingDirectoryResponse> createRepeated() => $pb.PbList<SetWorkingDirectoryResponse>();
  @$core.pragma('dart2js:noInline')
  static SetWorkingDirectoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetWorkingDirectoryResponse>(create);
  static SetWorkingDirectoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class SetFileToProcessRequest extends $pb.GeneratedMessage {
  factory SetFileToProcessRequest({
    $core.String? fileToProcess,
  }) {
    final $result = create();
    if (fileToProcess != null) {
      $result.fileToProcess = fileToProcess;
    }
    return $result;
  }
  SetFileToProcessRequest._() : super();
  factory SetFileToProcessRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetFileToProcessRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetFileToProcessRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileToProcess')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetFileToProcessRequest clone() => SetFileToProcessRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetFileToProcessRequest copyWith(void Function(SetFileToProcessRequest) updates) => super.copyWith((message) => updates(message as SetFileToProcessRequest)) as SetFileToProcessRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFileToProcessRequest create() => SetFileToProcessRequest._();
  SetFileToProcessRequest createEmptyInstance() => create();
  static $pb.PbList<SetFileToProcessRequest> createRepeated() => $pb.PbList<SetFileToProcessRequest>();
  @$core.pragma('dart2js:noInline')
  static SetFileToProcessRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFileToProcessRequest>(create);
  static SetFileToProcessRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileToProcess => $_getSZ(0);
  @$pb.TagNumber(1)
  set fileToProcess($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileToProcess() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileToProcess() => clearField(1);
}

class SetFileToProcessResponse extends $pb.GeneratedMessage {
  factory SetFileToProcessResponse({
    $core.bool? success,
    $core.String? age,
    $core.bool? pharm,
    $core.bool? isMale,
    $core.String? label1,
    $core.String? label2,
    $core.String? label3,
    $core.bool? isAnnotated,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (age != null) {
      $result.age = age;
    }
    if (pharm != null) {
      $result.pharm = pharm;
    }
    if (isMale != null) {
      $result.isMale = isMale;
    }
    if (label1 != null) {
      $result.label1 = label1;
    }
    if (label2 != null) {
      $result.label2 = label2;
    }
    if (label3 != null) {
      $result.label3 = label3;
    }
    if (isAnnotated != null) {
      $result.isAnnotated = isAnnotated;
    }
    return $result;
  }
  SetFileToProcessResponse._() : super();
  factory SetFileToProcessResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetFileToProcessResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetFileToProcessResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'cardio'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'age')
    ..aOB(3, _omitFieldNames ? '' : 'pharm')
    ..aOB(4, _omitFieldNames ? '' : 'isMale')
    ..aOS(5, _omitFieldNames ? '' : 'label1')
    ..aOS(6, _omitFieldNames ? '' : 'label2')
    ..aOS(7, _omitFieldNames ? '' : 'label3')
    ..aOB(8, _omitFieldNames ? '' : 'isAnnotated')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetFileToProcessResponse clone() => SetFileToProcessResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetFileToProcessResponse copyWith(void Function(SetFileToProcessResponse) updates) => super.copyWith((message) => updates(message as SetFileToProcessResponse)) as SetFileToProcessResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetFileToProcessResponse create() => SetFileToProcessResponse._();
  SetFileToProcessResponse createEmptyInstance() => create();
  static $pb.PbList<SetFileToProcessResponse> createRepeated() => $pb.PbList<SetFileToProcessResponse>();
  @$core.pragma('dart2js:noInline')
  static SetFileToProcessResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetFileToProcessResponse>(create);
  static SetFileToProcessResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get age => $_getSZ(1);
  @$pb.TagNumber(2)
  set age($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAge() => $_has(1);
  @$pb.TagNumber(2)
  void clearAge() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get pharm => $_getBF(2);
  @$pb.TagNumber(3)
  set pharm($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPharm() => $_has(2);
  @$pb.TagNumber(3)
  void clearPharm() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isMale => $_getBF(3);
  @$pb.TagNumber(4)
  set isMale($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsMale() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsMale() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get label1 => $_getSZ(4);
  @$pb.TagNumber(5)
  set label1($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLabel1() => $_has(4);
  @$pb.TagNumber(5)
  void clearLabel1() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get label2 => $_getSZ(5);
  @$pb.TagNumber(6)
  set label2($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLabel2() => $_has(5);
  @$pb.TagNumber(6)
  void clearLabel2() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get label3 => $_getSZ(6);
  @$pb.TagNumber(7)
  set label3($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLabel3() => $_has(6);
  @$pb.TagNumber(7)
  void clearLabel3() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isAnnotated => $_getBF(7);
  @$pb.TagNumber(8)
  set isAnnotated($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsAnnotated() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsAnnotated() => clearField(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
