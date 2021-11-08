import 'package:flutter/material.dart';
import 'package:uzum/helpers/functions.dart';
import 'package:uzum/screens/large/home_screen.large.dart';
import 'package:uzum/screens/mobile/home_screen.mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobileScreen(context) ? HomeScreenMobile() : HomeScreenLarge();
  }
}
