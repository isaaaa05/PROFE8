import '../models/message.dart';

class MessageService {
  static final MessageService _instance = MessageService._internal();
  factory MessageService() => _instance;
  MessageService._internal();

  final List<ChatConversation> _conversations = [];

  List<ChatConversation> get conversations => _conversations;

  void initializeDemoData() {
    if (_conversations.isEmpty) {
      _conversations.addAll([
        ChatConversation(
          id: '1',
          contactName: 'Event Support',
          contactId: 'support1',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          messages: [
            Message(
              id: 'm1',
              senderId: 'support1',
              senderName: 'Event Support',
              content: 'Hello! How can we help you today?',
              timestamp: DateTime.now().subtract(const Duration(hours: 2)),
              isRead: true,
            ),
            Message(
              id: 'm2',
              senderId: 'me',
              senderName: 'Me',
              content: 'I have a question about my reservation',
              timestamp: DateTime.now().subtract(const Duration(hours: 1)),
              isRead: true,
            ),
          ],
        ),
        ChatConversation(
          id: '2',
          contactName: 'Concert Organizer',
          contactId: 'organizer1',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
          messages: [
            Message(
              id: 'm3',
              senderId: 'organizer1',
              senderName: 'Concert Organizer',
              content: 'Your tickets are confirmed!',
              timestamp: DateTime.now().subtract(const Duration(hours: 3)),
              isRead: true,
            ),
          ],
        ),
      ]);
    }
  }

  void sendMessage(String conversationId, String content) {
    final conversation =
        _conversations.firstWhere((c) => c.id == conversationId);
    final newMessage = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      senderName: 'Me',
      content: content,
      timestamp: DateTime.now(),
      isRead: true,
    );
    conversation.messages.add(newMessage);
  }
}
