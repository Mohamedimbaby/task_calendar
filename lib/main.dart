import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_1/core/di/di.dart';
import 'presentation/cubits/calendar/calendar_cubit.dart';
import 'presentation/cubits/events/events_cubit.dart';
import 'presentation/pages/calendar_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/cubits/login/login_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      locale: const Locale("en"),
      home: BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginPage()),
    );
  }
}
