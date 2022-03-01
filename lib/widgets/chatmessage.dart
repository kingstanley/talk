import '../helpers/functions.dart';
import '../models/message.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  const ChatMessage(this.message);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderPhone == '08060046921';
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                constraints: isMobile()
                    ? BoxConstraints.loose(MediaQuery.of(context).size * 0.8)
                    : BoxConstraints.loose(MediaQuery.of(context).size * 0.5),
                padding: EdgeInsets.all(10.0),
                child: Text(message.text,
                    // maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    style: TextStyle(fontSize: 15.0)),
                decoration: BoxDecoration(
                    color: isMe ? Colors.lightGreen[50] : Colors.white),
              ),
            ),
          ],
        ));
  }
}
