import 'package:flutter/material.dart';
import 'package:uzum/screens/mobile/chat.screen.dart';
import 'package:uzum/screens/mobile/chat_list.dart';

class Conversations extends StatefulWidget {
  static final String routeName = '/';
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  bool _showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 1,
        child: Scaffold(
            // backgroundColor: Color(0xFF128C7E),

            appBar: _showSearchBar ? _searchBar(context) : _normalBar(context),
            body: TabBarView(children: [
              Center(child: Text('Camaras')),
              // chatComponent(),
              ChatList(),
              Center(child: Text('Status')),
              Center(child: Text('Calls'))
            ])));
  }

  AppBar _normalBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text("Uzum"),
      backgroundColor: Color(0xFF128C7E),
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
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _showSearchBar = false;
            });
          }),
      title: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search...',
        ),
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
