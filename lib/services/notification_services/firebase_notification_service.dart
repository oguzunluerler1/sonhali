import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notifiation_service.dart';

class FirebaseNotificationService {

  static void notificationForeground(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        LocalNotification.showNotification(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
        );
      }
    });
  }

  static void foregroundMessage(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        LocalNotification.showNotification(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
        );
      }
    });
  }
}