import 'package:flutter/material.dart';
import 'package:qr_test/model/my_fab.dart';
import 'package:qr_test/screens/qr_generator.dart';
import 'package:qr_test/screens/qr_scanner.dart';

void main() {
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
      home: const MyHomePage(title: 'QR Scanner Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// fab 설정
final List<MyFab> myFABs = [
  MyFab(
    icon: Icons.qr_code_sharp,
    color: Colors.blueAccent,
    onPress: (context) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => QrGeneratorScreen(),)
      );
    },
    description: "Qr Generator",
  ),
  MyFab(
    icon: Icons.qr_code_scanner,
    color: Colors.blueAccent,
    onPress: (context) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const QrScannerScreen(),)
      );
    },
    description: "Qr Scanner",
  )
];

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  // FAB AnimationController
  AnimationController? animationController;
  OverlayEntry? overlayEntry;
  GlobalKey globalKey = GlobalKey();

  // set Animation
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
    );
    // 애니메이션 셋팅
    int i = myFABs.length;
    for (var fab in myFABs) {
      fab.animation =
        Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animationController!,
            curve: Interval(0.2 * i--, 1.0, curve: Curves.ease)
          )
        );
    }

    // initMq();
  }


  void _showOverlay() async {
    RenderBox? renderbox = globalKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderbox.localToGlobal(Offset.zero);
;
    OverlayState? overlayState = Overlay.of(context);
    print("overlayState.mounted :: ${overlayState.mounted} $overlayEntry");

    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            left: offset.dx,
            bottom: renderbox.size.height + 16,
            child: Column(
              children: [
                for (var fab in myFABs)
                  ScaleTransition(
                    scale: fab.animation!,
                    child: FloatingActionButton(
                      heroTag: fab.description,
                      onPressed: () {
                          overlayEntry!.remove();
                          overlayEntry = null;
                          fab.onPress(context);
                      },
                      backgroundColor: Colors.white,
                      mini: true,
                      child: Icon(
                        fab.icon,
                        color: fab.color,
                      ),
                    ),
                  ),
              ],
            )),
      );

      animationController!.addListener(() {
        overlayState!.setState(() {});
      });
      animationController!.forward();
      overlayState!.insert(overlayEntry!);
      if (overlayEntry != null) {
        await Future.delayed(const Duration(seconds: 5))
            .whenComplete(() => animationController!.reverse())
            .whenComplete(() => overlayEntry?.remove())
            .whenComplete(() => (overlayEntry!=null)
              ? overlayEntry=null : null);
      }
    } else {
      overlayEntry!.remove();
      overlayEntry = null;
      animationController!.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    print(overlayEntry?.mounted);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => QrGeneratorScreen(),)
                );
              },
              icon: const Icon(Icons.qr_code),
              label: const Text("QR Generator")
            ),
            SizedBox(height: 40,),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const QrScannerScreen())
                );
              },
              icon: const Icon(Icons.qr_code_2_outlined),
              label: const Text("QR Scan")
            ),
            SizedBox(height: 80,),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        key: globalKey,
        onPressed: _showOverlay,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    overlayEntry?.dispose();
    super.dispose();
  }
}
