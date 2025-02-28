import 'package:intl/intl.dart';

class ChatMessage {
  final String role;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  String get formattedTime => DateFormat('HH:mm').format(timestamp);

  bool get isUser => role == 'user';
}

final initialMessages = [
  ChatMessage(
    role: 'user',
    content: 'Hi! Can you tell me about the Moon? 🌙',
    timestamp: DateTime.parse('2024-01-10T10:00:00.000Z'),
  ),
  ChatMessage(
    role: 'assistant',
    content:
        'Hello young explorer! 👋 The Moon is Earth\'s only natural satellite...',
    timestamp: DateTime.parse('2024-01-10T10:00:05.000Z'),
  ),
];
