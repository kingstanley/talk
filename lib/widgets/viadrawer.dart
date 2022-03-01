import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/custom_colors.dart';
import '../helpers/custom_sizes.dart';

Drawer viaDrawer() {
  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
        onTap: () {
          tabHandler();
        },
        leading: Icon(icon),
        title: Text(title,
            style: TextStyle(
                fontSize: CustomSize.secondaryTextSize,
                fontWeight: FontWeight.w700)));
  }

  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 220,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle, color: CustomColors.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint('avater clicked');
                          },
                          onHover: (value) {
                            debugPrint('hover value $value');
                            if (value) {
                              // show camera

                            } else {
                              // hide camera
                            }
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/chatbackground.jpg'),
                            backgroundColor: CustomColors.textPrimary,
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Icon(
                                  Icons.camera,
                                  size: 20.0,
                                  color: CustomColors.primaryLightColor,
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.light,
                          size: 30,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ), //End of row for avatar and theme icon
                SizedBox(
                  height: 20,
                ),

                Text(
                  'Joel Stanley',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CustomSize.primaryTextSize,
                      color: CustomColors.textPrimary),
                ),

                Row(
                  children: [
                    Text(
                      '+2348060046921',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: CustomColors.textPrimary,
                          fontSize: CustomSize.secondaryTextSize),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.check,
                          size: 10,
                          color: CustomColors.textPrimary,
                        ))
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              buildListTile('New Group', Icons.group, () {
                debugPrint('Group button clicked');
              }),
              buildListTile('New Channel', Icons.notifications, () {
                debugPrint('Channel clicked');
              }),
              buildListTile('Contact', Icons.contact_phone, () {
                debugPrint('contact clicked');
              }),
              buildListTile('Calls', Icons.call, () {
                debugPrint('call button clicked');
              }),
              buildListTile('Market', Icons.shop, () {
                debugPrint('Market button clicked');
              }),
              buildListTile('Stories ', Icons.pages, () {
                debugPrint('Stories button clicked');
              }),
              buildListTile('Wallet', Icons.wallet_travel, () {
                debugPrint('Wallet button clicked');
              }),
              buildListTile('Events', Icons.group, () {
                debugPrint('Event button clicked');
              }),
              buildListTile('Settings', Icons.settings, () {
                debugPrint('Settings button clicked');
              }),
            ],
          )
        ],
      ),
    ),
  );
}

CupertinoNavigationBar viaIoDrawer() {
  return CupertinoNavigationBar(
    leading: Text('Via'),
  );
}
