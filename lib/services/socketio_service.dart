import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

String apiUrl = 'http://localhost:3333/';

class ApiController extends GetxController {
  // IO.Socket socket = IO.io('http://localhost:3333/', <String, dynamic>{
  //   'transports': ['websocket'],
  //   'autoConnect': false,
  // });
  String apiUrl = 'https://viap.herokuapp.com/';

  // socketUrl() => socket;
}
// String apiUrl = 'http://192.168.43.58:3333/api/';
