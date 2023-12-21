import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/theme_manager.dart';
import 'package:mobile/providers/reader_mode_provider.dart';
import 'package:mobile/providers/theme_provider.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/views/auth/bloc/auth_bloc.dart';
import 'package:mobile/views/feedback/bloc/feedback_bloc.dart';
import 'package:mobile/views/search/bloc/search_bloc.dart';
import 'package:mobile/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider<ReaderModeProvider>(
          create: (context) => ReaderModeProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()..getTheme(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) =>
              SearchBloc()..add(const GetPublishersListEvent()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(UserStatusEvent()),
        ),
        BlocProvider<FeedbackBloc>(
          create: (context) => FeedbackBloc(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final themeMode = themeProvider.themeMode;
          return MyMaterialApp(themeMode: themeMode);
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
      title: 'The Cultural News',
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme(),
      darkTheme: ThemeManager.darkTheme(),
      themeMode: themeMode,
      onGenerateRoute: RouteManager.generateRoute,
      home: const MySplashScreen(),
    );
  }
}
