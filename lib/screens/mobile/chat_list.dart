import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uzum/data/chats.dart';
import 'package:uzum/models/message.model.dart';
import 'package:uzum/widgets/converzationList.dart';

Widget ChatList() {
  return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (BuildContext context, int index) {
        List<Message> messageList = chats[index].messages;
        final Message lastMessage = messageList[messageList.length - 1];
        return Conversation(
            chats[index].receiverProfilePicUrl,
            chats[index].senderName,
            lastMessage.text,
            lastMessage.time,
            lastMessage.seenMessage,
            context,
            index);
      });
}
