import 'dart:math';
import 'dart:developer' as developer;

import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final uri = Uri.parse('ws://localhost:8080/ws');
  final Random random = Random();
  late final WebSocketChannel channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = WebSocketChannel.connect(uri);
    channel.stream.listen((message) {
      var number = int.tryParse(message);

      if (number != null) {
        developer.log('Angka yang telah ditambahkan adalah $message');
      } else {
        developer.log(message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Socket Demo App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            int number = random.nextInt(100);
            developer.log('Mengirimkan angka ke server: $number');
            channel.sink.add(number.toString());
          },
          child: const Text('Send a random number'),
        ),
      ),
    );
  }
}
