import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/theme_manager.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/state/blocs/auth/auth_bloc.dart';
import 'package:mobile/state/blocs/favorite/favorite_bloc.dart';
import 'package:mobile/state/blocs/feedback/feedback_bloc.dart';
import 'package:mobile/state/blocs/news/news_bloc.dart';
import 'package:mobile/state/cubits/reader_mode/reader_mode_cubit.dart';
import 'package:mobile/state/cubits/reader_mode/reader_mode_provider.dart';
import 'package:mobile/state/cubits/theme/theme_cubit.dart';
import 'package:mobile/state/providers/favorite_state/favorite_state_provider.dart';
import 'package:mobile/views/start_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<FavoriteStateProvider>(
          create: (context) => FavoriteStateProvider(),
        ),
        ChangeNotifierProvider<ReaderModeProvider>(
          create: (context) => ReaderModeProvider(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider<ReaderModeCubit>(
          create: (context) => ReaderModeCubit()..getReaderMode(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(UserStatusEvent()),
        ),
        BlocProvider<FeedbackBloc>(
          create: (context) => FeedbackBloc(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc()..add(GetAllFavoriteEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(const NewsLoadEvent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeChanged) {
            return MyMaterialApp(themeMode: state.themeMode);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    required this.themeMode,
    super.key,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme(),
      darkTheme: ThemeManager.darkTheme(),
      // themeMode: ThemeMode.dark,
      themeMode: themeMode,
      onGenerateRoute: RouteManager.generateRoute,
      home: const MyStartScreen(),
    );
  }
}
