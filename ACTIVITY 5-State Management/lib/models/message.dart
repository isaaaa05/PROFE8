class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });
}

class ChatConversation {
  final String id;
  final String contactName;
  final String contactId;
  final List<Message> messages;
  final DateTime lastMessageTime;

  ChatConversation({
    required this.id,
    required this.contactName,
    required this.contactId,
    required this.messages,
    required this.lastMessageTime,
  });

  Message get lastMessage => messages.last;
}
