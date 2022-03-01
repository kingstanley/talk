import '../../controllers/user.controller.dart';
import '../../providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../data/chats.dart';
import '../../../helpers/functions.dart';
import '../../models/chat.model.dart';
import '../../models/message.model.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat.appbar.dart';

import '../../widgets/messagecomposer.dart';
import '../../widgets/messagelist.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String friendName;
  late String friendImageUrl;
  late List<Message> messages;
  UserController userController = UserController();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 500.0);
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final contacts = userController.getContacts();
    super.initState();
    if (!isMobile()) {
      // Get.to(HomeScreenLarge());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Chat chat =
        chats[Provider.of<ChatProvider>(context).currentChatIndex];
    friendName = chat.senderName;
    friendImageUrl = chat.senderProfilePicUrl;
    messages = chat.messages;
    return isMobile()
        ? Scaffold(
            body: _buildChat(),
          )
        : _buildChat();
  }

  Container _buildChat() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/chat.jpg'), fit: BoxFit.fill)),
      child: Column(
        children: [
          buildAppBar(context, friendName, friendImageUrl),
          buildMessageList(messages),
          buildMessageComposer(context),
        ],
      ),
    );
  }
}
