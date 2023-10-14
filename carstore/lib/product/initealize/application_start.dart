import 'package:carstore/firebase_options.dart';
import 'package:carstore/product/initealize/app_cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'package:flutter/material.dart';

@immutable
class AppliactionStart {
  const AppliactionStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders(
      [EmailAuthProvider(), GoogleProvider(clientId: '')],
    );

    await AppCache.instance.setup();
  }
}
