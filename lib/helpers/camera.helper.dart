import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

// getCameraMedia(
//     BuildContext context, int index, Map<String, dynamic> constraints) async {
//   try {
//     if (Platform.isAndroid || Platform.isIOS) {
//       // use camera widget
//       debugPrint('Platform is either Android or iOS: ');
//       var cameras = await availableCameras();
//       var controller = CameraController(cameras[0], ResolutionPreset.max);
//       return controller;
//     } else {
//       // use webrtc getMedia
//       debugPrint('Platform is either Web, Windows, Mack, Fuschia or Linux: ');
//       // final Map<String, dynamic> constraints = {
//       //   "audio": "true",
//       //   "video": {"facingMode": "user"}
//       // };

//       MediaStream stream =
//           await navigator.mediaDevices.getUserMedia(constraints);
//       return stream;
//     }
//   } catch (e) {}
// }
