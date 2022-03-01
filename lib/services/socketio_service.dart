import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiController extends GetxController {
  IO.Socket socket = IO.io('https://viap.herokuapp.com/');
  String apiUrl = 'https://viap.herokuapp.com/';

  socketUrl() => socket;
}

String apiUrl = 'https://viap.herokuapp.com/';
// String apiUrl = 'http://192.168.43.58:3333/api/';
