import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:analytics/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/get_it.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/cache_helper.dart';
import 'package:mobile/state/blocs/auth/auth_bloc.dart';
import 'package:mobile/state/cubits/reader_mode/reader_mode_cubit.dart';
import 'package:mobile/state/cubits/theme/theme_cubit.dart';
import 'package:mobile/versions.dart';
import 'package:mobile/widgets/buttons.dart';
import 'package:share_plus/share_plus.dart';

Future<String> getJoinedDate() async {
  final date = await CacheHelper.getJoinedDate();
  final currentDate = DateTime.now();
  final formatDate = DateFormat('MMMM y').format(currentDate);
  return date ?? formatDate;
}

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFF1F1F1),
                      child: Icon(AkarIcons.person_add),
                    ),
                    horizontalMargin12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nerdy Reader',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        FutureBuilder(
                          future: getJoinedDate(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Joined ${snapshot.data}',
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            }
                            return Text(
                              'Joined ',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          },
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
                const SignInButton(),
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
                            BlocBuilder<ThemeCubit, ThemeState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: const Text('System'),
                                      trailing:
                                          state.themeMode == ThemeMode.system
                                              ? const Icon(AkarIcons.check)
                                              : emptyWidget,
                                      onTap: () {
                                        context
                                            .read<ThemeCubit>()
                                            .changeTheme(ThemeMode.system);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Light'),
                                      trailing:
                                          state.themeMode == ThemeMode.light
                                              ? const Icon(AkarIcons.check)
                                              : emptyWidget,
                                      onTap: () {
                                        context
                                            .read<ThemeCubit>()
                                            .changeTheme(ThemeMode.light);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Dark'),
                                      trailing:
                                          state.themeMode == ThemeMode.dark
                                              ? const Icon(AkarIcons.check)
                                              : emptyWidget,
                                      onTap: () {
                                        context
                                            .read<ThemeCubit>()
                                            .changeTheme(ThemeMode.dark);
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
                            BlocBuilder<ReaderModeCubit, ReaderModeState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: const Text('Enable'),
                                      trailing: state.status
                                          ? const Icon(AkarIcons.check)
                                          : emptyWidget,
                                      onTap: () {
                                        context
                                            .read<ReaderModeCubit>()
                                            .changeMode(flag: true);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Disable'),
                                      trailing: state.status
                                          ? emptyWidget
                                          : const Icon(AkarIcons.check),
                                      onTap: () {
                                        context
                                            .read<ReaderModeCubit>()
                                            .changeMode(flag: false);
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
                const SignOutButton(),
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
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<AuthBloc>()..add(UserStatusEvent()),
      buildWhen: (previous, current) => previous != current,
      builder: (BuildContext context, state) {
        if (state is AuthFailure) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Sign In'),
            trailing: const Icon(CupertinoIcons.forward, size: 16),
            onTap: () {
              context.read<AuthBloc>().add(GoogleSignInEvent());
            },
          );
        } else if (state is AuthSuccess) {
          appAnalytics.log(LogEvent.logIn);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<AuthBloc>()..add(UserStatusEvent()),
      buildWhen: (previous, current) => previous != current,
      builder: (BuildContext context, state) {
        if (state is AuthSuccess) {
          return ListTile(
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
          );
        } else if (state is AuthFailure) {
          appAnalytics.log(LogEvent.logOut);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
