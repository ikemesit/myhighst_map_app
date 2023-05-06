import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/features/authentication/data/auth.dart';
import 'package:myhighst_map_app/global_states.dart';
import 'package:myhighst_map_app/screens/home/home_screen.dart';
import 'package:myhighst_map_app/services/auth/user.service.dart';
import 'package:myhighst_map_app/theme/theme_constants.dart';
import 'package:myhighst_map_app/theme/theme_manager.dart';

import 'firebase_options.dart';
import 'models/user.model.dart' as model;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(authProvider).currentUser;

    if (currentUser != null) {
      final snapshot =
          ref.read(userServiceProvider).getUserById(currentUser.uid);

      snapshot.then((value) => ref.read(currentUserProvider.notifier).state =
          model.User.update(value?.firstName, value?.lastName, value?.email,
              value?.uid, value?.photoUrl, value?.createdAt));
    }
    return MaterialApp(
      title: 'MyHighSt Map',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: HomeScreen(), //WidgetTree(),
    );
  }
}
