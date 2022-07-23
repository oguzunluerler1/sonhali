import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea_ecommerce_app/screens/musteri/kategoriSecilen.dart';
import 'package:idea_ecommerce_app/screens/sign_in.dart';
import 'package:idea_ecommerce_app/services/notification_services/firebase_notification_service.dart';
import 'package:idea_ecommerce_app/utilities/route_helper.dart';
import '../screens/musteri/my_home_page.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class OnBoardWidget extends StatefulWidget {
  @override
  _OnBoardWidgetState createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {

  @override
  void initState() {
    super.initState();
    getLoginInfo();
    getToken();
    FirebaseNotificationService.foregroundMessage();
    FirebaseNotificationService.notificationForeground();
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken() ?? "";
    log("Token $token");
  }

  void getLoginInfo() async {
    final _auth = Provider.of<Auth>(context, listen: false);
    var isLoggedIn = _auth.onlineUser();
    await Future.delayed(Duration(milliseconds: 4000),() {
      RouteHelper.goRouteReplacement(context: context, page: isLoggedIn != null ? MyHomePage(key:key,) : SignIn());
    },);
  }

  @override
  Widget build(BuildContext context) { 
    //*Telefon ekranının yan dönmesini engelleyen kod.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Center(
        child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_wvl2zowe.json'),
      )
    );
  }
}
