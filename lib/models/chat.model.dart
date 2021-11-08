import 'message.model.dart';

class Chat {
  final int chatId;
  final String senderPhone;
  final String senderProfilePicUrl;
  final String senderName;
  final String receiverPhone;
  final String receiverProfilePicUrl;
  final String receiverName;
  final List<Message> messages;

  Chat(
      this.chatId,
      this.senderPhone,
      this.senderName,
      this.senderProfilePicUrl,
      this.receiverPhone,
      this.receiverName,
      this.receiverProfilePicUrl,
      this.messages);
}
