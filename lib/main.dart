import 'dart:async';

import '../controllers/user.controller.dart';
import '../providers/account_provider.dart';
import '../providers/message_provider.dart';
import '../providers/socket_provider.dart';
import '../services/socketio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../helpers/custom_colors.dart';
import '../helpers/functions.dart';
import '../providers/chat_provider.dart';
import '../screens/home_screen.dart';
import "package:provider/provider.dart";
import '../screens/mobile/account/welcome.screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:universal_platform/universal_platform.dart';

import 'models/user.dart';

// http://192.168.42.12:3333'
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // UserController userController = Get.put(UserController());
  // userController.getAll().then((value) {
  //   UserModel user = userController.user.value;
  //   if (user.phoneNumber.toString().isEmpty) {
  //     print("user in welcome: ${userController.user.value.phoneNumber}");
  //     Get.to(Welcome());
  //   }
  // });
  getDeviceInfo();
  IO.Socket socket = IO.io('$apiUrl', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  // Connect to websocket
  socket.connect();
  socket.onConnect((_) {
    print('socketio connected.... ${socket.id}');
    socket.emit('greet', 'viap web app');
    // socket.on('amonline', (data) => debugPrint('$data'));
  });
  SocketProvider socketProvider = SocketProvider();
  userSocket = socket;
  socketProvider.setSocket(socket);
  socketProvider
      .getSocket()
      .emit('greet', 'Second greeting from socket provider');

// Register user controller
  UserController userController = Get.put(UserController());
  userController.getAll().then((value) {
    UserModel user = userController.user.value;
    if (user.phoneNumber.toString().isEmpty) {
      print("user in main: ${userController.user.value.phoneNumber}");
      Get.to(Welcome());
    }
  });

  userSocket.on('amonline', (user) {
    // update user current socketId

    // var up = userController.updateUser(user);
    // print("user in home: $user");
  });

  if (WebRTC.platformIsDesktop) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  // WidgetsFlutterBinding.ensureInitialized();
  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    Firebase.initializeApp().then((value) => print("App name: ${value.name}"));
  }
  // startForegroundService();

  // else if (WebRTC.platformIsIOS) {
  //   WidgetsFlutterBinding.ensureInitialized();
  // }

  // runApp(MyApp());

  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    // myBackend.sendError(error, stack);
    print("zone error: ${error.toString()}");
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: GetMaterialApp(
        title: 'Via',
        locale: Get.deviceLocale,
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        // showPerformanceOverlay: true,
        theme: ThemeData(
            primaryColor: CustomColors.primary,
            visualDensity: VisualDensity.adaptivePlatformDensity),

        home: HomeScreen(),
        // initialRoute: '/',
        // routes: {ChatScreen.routeName: (_) => ChatScreen()},
      ),
    );
  }
}

// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:flutter_js/flutter_js.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _jsResult = '';
//   late JavascriptRuntime flutterJs;
//   @override
//   void initState() {
//     super.initState();
//     if (!kIsWeb) {
//       flutterJs = getJavascriptRuntime();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('FlutterJS Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('JS Evaluate Result: $_jsResult\n'),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                     'Click on the big JS Yellow Button to evaluate the expression bellow using the flutter_js plugin'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "Math.trunc(Math.random() * 1000).toString();",
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontStyle: FontStyle.italic,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.transparent,
//           child: Icon(Icons.add),
//           onPressed: () async {
//             try {
              
//                 // JsEvalResult jsResult = flutterJs
//                 //     .evaluate("Math.trunc(Math.random() * 1000).toString();");
//                 // setState(() {
//                 //   _jsResult = jsResult.stringResult;
//                 // });
               
//             } on PlatformException catch (e) {
//               print('ERRO: ${e.details}');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



// Firebase Via app token: A89F0FCE-1DE8-4793-9FC2-5717164570F6
// Firebase Uzum app token: 5892CD42-22F2-4222-A870-9A09BA023C74