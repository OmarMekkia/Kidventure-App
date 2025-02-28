import 'package:http/http.dart' as http;

class ChatService {
  static final ChatService _instance = ChatService._internal();

  factory ChatService() {
    return _instance;
  }

  ChatService._internal();

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('/api/handle-chat-message'),
        body: {'message': message},
      );

      if (!response.statusCode.toString().startsWith('2')) {
        throw Exception('Failed to get response');
      }

      return response.body;
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
