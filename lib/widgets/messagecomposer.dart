import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_colors.dart';
import '../providers/chat_provider.dart';

Widget buildMessageComposer(BuildContext context) {
  TextEditingController _messageInputController = TextEditingController();
  bool _isEditing = false;

  void _showSendIcon(value) {
    if (value.length == 1) {
      Provider.of<ChatProvider>(context, listen: false)
          .updateEditingMessage(true);
    }
    if (value.length == 0) {
      Provider.of<ChatProvider>(context, listen: false)
          .updateEditingMessage(false);
    }
  }

  final messageContainer = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
    ),
    child: Row(
      children: [
        SizedBox(
          width: 8.0,
        ),
        IconButton(
          icon: Icon(Icons.insert_emoticon),
          onPressed: () {
            debugPrint('Insert emoticon');
          },
        ),
        Expanded(
            child: TextField(
          // controller: _messageInputController,
          onChanged: _showSendIcon,
          decoration: InputDecoration(
              hintText: 'Type your message...', border: InputBorder.none),
        )),
        IconButton(
            onPressed: () {
              debugPrint('Attatch file');
            },
            icon: Icon(Icons.attach_file)),
        !Provider.of<ChatProvider>(context).isTypingMessage
            ? IconButton(
                onPressed: () {
                  debugPrint('Attatch media');
                },
                icon: Icon(Icons.camera_enhance))
            : Container(),
        SizedBox(
          width: 8.0,
        )
      ],
    ),
  );

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(child: messageContainer),
        SizedBox(
          width: 8.0,
        ),
        Provider.of<ChatProvider>(context, listen: false).isTypingMessage
            ? CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              )
            : CircleAvatar(
                backgroundColor: CustomColors.primary,
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
              )
      ],
    ),
  );
}
