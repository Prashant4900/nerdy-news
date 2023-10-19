import 'dart:async';

import 'package:analytics/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/state/blocs/auth/auth_bloc.dart';
import 'package:mobile/views/dashboard.dart';
import 'package:mobile/widgets/buttons.dart';

final images = [
  Assets.images.anime.path,
  Assets.images.game.path,
  Assets.images.comics.path,
];

@immutable
class MyStartScreen extends StatefulWidget {
  const MyStartScreen({super.key});

  @override
  State<MyStartScreen> createState() => _MyStartScreenState();
}

class _MyStartScreenState extends State<MyStartScreen> {
  late Timer timer;
  late StreamSubscription<AuthState> subscription;
  int index = 0;

  @override
  void initState() {
    checkUserStatus();
    startSlider();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    timer.cancel();
    super.dispose();
  }

  void startSlider() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index == 0) {
        setState(() {
          index = 1;
        });
      } else if (index == 1) {
        setState(() {
          index = 2;
        });
      } else {
        setState(() {
          index = 0;
        });
      }
    });
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkUserStatus();
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Image.asset(
              key: Key('$index'),
              images[index],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(.05),
                      Colors.black.withOpacity(.25),
                      Colors.black.withOpacity(.45),
                      Colors.black.withOpacity(.65),
                      Colors.black.withOpacity(.85),
                      Colors.black.withOpacity(1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    verticalMargin12,
                    Padding(
                      padding: horizontalPadding12,
                      child: Text(
                        'Read Latest Pop culture News',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalMargin4,
                    Padding(
                      padding: horizontalPadding12,
                      child: Text(
                        '''Get updated on every scroll in an easy and fantastic way. We cover Hollywood Movies, TV Shows, Comics, Games and Anime from Popular pop culture.''',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    verticalMargin32,
                    const AuthButtonWidget(),
                    verticalMargin8,
                    const NotNowButtonWidget(),
                    verticalMargin12,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotNowButtonWidget extends StatelessWidget {
  const NotNowButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      label: 'Not now',
      textColor: Colors.white,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => const MyDashboard(),
          ),
        );
      },
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          );
        } else if (state is AuthSuccess) {
          appAnalytics.log(LogEvent.logIn);
        }
        return Column(
          children: [
            Padding(
              padding: horizontalPadding16,
              child: CustomElevatedButton(
                label: 'Create a free account',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  context.read<AuthBloc>().add(GoogleSignInEvent());
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
