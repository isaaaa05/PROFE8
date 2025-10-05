import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import 'chat_detail_screen.dart';

// COMPONENT 4: TabBar with TabBarView that switches between screens
// COMPONENT 9: TabBar inside AppBar with three tabs (Chats, Status, Calls)

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final MessageService _messageService = MessageService();

  @override
  void initState() {
    super.initState();
    _messageService.initializeDemoData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF2196F3),
          foregroundColor: Colors.white,
          // COMPONENT 9: TabBar inside AppBar with three tabs
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(icon: Icon(Icons.chat), text: 'Chats'),
              Tab(icon: Icon(Icons.circle), text: 'Status'),
              Tab(icon: Icon(Icons.call), text: 'Calls'),
            ],
          ),
        ),
        // COMPONENT 4: TabBarView that switches between screens
        body: TabBarView(
          children: [
            _buildChatsTab(),
            _buildStatusTab(),
            _buildCallsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsTab() {
    return ListView.builder(
      itemCount: _messageService.conversations.length,
      itemBuilder: (context, index) {
        final conversation = _messageService.conversations[index];
        final lastMessage = conversation.lastMessage;
        final timeAgo = _getTimeAgo(conversation.lastMessageTime);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF2196F3),
              child: Text(
                conversation.contactName[0],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              conversation.contactName,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              lastMessage.content,
              style: GoogleFonts.poppins(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              timeAgo,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    conversation: conversation,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatusTab() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: Colors.white,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2196F3), width: 2),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
            ),
            title: Text(
              'Contact ${index + 1}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Today at ${10 + index}:00 AM',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCallsTab() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        final isIncoming = index % 2 == 0;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF2196F3),
              child: Icon(
                isIncoming ? Icons.call_received : Icons.call_made,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Contact ${index + 1}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${isIncoming ? 'Incoming' : 'Outgoing'} • Yesterday',
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.call, color: Color(0xFF2196F3)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Calling Contact ${index + 1}...',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
