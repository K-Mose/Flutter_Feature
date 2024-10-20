import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:cp949_dart/cp949_dart.dart' as cp949;

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_printer_test/constants.dart';
import 'package:pos_printer_test/text.dart';

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
  late SerialPort port;
  bool isPortOpen = false;

  TextEditingController tc = TextEditingController();

  Future<void> initSerialPort() async {
    final config = SerialPortConfig();
    config
      ..baudRate = 9600
      ..bits = 8
      ..stopBits = 1;
    port = SerialPort("COM1");

    port.openReadWrite();
    port.config = config;
    setState(() {
      isPortOpen = port.isOpen;
    });
  }

  int calcKorLength(String line) {
    int length = 0;
    final regKr = RegExp(r"[가-힣]+");
    final	matches = regKr.allMatches(line);
    for (final m in matches) {
      length += m.group(0)?.length ?? 0;
    }
    return length * 2;
  }

  Future<void> cutLine() async {
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(INIT_PRINTER.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(CUT_THE_PAPER.toUin8List());
  }

  Future<void> writeLine(String line) async {
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
    final cp = cp949.encode(line);
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(Uint8List.fromList([...CP_949, ...cp]));
  }
  
  Future<void> newLine() async {
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(NEW_LINE.toUin8List());
  }

  Future<void> writeMenu(MenuData menu) async {
    final len = calcKorLength(menu.name);
    await Future.delayed(const Duration(milliseconds: 500));
    await newLine();
    // await writeLine(menu.name);
    port.write(Uint8List.fromList([...CP_949, ...LEFT,...cp949.encode(menu.name)]));
    await Future.delayed(const Duration(milliseconds: 300));
    await newLine();
    port.write(Uint8List.fromList([...CP_949, ...RIGHT, ...cp949.encode(
        "${menu.quantity.toString().padLeft(3)}"
        "${menu.discount.numberWithSeparator().padLeft(8)}"
        "${menu.price.numberWithSeparator().padLeft(9)}"
    )]));
  }
  
  Future<void> testReceipt() async {
    List<MenuData> menus = [
      const MenuData("치즈로 덮인 닭고기", 1, 0, 10000),
      const MenuData("새콤달콤한 소스를 곁들인 치킨", 1, 2000, 10000),
      const MenuData("전통요리콤보세트", 1, 0, 30000),
      // const MenuData("", 0, 0, 0)
    ];
    
    await newLine();await newLine();
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(Uint8List.fromList([...CP_949, ...CENTER, ...cp949.encode(title)]));
    await newLine();await newLine();
    await Future.delayed(const Duration(milliseconds: 100));
    port.write(Uint8List.fromList([...CP_949, ...LEFT, ...cp949.encode(company)]));
    await Future.delayed(const Duration(milliseconds: 100));
    await writeLine(header1("1234567890"));
    await writeLine(separator2);
    await writeLine(menu_title);
    await writeLine(separator1);
    await newLine();
    await writeLog("\n\n메뉴 출력\n");
    for (final menu in menus) {
      await writeLog("$menu\n");
      await writeMenu(menu);
    }
    await writeLine(separator3);
    await cutLine();
  }

  @override
  void initState() {
    super.initState();
    initSerialPort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("printer test $isPortOpen"),
      ),
      body: Container(
        height: 1000,
        width: 800,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 500,
                width: 600,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)
                ),
                child: TextField(
                  controller: tc,
                  maxLines: 100,

                ),
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      try {
                        port.write(INIT_PRINTER.toUin8List());
                        const ls = LineSplitter();
                        print(tc.text);
                        print(tc.text.codeUnits);
                        final lsc = ls.convert(tc.text);
                        print(lsc);
                        for (final l in lsc) {
                          await writeLine(l);
                          // await Future.delayed(const Duration(milliseconds: 100));
                          // port.write(NEW_LINE.toUin8List());
                          // final cp = cp949.encode(l);
                          // await Future.delayed(const Duration(milliseconds: 100));
                          // port.write(Uint8List.fromList([...CP_949, ...cp]));
                        }
                        await cutLine();
                      } catch (e) {
                        writeLog(e.toString());
                      }
                      return;
                      Uint8List command = Uint8List.fromList([0x1b, 0x74, 0x10, ...tc.text.runes.map((e) => int.parse(e.toRadixString(16), radix: 16)).toList()]);
                      print(command);
                      final cp = cp949.encode(tc.text);
                      print(cp);
                      print(cp949.decode(cp));
                    },
                    child: const Text("print")
                  ),
                  OutlinedButton(
                    onPressed: () {
                      port.write(INIT_PRINTER.toUin8List());
                      port.write(NEW_LINE.toUin8List());
                      port.write(NEW_LINE.toUin8List());
                      port.write(CUT_THE_PAPER.toUin8List());
                    },
                    child: const Text("cut")
                  ),
                  OutlinedButton(
                    onPressed: () {
                      port.write(NEW_LINE.toUin8List());
                    },
                    child: const Text("new line")
                  ),
                  OutlinedButton(
                    onPressed: () {
                      port.write(OPEN_CASH_DRAWER.toUin8List());
                      // port.write(Uint8List.fromList(OPEN_CASH_DRAWER));
                    },
                    child: const Text("open")
                  ),
                  OutlinedButton(
                    onPressed: () {
                      testReceipt();
                    },
                    child: const Text("receipt test")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExt on String {
  String stringToHex(String s) {
    return s.codeUnits.map((unit) => "0x${unit.toRadixString(16).padLeft(2, '0')}").join(' ');
  }

  Uint8List toHexList() {
    return Uint8List.fromList(codeUnits);
  }
}

extension IntListExt on List<int> {
  Uint8List toUin8List() => Uint8List.fromList(this);
}

final _f = NumberFormat("#,###");
extension IntExt on int {
  String numberWithSeparator() => _f.format(this);
}

writeLog(String text) async {
  final directoryPath = await getApplicationDocumentsDirectory();
  final directory = Directory("${directoryPath.path}\\logs");
  if (!directory.existsSync()) {
    await directory.create();
  }
  final file = File("${directory.path}\\printer_log.txt");
  await file.writeAsString(text, mode: FileMode.append, encoding: utf8);
}

class MenuData {
  const MenuData(this.name, this.quantity, this.discount, this.price);
  final String name;
  final int quantity;
  final int discount;
  final int price;

  @override
  String toString() {
    return 'MenuData{name: $name, quantity: $quantity, discount: $discount, price: $price}';
  }


}