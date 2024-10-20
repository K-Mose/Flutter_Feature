import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:main_page_features/screens/Empty.dart';
import 'package:main_page_features/screens/map.dart';
import 'package:main_page_features/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceScreen extends StatefulWidget {
  static const routeName = "/preference_screen";

  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  late SharedPreferences pref;
  bool? isFirst;
  @override
  void initState() {
    super.initState();
    _getPreferences();
    initialization();
  }

  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
    _pageRoute();
  }

  void _getPreferences() async {
    print("getPreferences");
    pref = await SharedPreferences.getInstance();
    isFirst = pref.getBool("isFirst");
  }

  void _pageRoute() {
    Navigator.pop(context);
    (isFirst ?? true) ? {
      Navigator.pushNamedAndRemoveUntil(context, WelcomeScreen.routeName, (route) => false)
    } : {
      Navigator.pushNamedAndRemoveUntil(context, MapScreen.routeName, (route) => false)
    };
  }

  @override
  Widget build(BuildContext context) {
    return  const EmptyScreen();
  }
}