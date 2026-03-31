import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatScreen({super.key, required this.chatRoom});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Load seed messages
    _messages.addAll([
      ChatMessage(
        id: 'seed_1',
        senderId: MockData.currentUserId,
        receiverId: widget.chatRoom.sellerId,
        content: 'Hi! Is this still available?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 45)),
        isRead: true,
      ),
      ChatMessage(
        id: 'seed_2',
        senderId: widget.chatRoom.sellerId,
        receiverId: MockData.currentUserId,
        content: 'Yes, it is! Are you interested?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 40)),
        isRead: true,
      ),
      if (widget.chatRoom.lastMessage.isNotEmpty)
        ChatMessage(
          id: 'seed_3',
          senderId: MockData.currentUserId,
          receiverId: widget.chatRoom.sellerId,
          content: widget.chatRoom.lastMessage,
          sentAt: widget.chatRoom.lastMessageTime,
          isRead: false,
        ),
    ]);
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        senderId: MockData.currentUserId,
        receiverId: widget.chatRoom.sellerId,
        content: text,
        sentAt: DateTime.now(),
        isRead: false,
      ));
      _isTyping = false;
    });
    _msgController.clear();

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate reply after 1.5s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            id: 'reply_${DateTime.now().millisecondsSinceEpoch}',
            senderId: widget.chatRoom.sellerId,
            receiverId: MockData.currentUserId,
            content: _getAutoReply(text),
            sentAt: DateTime.now(),
            isRead: true,
          ));
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  String _getAutoReply(String msg) {
    msg = msg.toLowerCase();
    if (msg.contains('price') || msg.contains('negotiate') || msg.contains('deal')) {
      return 'I can offer a small discount for quick sale. What\'s your best offer? 😊';
    } else if (msg.contains('ship') || msg.contains('deliver')) {
      return 'I can ship within 1-2 business days via FedEx. Tracking provided!';
    } else if (msg.contains('condition') || msg.contains('damage')) {
      return 'It\'s in great condition! No scratches or issues. I can send more photos if you\'d like.';
    } else if (msg.contains('available') || msg.contains('sell')) {
      return 'Yes, still available! Are you ready to purchase?';
    }
    return 'Thanks for your message! I\'ll get back to you shortly. 👋';
  }

  @override
  Widget build(BuildContext context) {
    final otherName = widget.chatRoom.sellerName;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.bgGradient),
        child: Column(
          children: [
            _buildAppBar(otherName),
            _buildProductBanner(),
            Expanded(child: _buildMessageList()),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(String name) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 8,
        right: 16,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: const Border(
          bottom: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.textPrimary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
            ),
            child: Center(
              child: Text(
                name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                    fontFamily: 'Inter',
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accent.withOpacity(0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.accent,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.phone_outlined,
              color: AppTheme.textSecondary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppTheme.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProductBanner() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_outlined, color: AppTheme.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '📦 ${widget.chatRoom.productTitle}',
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.primary,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length,
      itemBuilder: (_, i) {
        final msg = _messages[i];
        final isMe = msg.senderId == MockData.currentUserId;
        final showDate = i == 0 ||
            _messages[i].sentAt.day != _messages[i - 1].sentAt.day;
        return Column(
          children: [
            if (showDate) _buildDateDivider(msg.sentAt),
            _buildBubble(msg, isMe),
          ],
        );
      },
    );
  }

  Widget _buildDateDivider(DateTime dt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppTheme.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${dt.day}/${dt.month}/${dt.year}',
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textMuted,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const Expanded(child: Divider(color: AppTheme.border)),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMessage msg, bool isMe) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
              ),
              child: Center(
                child: Text(
                  widget.chatRoom.sellerName.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: isMe ? AppTheme.primaryGradient : null,
                color: isMe ? null : AppTheme.bgCard,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),
                border: isMe
                    ? null
                    : Border.all(color: AppTheme.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : AppTheme.textPrimary,
                      fontFamily: 'Inter',
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${msg.sentAt.hour.toString().padLeft(2, '0')}:${msg.sentAt.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe
                              ? Colors.white.withOpacity(0.7)
                              : AppTheme.textMuted,
                          fontFamily: 'Inter',
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          msg.isRead
                              ? Icons.done_all_rounded
                              : Icons.done_rounded,
                          size: 12,
                          color: Colors.white.withOpacity(0.7),
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

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        border: const Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.attach_file_rounded,
              color: AppTheme.textMuted,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.bgSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      focusNode: _focusNode,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontFamily: 'Inter',
                        fontSize: 14,
                      ),
                      maxLines: 4,
                      minLines: 1,
                      onChanged: (v) =>
                          setState(() => _isTyping = v.isNotEmpty),
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: AppTheme.textMuted,
                          fontFamily: 'Inter',
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: AppTheme.textMuted,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: _isTyping
                    ? AppTheme.primaryGradient
                    : null,
                color: _isTyping ? null : AppTheme.bgSurface,
                border: _isTyping
                    ? null
                    : Border.all(color: AppTheme.border),
                boxShadow: _isTyping
                    ? [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                Icons.send_rounded,
                size: 20,
                color: _isTyping ? Colors.white : AppTheme.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
