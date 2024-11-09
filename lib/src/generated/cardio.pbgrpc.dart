//
//  Generated code. Do not modify.
//  source: cardio.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'cardio.pb.dart' as $0;

export 'cardio.pb.dart';

@$pb.GrpcServiceName('cardio.CardioService')
class CardioServiceClient extends $grpc.Client {
  static final _$streamCardioData = $grpc.ClientMethod<$0.CardioRequest, $0.CardioData>(
      '/cardio.CardioService/StreamCardioData',
      ($0.CardioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CardioData.fromBuffer(value));
  static final _$setWorkingDirectory = $grpc.ClientMethod<$0.SetWorkingDirectoryRequest, $0.SetWorkingDirectoryResponse>(
      '/cardio.CardioService/SetWorkingDirectory',
      ($0.SetWorkingDirectoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetWorkingDirectoryResponse.fromBuffer(value));
  static final _$setFileToProcess = $grpc.ClientMethod<$0.SetFileToProcessRequest, $0.SetFileToProcessResponse>(
      '/cardio.CardioService/SetFileToProcess',
      ($0.SetFileToProcessRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SetFileToProcessResponse.fromBuffer(value));
  static final _$streamAnnotatedData = $grpc.ClientMethod<$0.CardioRequest, $0.CardioData>(
      '/cardio.CardioService/StreamAnnotatedData',
      ($0.CardioRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CardioData.fromBuffer(value));

  CardioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.CardioData> streamCardioData($0.CardioRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamCardioData, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.SetWorkingDirectoryResponse> setWorkingDirectory($0.SetWorkingDirectoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setWorkingDirectory, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetFileToProcessResponse> setFileToProcess($0.SetFileToProcessRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setFileToProcess, request, options: options);
  }

  $grpc.ResponseStream<$0.CardioData> streamAnnotatedData($0.CardioRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamAnnotatedData, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('cardio.CardioService')
abstract class CardioServiceBase extends $grpc.Service {
  $core.String get $name => 'cardio.CardioService';

  CardioServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CardioRequest, $0.CardioData>(
        'StreamCardioData',
        streamCardioData_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.CardioRequest.fromBuffer(value),
        ($0.CardioData value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetWorkingDirectoryRequest, $0.SetWorkingDirectoryResponse>(
        'SetWorkingDirectory',
        setWorkingDirectory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetWorkingDirectoryRequest.fromBuffer(value),
        ($0.SetWorkingDirectoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetFileToProcessRequest, $0.SetFileToProcessResponse>(
        'SetFileToProcess',
        setFileToProcess_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SetFileToProcessRequest.fromBuffer(value),
        ($0.SetFileToProcessResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CardioRequest, $0.CardioData>(
        'StreamAnnotatedData',
        streamAnnotatedData_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.CardioRequest.fromBuffer(value),
        ($0.CardioData value) => value.writeToBuffer()));
  }

  $async.Stream<$0.CardioData> streamCardioData_Pre($grpc.ServiceCall call, $async.Future<$0.CardioRequest> request) async* {
    yield* streamCardioData(call, await request);
  }

  $async.Future<$0.SetWorkingDirectoryResponse> setWorkingDirectory_Pre($grpc.ServiceCall call, $async.Future<$0.SetWorkingDirectoryRequest> request) async {
    return setWorkingDirectory(call, await request);
  }

  $async.Future<$0.SetFileToProcessResponse> setFileToProcess_Pre($grpc.ServiceCall call, $async.Future<$0.SetFileToProcessRequest> request) async {
    return setFileToProcess(call, await request);
  }

  $async.Stream<$0.CardioData> streamAnnotatedData_Pre($grpc.ServiceCall call, $async.Future<$0.CardioRequest> request) async* {
    yield* streamAnnotatedData(call, await request);
  }

  $async.Stream<$0.CardioData> streamCardioData($grpc.ServiceCall call, $0.CardioRequest request);
  $async.Future<$0.SetWorkingDirectoryResponse> setWorkingDirectory($grpc.ServiceCall call, $0.SetWorkingDirectoryRequest request);
  $async.Future<$0.SetFileToProcessResponse> setFileToProcess($grpc.ServiceCall call, $0.SetFileToProcessRequest request);
  $async.Stream<$0.CardioData> streamAnnotatedData($grpc.ServiceCall call, $0.CardioRequest request);
}
