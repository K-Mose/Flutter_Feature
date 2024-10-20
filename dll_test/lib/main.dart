import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;
import 'dart:typed_data';
import 'package:dll_test/functions.dart';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:cp949_dart/cp949_dart.dart' as cp949;

/// 참고
/// https://dart.dev/interop/c-interop
/// https://stackoverflow.com/questions/75928981/how-to-convert-dartffi-char-to-string
/// https://stackoverflow.com/questions/72418793/unknown-function-signature-in-c

/*
List 형식은 ffi.Pointer<NativeType>로 전달
String형식은 ffi.Pointer<ffi.Uint8>로 받고 String의 확장함수 toNativeUtf8()로 변환하여 전달
 */
typedef KSCATApprovalFunc = ffi.Long Function(
    ffi.Pointer<ffi.Uint8>,
    ffi.Pointer<Utf8>,
    ffi.Int32,
    ffi.Pointer<Utf8>,
    ffi.Int32,
    ffi.Int32,
);
typedef KSCATApproval = int Function(
    ffi.Pointer<ffi.Uint8>,
    ffi.Pointer<Utf8>,
    int,
    ffi.Pointer<Utf8>,
    int,
    int,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry? overlayEntry;
  void createOverlay() {
    removeOverlay();
    overlayEntry = OverlayEntry(
        builder: (context) => const CircularProgressIndicator()
    );
    Overlay.of(context).insert(overlayEntry!);
  }
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }


  // late ffi.DynamicLibrary lib;
  late KSCATApproval _kscatApproval;
  void setUpFFI() {
    final libPath = path.join(Directory.current.path, "ksnetcomm.dll");
    print("libPath:: $libPath");
    final lib = ffi.DynamicLibrary.open(libPath);
    _kscatApproval = lib.lookupFunction<KSCATApprovalFunc, KSCATApproval>('KSCATApproval');
    print("_kscatApproval:");
    print(_kscatApproval);
  }

  @override
  void initState() {
    super.initState();
    setUpFFI();
    print(Directory.current.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("dll Test"),
      ),
      body: Container(
        height: 400,
        width: 300,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Center(
          child: OutlinedButton(
            onPressed: () async {
              await sendMessage();
            },
            child: Text("Send Data"),
          ),
        ),
      )
    );
  }

  Future<void> sendMessage() async {
    createOverlay();
    try {
      const length = 4096;
      final message = messageConverter();
      final blob = calloc<ffi.Uint8>(length);


      final result =
      _kscatApproval(
          blob,
          "127.0.0.1".toNativeUtf8(),
          27015,
          message.toNativeUtf8(),
          message.length,
          0
      );
      removeOverlay();
      // 응답 처리
      // 카드번호 암호화_신규통합전문 참고
      final receiveMessage = cp949.decode(blob.asTypedList(length));
      print("--------------------");
      print("result:: $result");
      print("--------|");
      print("receiveMessage:: $receiveMessage");
      print("--------|");
      print("receiveMessage:: $blob");
      print("--------|");
      print("거래날짜:: ${receiveMessage.substring(49, 55)}");
      print("승인번호:: ${receiveMessage.substring(94, 96)}");
      print("거래고유번호:: ${receiveMessage.substring(106, 126)}");
      print("--------------------");
    } catch (e) {
      print(e);
    }
  }
}

