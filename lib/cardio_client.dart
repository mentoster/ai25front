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
    // Use the generated field name here, e.g., 'workingDirectory' instead of 'working_directory'
    final request = SetWorkingDirectoryRequest()
      ..workingDirectory = workingDirectory;
    final response = await _client!.setWorkingDirectory(request);
    print('Set working directory success: ${response.success}');
    return response.success;
  }


  Future<bool> setFileToProcess(String fileToProcess) async {
    final request = SetFileToProcessRequest()..fileToProcess = fileToProcess;
    final response = await _client!.setFileToProcess(request);
    print('Set file to process success: ${response.success}');
    return response.success;
  }

  Stream<CardioData> streamCardioData(String clientId) {
    final request = CardioRequest()..clientId = clientId;
    return _client!.streamCardioData(request);
  }

  void close() {
    _channel?.shutdown();
  }
}
