import 'package:flutter/material.dart';
import '../models/message.model.dart';

import 'chatmessage.dart';

Widget buildMessageList(List<Message> messages) {
  return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatMessage(messages[index]);
          }));
}
