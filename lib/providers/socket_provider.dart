import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider {
  late final Socket _userSocket;

  setSocket(socket) {
    _userSocket = socket;
  }

  Socket getSocket() => _userSocket;
}

late Socket userSocket;
