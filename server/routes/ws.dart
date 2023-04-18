import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Handler get onRequest {
  return webSocketHandler((channel, protocol) {
    // Koneksi terhubung
    print('Connected');

    // subscribe/mendengarkan stream of message dari client/app
    channel.stream.listen(
      (message) {
        print('Message yang diterima adalah $message');

        int? number = int.tryParse(message.toString());

        if (number != null) {
          // Kembalikan angka yang telah ditambah 1 ke client
          channel.sink.add('${number + 1}');
        } else {
          channel.sink.add('Data yang diterima bukanlah angka');
        }
      },
      onDone: () => print('Disconnect'),
    );
  });
}
