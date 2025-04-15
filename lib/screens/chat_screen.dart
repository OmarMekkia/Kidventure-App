import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:kidventure/constants/app_colors.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final Gemini _gemini = Gemini.instance;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  final String _promptInstructions = """
You are a friendly chatbot for kids aged 6-12. Use simple words, playful emojis, and keep answers short.
NEVER mention anything about:
- Grown-up stuff (relationships, politics, violence)
- Bad words or mean talk
- Flags or country arguments
- Anything private or scary
- Anything that is not safe for kids
- Anything that is not appropriate for kids
- Anything that is not funny
- Anything that is not educational
- Israel
- Gay

You can talk about Palastine.

If someone asks about tricky topics, say:
"Let's talk about something fun instead! 🌈 How about [suggestion]?"

Example response:
"That's a great question! 🎉 Did you know butterflies taste with their feet? 🦋 Let's draw one! ✏️"
""";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    _initSpeech();
  }

  // Initialize speech recognition
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: _onSpeechStatus,
      onError: _onSpeechError,
    );
    setState(() {});
  }

  // Start listening for speech
  void _startListening() async {
    if (_speechEnabled) {
      setState(() {
        _isListening = true;
      });

      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        listenOptions: SpeechListenOptions(cancelOnError: true),
      );
    }
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _textController.text = result.recognizedWords;
    });

    if (result.finalResult && result.recognizedWords.isNotEmpty) {
      _handleSendMessage();
    }
  }

  void _onSpeechStatus(String status) {
    setState(() {
      _isListening = status == 'listening';
    });
  }

  void _onSpeechError(dynamic error) {
    setState(() {
      _isListening = false;
    });
    final errorMessage = ChatMessage(
      role: "assistant",
      content: 'Speech recognition error: ${error.toString()}',
    );
    setState(() {
      _messages.add(errorMessage);
    });
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
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(role: 'user', content: text);

    setState(() {
      _messages.add(userMessage);
      _textController.clear();
      _isLoading = true;
    });

    // Scroll to bottom after adding the user message
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    try {
      // Build conversation history
      List<Part> conversationParts = [Part.text(_promptInstructions)];

      for (final message in _messages) {
        final role = message.role == 'user' ? 'User' : 'Assistant';
        conversationParts.add(Part.text('$role: ${message.content}'));
      }

      final response = await _gemini.prompt(
        parts: conversationParts,
        safetySettings: [
          SafetySetting(
            category: SafetyCategory.dangerous,
            threshold: SafetyThreshold.blockLowAndAbove,
          ),
          SafetySetting(
            category: SafetyCategory.harassment,
            threshold: SafetyThreshold.blockLowAndAbove,
          ),
          SafetySetting(
            category: SafetyCategory.hateSpeech,
            threshold: SafetyThreshold.blockLowAndAbove,
          ),
          SafetySetting(
            category: SafetyCategory.sexuallyExplicit,
            threshold: SafetyThreshold.blockLowAndAbove,
          ),
        ],
      );

      final assistantMessage = ChatMessage(
        role: 'assistant',
        content: response?.output,
      );
      setState(() {
        _messages.add(assistantMessage);
      });
      // Scroll to bottom after adding the assistant message
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (error) {
      final assistantMessage = ChatMessage(
        role: 'assistant',
        content:
            'Oops! My brain got a little tired. Let\'s try again in a bit, okay? Maybe we can talk about dinosaurs or space next time! 🚀✨',
      );
      setState(() {
        _messages.add(assistantMessage);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _speechToText.cancel();
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.background,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: AppColors.primary,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText:
                        _isListening ? 'Listening...' : 'Ask me anything!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _handleSendMessage(),
                ),
              ),
              IconButton(
                color: AppColors.primary,
                icon: Icon(_isListening ? Icons.stop : Icons.mic),
                onPressed: () {
                  if (_speechToText.isNotListening) {
                    _startListening();
                  } else {
                    _stopListening();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _handleSendMessage,
                color: AppColors.primary,
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
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < _messages.length) {
                  return ChatBubble(message: _messages[index]);
                } else {
                  // This is the loading bubble for the assistant
                  return ChatBubble(
                    message: ChatMessage(
                      role: 'assistant',
                      content: 'Thinking...',
                    ),
                    isLoading: true,
                  );
                }
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }
}
