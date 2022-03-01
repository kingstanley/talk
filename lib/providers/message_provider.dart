import '../models/user.dart';
import '../services/socketio_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class MessageProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int id) => get('$apiUrl' + 'user');
  Future<Response> getMessage() => get(apiUrl);
  // Post request
  Future<Response> postUser(Map data) => post('$apiUrl', {'title': 'my name'});
  // Post request with File
  Future<Response<UserModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('$apiUrl/upload', form);
  }

  GetSocket userMessages() {
    return socket('$apiUrl/users/socket');
  }
}
