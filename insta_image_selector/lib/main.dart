import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_image_selector/constants/colors.dart';
import 'package:insta_image_selector/functions/permissions.dart';
import 'package:insta_image_selector/screens/image_selector_screen.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(
          background: BG_COLOR,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: BG_COLOR,
          surfaceTintColor: BG_COLOR,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final PermissionState ps = await PhotoManager.requestPermissionExtend(); // the method can use optional param `permission`.
      PhotoManager.setIgnorePermissionCheck(true);
      if (ps.isAuth) {
        // Granted
        // You can to get assets here.
      } else if (ps.hasAccess) {
        // Access will continue, but the amount visible depends on the user's selection.
      } else {
        // Limited(iOS) or Rejected, use `==` for more precise judgements.
        // You can call `PhotoManager.openSetting()` to open settings for further steps.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ImageSelectorScreen();
            },)), child: const Text("Image Selector"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
