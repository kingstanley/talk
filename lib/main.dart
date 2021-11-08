import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:uzum/providers/chat_provider.dart';
import 'package:uzum/screens/home_screen.dart';
import "package:provider/provider.dart";
import 'package:uzum/screens/mobile/account/welcome.screen.dart';

void main() {
  if (WebRTC.platformIsDesktop) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  } else if (WebRTC.platformIsAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    // startForegroundService();

  }
  // else if (WebRTC.platformIsIOS) {
  //   WidgetsFlutterBinding.ensureInitialized();
  // }
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        title: 'Freechat',
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        // showPerformanceOverlay: true,
        theme: ThemeData(
            primarySwatch: Colors.purple,
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
