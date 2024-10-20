import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketScreen extends StatelessWidget {
  WebsocketScreen({super.key});
  /*
  예제
  https://docs.flutter.dev/cookbook/networking/web-sockets
   */

  // Test server와 통신 https://www.lob.com/blog/websocket-org-is-down-here-is-an-alternative
  late WebSocketChannel channel;

  WebSocketChannel getWebSocketChannel() => WebSocketChannel.connect(
  Uri.parse('wss://echo.websocket.events'),
  );

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    channel = getWebSocketChannel();
      return StreamBuilder(
        stream: channel.stream,
        builder: (ctx, snapshot) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  Text(snapshot.hasData ? "${snapshot.data}" : "No connections"),
                  TextButton(
                      onPressed: () {
                        // Send Data to the Server
                        channel.sink.add("Hello!!");
                      },
                      child: const Text("Say Hello!"),
                  ),
                  TextButton(
                      onPressed: () {
                        // Send Data to the Server
                        channel.sink.add("Bye!!");
                      },
                      child: const Text("Good Bye"),
                  ),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.all(20)),
                      Expanded(
                        child: TextField(
                          // onChanged: _saveTitleInput,
                          controller: _controller,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              label: Text("Title")
                          ),
                        ),
                      ),
                        TextButton(onPressed: () {
                          if (_controller.text.length > 0) {
                            channel.sink.add(_controller.text);
                          } else {
                            channel.sink.add("Fill your Text");
                          }
                        },
                          child: const Text("Send")
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          channel.sink.close();
                        },
                        child: const Text("Close")),
                      OutlinedButton(
                        onPressed: () {
                          channel = getWebSocketChannel();
                        },
                        child: const Text("ReConnect")),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
  }
}