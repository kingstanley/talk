import 'package:flutter/material.dart';
import 'package:uzum/data/chats.dart';
import 'package:uzum/helpers/custom_colors.dart';
import 'package:uzum/helpers/functions.dart';
import 'package:uzum/screens/mobile/chat.screen.dart';
import 'package:uzum/screens/mobile/chat_list.dart';

class HomeScreenMobile extends StatefulWidget {
  static final String routeName = '/';
  @override
  _HomeScreenMobileState createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  bool _showSearchBar = false;

  bool _showCreateBox = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
          // backgroundColor: Color(0xFF128C7E),
          appBar: _showCreateBox ? _searchBar(context) : _normalBar(context),
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
                      Expanded(child: ChatList())
                    ],
                  )
                : ChatList(),
            Center(child: Text('Status')),
            Center(child: Text('Calls'))
          ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            onPressed: () {
              setState(() {
                if (isMobile(context)) {
                  _showCreateBox = true;
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
      title: Text("Uzum"),
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

List<String> imageUrls = [
  "https://randomuser.me/api/portraits/men/11.jpg",
  "https://randomuser.me/api/portraits/women/60.jpg",
  "https://randomuser.me/api/portraits/men/13.jpg",
  "https://randomuser.me/api/portraits/women/17.jpg",
  "https://randomuser.me/api/portraits/women/52.jpg",
  "https://randomuser.me/api/portraits/women/33.jpg",
  "https://randomuser.me/api/portraits/women/23.jpg",
  "https://randomuser.me/api/portraits/men/03.jpg"
];
