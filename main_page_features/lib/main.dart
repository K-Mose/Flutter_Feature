import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:main_page_features/screens/Preference.dart';
import 'package:main_page_features/screens/map.dart';
import 'package:main_page_features/screens/welcome.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: PreferenceScreen.routeName,
      routes: <String, WidgetBuilder> {
        PreferenceScreen.routeName: (context) => const PreferenceScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        MapScreen.routeName: (context) => const MapScreen(),
      },
    );
  }
}
