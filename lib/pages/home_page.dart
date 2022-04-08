import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var name = "Bounty";
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(child: Text("Hello $name!")),
      ),
      drawer: Drawer(),
    );
  }
}

// class HomePage extends State {
// late final FirebaseMessaging _messaging;

// void registerNotification() async {
//     // 1. Initialize the Firebase app
//     await Firebase.initializeApp();

//     // 2. Instantiate Firebase Messaging
//     _messaging = FirebaseMessaging.instance;

//     // 3. On iOS, this helps to take the user permissions
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       // TODO: handle the received notifications
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var name = "Bounty";
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(child: Text("Hello $name!")),
//       ),
//       drawer: Drawer(),
//     );
//   }
// }

// class NotificationBadge extends StatelessWidget {
//   final int totalNotifications;

//   const NotificationBadge({required this.totalNotifications});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40.0,
//       height: 40.0,
//       decoration: const BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             '$totalNotifications',
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PushNotification {
//   PushNotification({
//     this.title,
//     this.body,
//     this.dataTitle,
//     this.dataBody,
//   });

//   String? title;
//   String? body;
//   String? dataTitle;
//   String? dataBody;
// }

// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State {
//   late final FirebaseMessaging _messaging;
//   late int _totalNotifications;
//   PushNotification? _notificationInfo;

//   void registerNotification() async {
//     // 1. Initialize the Firebase app
//     await Firebase.initializeApp();

//     // 2. Instantiate Firebase Messaging
//     _messaging = FirebaseMessaging.instance;

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // 3. On iOS, this helps to take the user permissions
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       // TODO: handle the received notifications
//     } else {
//       print('User declined or has not accepted permission');
//     }

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');

//       // For handling the received notifications
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         // Parse the message received
//         PushNotification notification = PushNotification(
//           title: message.notification?.title,
//           body: message.notification?.body,
//           dataTitle: message.data['title'],
//           dataBody: message.data['body'],
//         );

//         setState(() {
//           _notificationInfo = notification;
//           _totalNotifications++;
//         });
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         // ...
//         if (_notificationInfo != null) {
//           // For displaying the notification as an overlay
//           showSimpleNotification(
//             Text(_notificationInfo!.title!),
//             leading: NotificationBadge(totalNotifications: _totalNotifications),
//             subtitle: Text(_notificationInfo!.body!),
//             background: Colors.cyan.shade700,
//             duration: Duration(seconds: 2),
//           );
//         }
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   checkForInitialMessage() async {
//     await Firebase.initializeApp();
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       PushNotification notification = PushNotification(
//         title: initialMessage.notification?.title,
//         body: initialMessage.notification?.body,
//       );
//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });
//     }
//   }

//   @override
//   void initState() {
//     _totalNotifications = 0;
//     checkForInitialMessage();

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       PushNotification notification = PushNotification(
//         title: message.notification?.title,
//         body: message.notification?.body,
//       );
//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notify'),
//         brightness: Brightness.dark,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //...

//           _notificationInfo != null
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ],
//                 )
//               : Container(
//                   child: Center(child: Text("Hi")),
//                 ),
//         ],
//       ),
//     );
//   }
// }
