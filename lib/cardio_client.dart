import 'dart:async';
import 'package:grpc/grpc.dart';
import 'src/generated/cardio.pbgrpc.dart';

class CardioClient {
  late final CardioServiceClient stub;
  final ClientChannel channel;

  CardioClient(String address, int port)
      : channel = ClientChannel(
          address,
          port: port,
          options:
              const ChannelOptions(credentials: ChannelCredentials.insecure()),
        ) {
    stub = CardioServiceClient(channel);
  }

  Stream<CardioData> streamCardioData(String clientId) async* {
    final request = CardioRequest()..clientId = clientId;

    await for (final data in stub.streamCardioData(request)) {
      yield data;
    }
  }

  Future<void> shutdown() async {
    await channel.shutdown();
  }
}
