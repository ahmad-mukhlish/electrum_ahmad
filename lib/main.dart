import 'package:electrum_ahmad/core/utils/color_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/routing/routing.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Electrum Ahmad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: hexToColor("#006A71"),
          primary: hexToColor("#48A6A7"),
          secondary: hexToColor("#F2EFE7"),
          tertiary: hexToColor("#008080"),
          onPrimary: hexToColor("#fffbf7"),
          onSecondary: hexToColor("#003333"),
        ),
      ),
      routerConfig: router,
    );
  }
}
