import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:uzum/screens/mobile/account/signup.screen.dart';

class Welcome extends StatefulWidget {
  // Signup({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 32.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.group,
                size: 100,
                color: Colors.purple,
              ),
              SizedBox(
                height: 18,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Let's get you started on UZUM",
                    textStyle: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 100),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              // Text(
              //   "Let's get you started on UZUM",
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              // Text(
              //   "for a better chatting experience",
              //   style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black38),
              // ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "for a better chatting experience",
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 2,
                pause: const Duration(milliseconds: 100),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              AnimatedTextKit(
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 100),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
                animatedTexts: [
                  FadeAnimatedText(
                    'Text, Vidoe Call, Audio Call, and live meeting',
                    textStyle:
                        TextStyle(fontSize: 18.0, fontFamily: 'Canterbury'),
                  ),
                ],
              ),
              SizedBox(
                height: 38,
              ),
              ElevatedButton(
                child:
                    Text("Lets' Get Started", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => Signup()));
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(12.5)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
