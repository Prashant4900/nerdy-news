import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/analytics/analytics.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widgets/buttons.dart';

class MyAuthScreen extends StatelessWidget {
  const MyAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .6,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Assets.images.comics.path),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.95),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.9),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.8),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.7),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.6),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.5),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.4),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.3),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalMargin8,
                Padding(
                  padding: horizontalPadding16,
                  child: Text(
                    'Discover the best articles from around the world',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalMargin8,
                Padding(
                  padding: horizontalPadding16,
                  child: Text(
                    'Explore more then 50+ healthy food'
                    ' made specially for you',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is AuthSuccess) {
                      appAnalytics.log(LogEvent.logIn);
                      Timer(const Duration(seconds: 2), () {
                        AppPrefCache.setAuthSkip(skip: true);
                        Navigator.pushReplacementNamed(
                          context,
                          MyRoutes.dashboardScreen,
                        );
                      });
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: horizontalPadding16,
                          child: CustomElevatedButton(
                            label: 'Sign In With Google',
                            onTap: () {
                              context.read<AuthBloc>().add(GoogleSignInEvent());
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                verticalMargin4,
                Padding(
                  padding: horizontalPadding24,
                  child: CustomTextButton(
                    label: 'By Reading The Cultural News, you accept our '
                        'Terms and Conditions & Privacy Policy.',
                    onTap: () {},
                  ),
                ),
                verticalMargin24,
              ],
            ),
            Positioned(
              right: 10,
              child: TextButton(
                onPressed: () async {
                  await AppPrefCache.setAuthSkip(skip: true).whenComplete(() {
                    Navigator.pushReplacementNamed(
                      context,
                      MyRoutes.dashboardScreen,
                    );
                  });
                },
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
