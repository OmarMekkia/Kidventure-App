import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _messages.addAll(initialMessages);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleSendMessage() async {
    if (_textController.text.trim().isEmpty) return;

    final message = ChatMessage(
      role: 'user',
      content: _textController.text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(message);
      _textController.clear();
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _chatService.sendMessage(message.content);
      setState(() {
        _messages.add(
          ChatMessage(
            role: 'assistant',
            content: response,
            timestamp: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      setState(
        () => _errorMessage = 'Oops! Something went wrong. Please try again!',
      );
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Ask me anything!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _handleSendMessage(),
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.mic),
                onPressed: () {
                  /* Implement speech recognition */
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _handleSendMessage,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Chat with Kidventure',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= _messages.length) {
                  return _buildLoadingIndicator();
                }
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }
}
