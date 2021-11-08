import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uzum/helpers/functions.dart';
import 'package:uzum/helpers/timeago.dart';
import 'package:uzum/models/chat.model.dart';
import 'package:uzum/providers/chat_provider.dart';
import 'package:uzum/screens/mobile/chat.screen.dart';

Widget Conversation(String url, String name, String message, DateTime time,
    bool messageSeen, BuildContext context, int chatIndex) {
  return Tooltip(
    message: name,
    child: InkWell(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false)
            .updateChatIndex(chatIndex);
        if (isMobileScreen(context)) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext ctx) => ChatScreen()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              radius: 25.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(name, time),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          // fontWeight: FontWeight.bold
                        ),
                      )),
                      if (messageSeen)
                        Icon(
                          Icons.check_circle,
                          size: 16.0,
                          color: Colors.green,
                        ),
                      if (!messageSeen)
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Row header(String name, DateTime time) {
  return Row(
    children: [
      Expanded(
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Text(timeAgo((time))),
    ],
  );
}

Row _MediumScreen(String name, DateTime time) {
  return Row(
    children: [
      Expanded(
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Text(timeAgo((time))),
    ],
  );
}
