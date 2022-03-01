import '../models/chat.model.dart';
import '../models/message.model.dart';
import '../screens/mobile/converzation.dart';

List<Chat> chats = [
  Chat(0, "08060046921", "Stanley Joel", imageUrls[4], '07032487122',
      'Nwaegwu Vivian', imageUrls[4], [
    Message(
        'We thank God we are doing fine. How was church service today? Please be early to work tomorrow so we can accomplish much before meeting',
        DateTime.now().subtract(Duration(days: 3, hours: 1)),
        '07032487122',
        '',
        true),
    Message(
        'Church was fine. I will try my best to be early. Please remember to bring along the software I asked of last Friday',
        DateTime.now().subtract(Duration(days: 1, hours: 1)),
        '08060046921',
        '',
        false),
    Message(
        'Church was fine. I will try my best to be early. Please remember to bring along the software I asked of last Friday',
        DateTime.now().subtract(Duration(days: 1, hours: 1)),
        '08060046921',
        '',
        false),
    Message(
        'We thank God we are.',
        DateTime.now().subtract(Duration(days: 1, hours: 1)),
        '07032487122',
        '',
        true),
    Message(
        'Church was fine. I will try my best to be early. Please remember to bring along the software I asked of last Friday',
        DateTime.now().subtract(Duration(days: 3, hours: 1)),
        '08060046921',
        '',
        false),
  ]),
  Chat(1, "08060046944", "Onoriode Godbless Kwedev", imageUrls[2],
      '07032487122', 'Nwaegwu Vivian Amarachi', imageUrls[0], [
    Message(
        'Me I de kampe',
        DateTime.now().subtract(Duration(days: 0, hours: 5)),
        '07032487122',
        '',
        false),
    Message(
        'Church was fine. I will try my best to be early. Please remember to bring along the software I asked of last Friday',
        DateTime.now().subtract(Duration(days: 0, hours: 0, minutes: 2)),
        '08060046921',
        '',
        true)
  ]),
  Chat(2, "08060046921", "Chimex", imageUrls[3], '07032487122',
      'Nwaegwu Vivian', imageUrls[1], [
    Message(
        'Church was fine. I will try my best to be early. Please remember to bring along the software I asked of last Friday',
        DateTime.now().subtract(Duration(days: 0, hours: 11, minutes: 50)),
        '08060046921',
        '',
        true),
    Message(
        'Me I de kampe',
        DateTime.now().subtract(Duration(
            days: 0,
            hours: 0,
            minutes: 0,
            seconds: 0,
            milliseconds: 0,
            microseconds: 0)),
        '07032487122',
        '',
        false)
  ])
];
