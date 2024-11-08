import 'package:ai25front/src/generated/hello.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'src/generated/hello.pb.dart';
import 'src/generated/hello.pbgrpc.dart';

class HelloClient {
  late final ClientChannel _channel;
  late final HelloServiceClient _client;

  HelloClient() {
    _channel = ClientChannel(
      'localhost', // Замените на ваш адрес сервера
      port: 50051, // Укажите нужный порт сервера
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = HelloServiceClient(_channel);
  }

  Future<String> sayHello(String name) async {
    final request = HelloRequest()..name = name;
    try {
      final response = await _client.sayHello(request);
      return response.message;
    } catch (e) {
      print('Ошибка gRPC: $e');
      return 'Ошибка при подключении';
    }
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
