import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uzum/data/chats.dart';
import 'package:uzum/helpers/functions.dart';
import 'package:uzum/models/chat.model.dart';
import 'package:uzum/models/message.model.dart';
import 'package:uzum/providers/chat_provider.dart';
import 'package:uzum/screens/mobile/video_call.dart';

import 'package:uzum/widgets/chatmessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String friendName;
  late String friendImageUrl;
  late List<Message> messages;

  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 500.0);
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Chat chat =
        chats[Provider.of<ChatProvider>(context).currentChatIndex];
    friendName = chat.senderName;
    friendImageUrl = chat.senderProfilePicUrl;
    messages = chat.messages;
    return isMobile(context)
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
          _buildAppBar(context),
          _buildMessageList(),
          _buildMessageComposer(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          isMobile(context) ? Theme.of(context).primaryColor : Colors.grey[50],
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      title: Row(
        children: [
          isMobile(context)
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back))
              : SizedBox(
                  width: 10.0,
                ),
          CircleAvatar(
            backgroundImage: NetworkImage(friendImageUrl),
            radius: 20.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              friendName,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: true,
              style: TextStyle(
                fontSize: 15.0,
                color: isMobile(context) ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
      actions: [
        IconButton(
            color: isMobile(context) ? Colors.white : Colors.black,
            onPressed: () {
              // showDialog(context: context, builder: (builder)=>{return videoDailog();})
              if (!isMobileScreen(context)) {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return videoDailog(context);
                    },
                    barrierDismissible: false,
                    barrierColor: Colors.transparent,
                    routeSettings: RouteSettings(name: 'video-call'));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => VideoCall()));
              }
            },
            icon: Icon(Icons.video_call)),
        IconButton(
            color: isMobile(context) ? Colors.white : Colors.black,
            onPressed: () {
              print('To initiate audio call');
            },
            icon: Icon(Icons.call)),
        IconButton(
            color: isMobile(context) ? Colors.white : Colors.black,
            onPressed: () {
              print('To initiate more option as popover');
            },
            icon: Icon(Icons.more_vert))
      ],
    );
  }

  Widget _buildMessageComposer(context) {
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
                  icon: Icon(Icons.camera_alt))
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
                  backgroundColor: Colors.purple,
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Expanded(
        child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatMessage(messages[index]);
            }));
  }

  videoDailog(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(width: 700, height: 350, child: VideoCall()));
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          const AlertDialog(title: Text('Material Alert!')),
    );
  }
}
