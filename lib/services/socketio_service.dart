import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiController extends GetxController {
  IO.Socket socket = IO.io('http://192.168.0.185:3333');
  String apiUrl = 'http://localhost:3333';

  socketUrl() => socket;
}

String apiUrl = 'http://192.168.42.126:3333/';
// String apiUrl = 'http://192.168.43.58:3333/api/';
