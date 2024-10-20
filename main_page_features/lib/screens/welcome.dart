import 'package:flutter/material.dart';
import 'package:main_page_features/screens/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = "/welcome_screen";

  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  var currentPage = 0;
  final _controller = PageController(initialPage: 0);

  final pref = SharedPreferences.getInstance();

  final list = <Widget> [
    Center(child: Image.asset("assets/images/welcome/welcome_1.png"),),
    Center(child: Image.asset("assets/images/welcome/welcome_2.png"),),
    Center(child: Image.asset("assets/images/welcome/welcome_3.png"),),
  ];

  List<Widget> indicator() => List<Widget>.generate(
      list.length,
      (index) => Container(
        margin: const EdgeInsets.all(5),
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          color: index == currentPage ? Colors.grey : Colors.black87,
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.black,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50))
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            children: list,
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
              // alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicator(),
              ),
            ),
          ),
          if (currentPage == list.length-1)
            Align(
              alignment: const Alignment(0, 0.9),
              child: OutlinedButton(
                onPressed: () {
                  pref.then((p) {
                    p.setBool("isFirst", false);
                  });
                  Navigator.pushNamedAndRemoveUntil(context, MapScreen.routeName, (route) => false,);
                },
                child: const Text("DONE"),
              ),
            )
        ]
      ),
    );
  }
}