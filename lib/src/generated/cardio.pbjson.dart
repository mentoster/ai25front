//
//  Generated code. Do not modify.
//  source: cardio.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use cardioRequestDescriptor instead')
const CardioRequest$json = {
  '1': 'CardioRequest',
  '2': [
    {'1': 'client_id', '3': 1, '4': 1, '5': 9, '10': 'clientId'},
  ],
};

/// Descriptor for `CardioRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardioRequestDescriptor = $convert.base64Decode(
    'Cg1DYXJkaW9SZXF1ZXN0EhsKCWNsaWVudF9pZBgBIAEoCVIIY2xpZW50SWQ=');

@$core.Deprecated('Use cardioDataDescriptor instead')
const CardioData$json = {
  '1': 'CardioData',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 5, '10': 'timestamp'},
    {'1': 'vector', '3': 2, '4': 3, '5': 2, '10': 'vector'},
  ],
};

/// Descriptor for `CardioData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardioDataDescriptor = $convert.base64Decode(
    'CgpDYXJkaW9EYXRhEhwKCXRpbWVzdGFtcBgBIAEoBVIJdGltZXN0YW1wEhYKBnZlY3RvchgCIA'
    'MoAlIGdmVjdG9y');

@$core.Deprecated('Use setWorkingDirectoryRequestDescriptor instead')
const SetWorkingDirectoryRequest$json = {
  '1': 'SetWorkingDirectoryRequest',
  '2': [
    {'1': 'working_directory', '3': 1, '4': 1, '5': 9, '10': 'workingDirectory'},
  ],
};

/// Descriptor for `SetWorkingDirectoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setWorkingDirectoryRequestDescriptor = $convert.base64Decode(
    'ChpTZXRXb3JraW5nRGlyZWN0b3J5UmVxdWVzdBIrChF3b3JraW5nX2RpcmVjdG9yeRgBIAEoCV'
    'IQd29ya2luZ0RpcmVjdG9yeQ==');

