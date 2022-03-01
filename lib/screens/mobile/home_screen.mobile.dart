import 'dart:io';

import '../../screens/mobile/account/welcome.screen.dart';

import '../../controllers/user.controller.dart';
import '../../data/chats.dart';
import '../../helpers/custom_colors.dart';
import '../../helpers/functions.dart';
import '../../providers/account_provider.dart';
import '../../providers/socket_provider.dart';
import '../../services/socketio_service.dart';
import '../../widgets/viadrawer.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:socket_io_client/socket_io_client.dart';

import 'chat_list.dart';

class HomeScreenMobile extends StatefulWidget {
  static final String routeName = '/';

  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  bool _showSearchBar = false;
  // IO.Socket socket = IO.io('http://192.168.42.12:3333');

  bool _showCreateBox = false;
  final UserController userController = Get.find();
  final SocketProvider socketProvider = SocketProvider();

  @override
  void initState() {
    // Connect to websocket
    // userController.getAll().then((users) => {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("user in home screen:  ${userController.user.value.toMap()}");
    // if (userController.user.value.toMap() == null) {
    //   // Get.to(Welcome());
    // }
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          // backgroundColor: Color(0xFF128C7E),
          appBar: _showCreateBox ? _searchBar(context) : _normalBar(context),
          drawer: kIsWeb
              ? viaDrawer()
              : Platform.isIOS
                  ? viaIoDrawer()
                  : viaDrawer(),
          body: TabBarView(children: [
            Center(child: Text('Camaras')),
            // chatComponent(),
            _showCreateBox
                ? Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          debugPrint('Creating new Group');
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            CircleAvatar(
                              child: Icon(Icons.group),
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'New Group',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          debugPrint('Creating new Contact');
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            CircleAvatar(
                              child: Icon(Icons.person_add),
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'New Contact',
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                                color: Colors.purple,
                                onPressed: () {
                                  debugPrint('Scanning QRCode');
                                },
                                icon: Icon(Icons.qr_code))
                          ],
                        ),
                      ),
                      Expanded(child: chatList(context))
                    ],
                  )
                : chatList(context),
            Center(child: Text('Status')),
            Center(child: Text('Calls'))
          ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: () {
              debugPrint('socketId: ${userSocket.id}');
              setState(() {
                if (isMobile()) {
                  _showCreateBox = true;
                  // userSocket.emit('amonline', {
                  //   "message": 'am online now',
                  //   "user": userController.user.value.toMap()
                  // });
                }
              });
            },
            child: Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
        ));
  }

  AppBar _normalBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text("Viap"),
      backgroundColor: CustomColors.primary,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showSearchBar = true;
            });
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
      ],
      bottom: TabBar(
        indicator: TabBarTheme.of(context).indicator,
        indicatorWeight: 4,
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            icon: Icon(Icons.camera_alt_rounded),
            iconMargin: EdgeInsets.only(left: 0.0),
          ),
          Tab(text: "CHATS"),
          Tab(text: "STATUS"),
          Tab(text: "CALLS")
        ],
        // controller: TabController(length: 4, initialIndex: 0, vsync: TickerProvider<SingleTickerProviderStateMixin>()),
      ),
    );
  }

  AppBar _searchBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          !_showSearchBar ? CustomColors.primaryLightColor : Colors.white,
      foregroundColor: !_showSearchBar ? Colors.white : Colors.black,
      leading: IconButton(
          color: !_showSearchBar ? Colors.white : Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _showCreateBox = false;
              _showSearchBar = false;
            });
          }),
      title: _showSearchBar
          ? TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
              ),
            )
          : Row(
              children: [
                Column(children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Select contact',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "${chats.length} contacts",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ]),
                Expanded(child: Container()),
                Row(
                  children: [
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          print('Clicking Search');
                          setState(() {
                            _showSearchBar = true;
                            // _showCreateBox = false;
                          });
                        },
                        icon: Icon(Icons.search)),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          debugPrint('More options');
                        },
                        icon: Icon(Icons.more_vert))
                  ],
                )
              ],
            ),
    );
  }
}
