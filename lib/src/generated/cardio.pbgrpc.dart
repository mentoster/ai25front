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

  CardioServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.CardioData> streamCardioData($0.CardioRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamCardioData, $async.Stream.fromIterable([request]), options: options);
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
  }

  $async.Stream<$0.CardioData> streamCardioData_Pre($grpc.ServiceCall call, $async.Future<$0.CardioRequest> request) async* {
    yield* streamCardioData(call, await request);
  }

  $async.Stream<$0.CardioData> streamCardioData($grpc.ServiceCall call, $0.CardioRequest request);
}
