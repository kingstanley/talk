import 'package:flutter/cupertino.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ChatProvider with ChangeNotifier {
  int _currentIndex = 0;
  late RTCVideoRenderer _localVideoRender;
  bool _isTypingMessage = false;

  int get currentChatIndex => _currentIndex;
  bool get isTypingMessage => _isTypingMessage;
  RTCVideoRenderer get localVideoRenderer => _localVideoRender;

  void updateChatIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updateEditingMessage(value) {
    _isTypingMessage = value;
    debugPrint("$_isTypingMessage");
    notifyListeners();
  }

  void updateVideoRenderer(videoRenderer) {
    _localVideoRender = videoRenderer;
    notifyListeners();
  }
}
