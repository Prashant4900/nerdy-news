import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/state/blocs/auth/auth_bloc.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late StreamSubscription<AuthState> subscription;

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> checkUserStatus() async {
    await CacheHelper().setJoinedDate();
    final auth = AuthBloc()..add(UserStatusEvent());
    subscription = auth.stream.listen((state) {
      if (state is AuthSuccess) {
        appAnalytics
          ..setUserID(state.userID ?? '')
          ..log(LogEvent.appOpen);
        Navigator.pushReplacementNamed(context, MyRoutes.dashboardScreen);
      } else {
        Navigator.pushReplacementNamed(context, MyRoutes.startScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svg.icon.svg(
              width: 80,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            verticalMargin24,
            const SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                minHeight: .5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
