import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class AssistantPage extends StatefulWidget {
  AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final _user = const types.User(id: '339286c8-2e38-457a-b8d5-b2092e579a7a');
  final _agent = const types.User(id: 'b8ecf8ab-2356-4dbf-9ffb-51e9f54b0761');

  @override
  void initState() {
    super.initState();

    _addMessage(
      types.TextMessage(
        author: _user,
        text: 'Hello',
        id: randomString(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  List<types.TextMessage> _messages = [];

  void _sendToChatGPT(List<types.TextMessage> messages) async {
    var dio = Dio();
    var response = await dio.request(
      'https://4e75-2409-40c0-62-722c-81f4-1a43-6df7-e972.ngrok-free.app/api/v1/bedrock',
      options: Options(
        method: 'POST',
      ),
      data: {"input": messages.last.text},
    );

    if (response.statusCode == 200) {
      final agentResponse = types.TextMessage(
        author: _agent,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: response.data['output'],
      );
      setState(() {
        _messages.insert(0, agentResponse);
      });
    }
  }

  void _addMessage(types.TextMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
    _sendToChatGPT([..._messages, message]);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
