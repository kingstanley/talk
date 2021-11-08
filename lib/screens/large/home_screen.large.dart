import 'package:flutter/material.dart';
import 'package:uzum/screens/mobile/chat.screen.dart';
import 'package:uzum/screens/mobile/chat_list.dart';

class HomeScreenLarge extends StatefulWidget {
  HomeScreenLarge({Key? key}) : super(key: key);

  @override
  _HomeScreenLargeState createState() => _HomeScreenLargeState();
}

class _HomeScreenLargeState extends State<HomeScreenLarge> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.purple,
      resizeToAvoidBottomInset: true,
      body: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: screenHeight * 0.5, minWidth: screenWidth * 0.5),
        child: Container(
          // width: 1100.0,
          color: Colors.grey.withOpacity(0.5),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  child: Container(
                    color: Colors.purple,
                    height: screenHeight * 0.2,
                    width: screenWidth,
                  )),
              Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  bottom: screenHeight * 0.05,
                  child: Container(
                    height: screenHeight * 0.9,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 10.0),
                    ]),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 1500),
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.9,
                                maxWidth: screenWidth * 0.30,
                                minWidth: screenWidth * 0.30),
                            child: _buildLeftSide(screenWidth),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.9,
                                maxWidth: screenWidth * 0.60,
                                minWidth: screenWidth * 0.5),
                            child: ChatScreen(),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLeftSide(double screenWidth) {
    return Container(
      // width: screenWidth * 0.30,

      // color: Colors.purple,
      child: Column(
        children: [
          Container(
            height: 56.0,
            color: Colors.grey[50],
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/chatbackground.jpg'),
                  ),
                  Expanded(child: Container()),
                  SizedBox(width: 15.0),
                  Icon(Icons.star_outline_sharp),
                  SizedBox(width: 15.0),
                  Icon(Icons.chat),
                  SizedBox(width: 15.0),
                  Icon(Icons.more_vert)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              children: [
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.search,
                  size: 25.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search...', border: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: ChatList())
        ],
      ),
    );
  }
}
