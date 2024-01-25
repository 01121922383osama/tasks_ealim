import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../../features/Chat/presentation/widgets/build_chat_message.dart';

class NotificationService {
  static const String key =
      'AAAAzqBg1ZM:APA91bFmFhNr3ocuTLzIeB2Wux2zpX2Bpg8F_NRp6mOmKorlI6VPUHTSXJo6rROKXxj2OQUwy8DeqtHDOjJl6KZtz3gK_gHw4kajiFwe4fylSUc5jvSGge0CpeJuFDpCKlTWHRqgy60p';
  final flutterLocalNotification = FlutterLocalNotificationsPlugin();
  void _initLocalNotification() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestCriticalPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    flutterLocalNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (kDebugMode) {
          log(details.payload.toString());
        }
      },
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    if (message.notification != null &&
        message.notification!.body != null &&
        message.notification!.title != null) {
      final styleInformation = BigTextStyleInformation(
        message.notification!.body!,
        htmlFormatBigText: true,
        contentTitle: message.notification!.title!,
        htmlFormatTitle: true,
      );
      final androidDetails = AndroidNotificationDetails(
        'com.example.chat_app.urgent',
        'mychannelid',
        importance: Importance.max,
        styleInformation: styleInformation,
        priority: Priority.max,
      );
      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );
      await flutterLocalNotification.show(
        0,
        message.notification!.title!,
        message.notification!.body,
        notificationDetails,
        payload: message.data['body'],
      );
    }
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      log('FCM Token: $token');
    }
    _saveToken(token!);
  }

  Future<void> _saveToken(String token) async =>
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'token': token}, SetOptions(merge: true));

  String receiverToken = '';

  Future<void> getReceiverToken(String? receiverId) async {
    final getToken = await FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .get();
    receiverToken = await getToken.data()!['token'];
  }

  void firebaseNotification(context) {
    _initLocalNotification();
// message.data['senderId']
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatUserMessagesPage(
              room: null, uid: message.data[message.data['uuid']]),
        ),
      );
    });

    /*
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChatScreen(userId: message.data['senderId']),
        ),
      );
    });
  */

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showLocalNotification(message);
    });
  }

  Future<void> sendNotification({
    required String body,
    required String senderId,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$key',
        },
        body: jsonEncode(<String, dynamic>{
          "to": receiverToken,
          'priority': 'high',
          'notification': <String, dynamic>{
            'body': body,
            'title': 'New Message !',
          },
          'data': <String, String>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'senderId': senderId,
          }
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }
  }
}
