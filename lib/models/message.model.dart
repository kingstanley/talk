class Message {
  final String senderPhone;
  final String receiverPhone;
  final String text;

  final DateTime time;

  final bool seenMessage;

  Message(this.text, this.time, this.senderPhone, this.receiverPhone,
      this.seenMessage);
}
