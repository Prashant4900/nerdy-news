import 'dart:developer';

import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/analytics/analytics.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/db/share_pref/app_pref.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/providers/reader_mode_provider.dart';
import 'package:mobile/providers/theme_provider.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/versions.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/widgets/buttons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

String formattedDate(DateTime dateTime) {
  final formattedDate = DateFormat('MMMM y').format(dateTime);
  return formattedDate;
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String _userName = 'Nerdy Reader';
  String _date = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>()..add(UserStatusEvent()),
      listener: (context, state) {
        if (state is AuthSuccess) {
          appAnalytics.log(LogEvent.logIn);
          _userName = state.user!.displayName ?? 'Dummy';
          _date = formattedDate(state.user!.metadata.creationTime!);
        } else {
          appAnalytics.log(LogEvent.logOut);
          _userName = 'Nerdy Reader';
          _date = AppPrefCache.getInitialDate();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: bodyWidget(context, state),
          ),
        );
      },
    );
  }

  Widget bodyWidget(BuildContext context, AuthState state) {
    return Padding(
      padding: horizontalPadding16,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 45,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            verticalMargin24,
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFF1F1F1),
                  child: InkWell(
                    onTap: () {
                      if (state is AuthFailure) {
                        Navigator.pushNamed(
                          context,
                          MyRoutes.authScreen,
                        );
                      }
                    },
                    child: const Icon(AkarIcons.person_add),
                  ),
                ),
                horizontalMargin12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    verticalMargin4,
                    Text(
                      'Joined $_date',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            verticalMargin32,
            CustomOutlineButton(
              label: 'Invite Friends',
              onTap: () {
                Share.share(
                  'Hey, Check this awesome news application: https://play.google.com/store/apps/details?id=news.nerdy.mobile',
                );
              },
            ),
            verticalMargin8,
            const Divider(),
            verticalMargin16,
            Text(
              'Preference',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            verticalMargin12,
            if (state is AuthFailure)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sign In'),
                trailing: const Icon(CupertinoIcons.forward, size: 16),
                onTap: () {
                  context.read<AuthBloc>().add(GoogleSignInEvent());
                },
              ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Display Theme'),
              trailing: const Icon(CupertinoIcons.forward, size: 16),
              onTap: () {
                showModalBottomSheet<dynamic>(
                  context: context,
                  builder: (context) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        verticalMargin16,
                        Center(
                          child: Text(
                            'Display Theme',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // BlocBuilder<ThemeCubit, ThemeState>(
                        //   builder: (context, state) {
                        //     return Column(
                        //       children: [
                        //         ListTile(
                        //           title: const Text('System'),
                        //           trailing: state.themeMode == ThemeMode.system
                        //               ? const Icon(AkarIcons.check)
                        //               : emptyWidget,
                        //           onTap: () {
                        //             context
                        //                 .read<ThemeCubit>()
                        //                 .changeTheme(ThemeMode.system);
                        //           },
                        //         ),
                        //         ListTile(
                        //           title: const Text('Light'),
                        //           trailing: state.themeMode == ThemeMode.light
                        //               ? const Icon(AkarIcons.check)
                        //               : emptyWidget,
                        //           onTap: () {
                        //             context
                        //                 .read<ThemeCubit>()
                        //                 .changeTheme(ThemeMode.light);
                        //           },
                        //         ),
                        //         ListTile(
                        //           title: const Text('Dark'),
                        //           trailing: state.themeMode == ThemeMode.dark
                        //               ? const Icon(AkarIcons.check)
                        //               : emptyWidget,
                        //           onTap: () {
                        //             context
                        //                 .read<ThemeCubit>()
                        //                 .changeTheme(ThemeMode.dark);
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text('Light Theme'),
                                  trailing:
                                      themeProvider.themeMode == ThemeMode.light
                                          ? const Icon(Icons.check)
                                          : const SizedBox.shrink(),
                                  onTap: () {
                                    themeProvider.changeTheme(ThemeMode.light);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Dark Theme'),
                                  trailing:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? const Icon(Icons.check)
                                          : const SizedBox.shrink(),
                                  onTap: () {
                                    themeProvider.changeTheme(ThemeMode.dark);
                                  },
                                ),
                                ListTile(
                                  title: const Text('System Theme'),
                                  trailing: themeProvider.themeMode ==
                                          ThemeMode.system
                                      ? const Icon(Icons.check)
                                      : const SizedBox.shrink(),
                                  onTap: () {
                                    themeProvider.changeTheme(ThemeMode.system);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reader Mode'),
              trailing: const Icon(CupertinoIcons.forward, size: 16),
              onTap: () {
                showModalBottomSheet<dynamic>(
                  context: context,
                  builder: (context) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        verticalMargin16,
                        Center(
                          child: Text(
                            'Reader Mode',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Consumer<ReaderModeProvider>(
                          builder: (context, readerModeProvider, child) {
                            return Column(
                              children: [
                                ListTile(
                                  title: const Text('Enable'),
                                  trailing: readerModeProvider.status
                                      ? const Icon(Icons.check)
                                      : const SizedBox.shrink(),
                                  onTap: () {
                                    log('false reader mode');
                                    readerModeProvider.changeMode(enable: true);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Disable'),
                                  trailing: readerModeProvider.status
                                      ? const SizedBox.shrink()
                                      : const Icon(Icons.check),
                                  onTap: () {
                                    log('false reader mode');
                                    readerModeProvider.changeMode(
                                      enable: false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        // BlocBuilder<ReaderModeCubit, ReaderModeState>(
                        //   builder: (context, state) {
                        //     return Column(
                        //       children: [
                        //         ListTile(
                        //           title: const Text('Enable'),
                        //           trailing: state.status
                        //               ? const Icon(AkarIcons.check)
                        //               : emptyWidget,
                        //           onTap: () {
                        //             context
                        //                 .read<ReaderModeCubit>()
                        //                 .changeMode(enable: true);
                        //           },
                        //         ),
                        //         ListTile(
                        //           title: const Text('Disable'),
                        //           trailing: state.status
                        //               ? emptyWidget
                        //               : const Icon(AkarIcons.check),
                        //           onTap: () {
                        //             context
                        //                 .read<ReaderModeCubit>()
                        //                 .changeMode(enable: false);
                        //           },
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                      ],
                    );
                  },
                );
              },
            ),
            if (state is AuthSuccess)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sign Out'),
                textColor: Colors.redAccent,
                trailing: const Icon(
                  CupertinoIcons.forward,
                  size: 16,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  context.read<AuthBloc>().add(SignOutEvent());
                },
              ),
            verticalMargin32,
            Text(
              'About The App',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            verticalMargin12,
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Leave Feedback'),
              trailing: const Icon(CupertinoIcons.forward, size: 16),
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.feedbackScreen);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Privacy'),
              trailing: const Icon(CupertinoIcons.forward, size: 16),
              onTap: () => Navigator.pushNamed(
                context,
                MyRoutes.privacyPolicyScreen,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Terms of Service'),
              trailing: const Icon(CupertinoIcons.forward, size: 16),
              onTap: () => Navigator.pushNamed(
                context,
                MyRoutes.myTermScreen,
              ),
            ),
            verticalMargin16,
            Center(
              child: Text(
                'App Version $version',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            verticalMargin16,
          ],
        ),
      ),
    );
  }
}
