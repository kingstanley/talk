import '../../data/chats.dart';
import '../../models/message.model.dart';
import '../../widgets/converzationList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget chatList(context) {
  return ListView.builder(
    itemCount: chats.length,
    itemBuilder: (context, int index) {
      List<Message> messageList = chats[index].messages;

      final Message lastMessage = messageList[messageList.length - 1];
      // print("last message: ${lastMessage.text}");
      return Conversation(
          chats[index].receiverProfilePicUrl,
          chats[index].senderName,
          lastMessage.text,
          lastMessage.time,
          lastMessage.seenMessage,
          context,
          index);
    },
  );
}
