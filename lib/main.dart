import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicorn_store/app_config.dart';
import 'package:unicorn_store/my_app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //This will initiate splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initializing the firebase app
  await Firebase.initializeApp();

  //Initializing hive database
  await Hive.initFlutter();

  const configuredApp = AppConfig(
    environment: Environment.prod,
    url: 'testing in prod mode',
    child: MyApp(),
  );

  runApp(configuredApp);
}
