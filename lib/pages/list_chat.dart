import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isRead;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.isRead = false,
  });
}

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  // Dummy data for chat list
  final List<Chat> chats = [
    Chat(
      id: '1',
      name: 'Toko Elektronik Maju',
      lastMessage: 'Barang sudah sampai ya pak',
      time: '10:30',
      avatar: 'assets/images/avatar1.png',
      isRead: false,
    ),
    Chat(
      id: '2',
      name: 'Toko Fashion Online',
      lastMessage: 'Stok tersedia kak',
      time: 'Kemarin',
      avatar: 'assets/images/avatar2.png',
      isRead: true,
    ),
    Chat(
      id: '3',
      name: 'Toko Buku Ilmiah',
      lastMessage: 'Buku sudah ready',
      time: 'Senin',
      avatar: 'assets/images/avatar3.png',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.search_normal_1),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterButton('Semua', true),
                const SizedBox(width: 8),
                _buildFilterButton('Belum Dibaca', false),
              ],
            ),
          ),
          
          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _buildChatItem(chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildChatItem(Chat chat) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(chat.avatar),
        radius: 25,
      ),
      title: Row(
        children: [
          Text(
            chat.name,
            style: TextStyle(
              fontWeight: chat.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          if (!chat.isRead) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: chat.isRead ? FontWeight.normal : FontWeight.w500,
          color: chat.isRead ? Colors.grey[600] : Colors.black87,
        ),
      ),
      trailing: Text(
        chat.time,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailChatPage(chatId: '1'),
          ),
        );
      },
    );
  }
}

class Message {
  final String id;
  final String text;
  final DateTime time;
  final bool isMe;
  final bool isRead;

  Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });
}

class DetailChatPage extends StatefulWidget {
  final String chatId;
  
  const DetailChatPage({super.key, required this.chatId});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Dummy chat data
  final List<Message> _messages = [
    Message(
      id: '1',
      text: 'Halo, ada yang bisa saya bantu?',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isMe: false,
      isRead: true,
    ),
    Message(
      id: '2',
      text: 'Saya ingin menanyakan ketersediaan barang',
      time: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      isMe: true,
      isRead: true,
    ),
    Message(
      id: '3',
      text: 'Barang masih tersedia, pak. Bisa langsung dipesan',
      time: DateTime.now().subtract(const Duration(minutes: 45)),
      isMe: false,
      isRead: true,
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _messageController.text,
          time: DateTime.now(),
          isMe: true,
          isRead: false,
        ),
      );
      _messageController.clear();
    });
    
    // Auto scroll to bottom
    _scrollToBottom();
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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar1.png'),
              radius: 16,
            ),
            const SizedBox(width: 12),
            const Text('Toko Elektronik Maju'),
            const SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // TODO: Implement more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          
          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Emoji button
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  onPressed: () {
                    // TODO: Implement emoji picker
                  },
                ),
                
                // Message input
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                
                // Send button
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF4C53A5)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isMe = message.isMe;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[  // Avatar for received messages
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar1.png'),
              radius: 16,
            ),
            const SizedBox(width: 8),
          ],
          
          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF4C53A5) : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${message.time.hour}:${message.time.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: message.isRead ? Colors.blue[200] : Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
