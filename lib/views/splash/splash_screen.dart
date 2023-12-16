import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/widgets/logo.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isLoggedIn = AppPrefCache.getUserID();
    final skipAuth = AppPrefCache.getAuthSkip();

    Timer(const Duration(seconds: 2), () {
      log(
        'Splash Screen:- isLoggedIn: ${isLoggedIn != ''}, skipAuth: $skipAuth',
      );
      if (isLoggedIn != '' || skipAuth) {
        Navigator.pushReplacementNamed(
          context,
          MyRoutes.dashboardScreen,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          MyRoutes.authScreen,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFullTextLogo(width: 300),
            verticalMargin12,
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                minHeight: .7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
