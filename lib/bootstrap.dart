import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/logging/logger.dart';
import 'injection.dart';
import 'presentation/pages/app_page.dart';

class AppBlocObserver extends BlocObserver {
  @override
  Future<void> onChange(BlocBase bloc, Change change) async {
    super.onChange(bloc, change);
    logger.d('onChange(${bloc.runtimeType}, change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = AppBlocObserver();
      FlutterError.onError = (FlutterErrorDetails details) {
        logger.e(details.exceptionAsString());
      };
      await configureDependencies();
      await Supabase.initialize(
        url: 'https://nfxpgresracriiuzpolk.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5meHBncmVzcmFjcmlpdXpwb2xrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMyMTE5NjgsImV4cCI6MjAxODc4Nzk2OH0.d7uOwNmlWR7wjKd5LSE6KlHXg3YpVfw3ocPrSu8Mufo',
      );
      runApp(const AppPage());
    },
    (Object error, StackTrace stackTrace) => logger.e(error.toString()),
  );
}
