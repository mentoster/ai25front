import 'dart:async';
import 'package:ai25front/src/generated/cardio.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class CardioClient {
  CardioServiceClient? _client;
  ClientChannel? _channel;

  CardioClient() {
    _channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = CardioServiceClient(_channel!);
  }

  Future<bool> setWorkingDirectory(String workingDirectory) async {
    // Updated field name to match proto3 syntax
    final request = SetWorkingDirectoryRequest()
      ..workingDirectory = workingDirectory;
    final response = await _client!.setWorkingDirectory(request);
    print('Set working directory success: ${response.success}');
    return response.success;
  }

  Future<bool> setFileToProcess(String fileToProcess) async {
    // Updated field name to match proto3 syntax
    final request = SetFileToProcessRequest()..fileToProcess = fileToProcess;
    final response = await _client!.setFileToProcess(request);

    // Print additional response details introduced in proto3
    print('Set file to process success: ${response.success}');
    print('Age: ${response.age}');
    print('Pharm: ${response.pharm}');
    print('Label1: ${response.label1}');
    print('Label2: ${response.label2}');
    print('Label3: ${response.label3}');

    return response.success;
  }

  Stream<CardioData> streamCardioData(String clientId) {
    final request = CardioRequest();
    return _client!.streamCardioData(request);
  }

  void close() {
    _channel?.shutdown();
  }
}
