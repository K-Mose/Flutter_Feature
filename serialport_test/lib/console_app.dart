import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:libserialport/libserialport.dart';

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = SerialPortConfig();
    config.baudRate = 115200;
    List<String> availablePort = SerialPort.availablePorts;
    print('Available Ports: $availablePort');

    SerialPort comPort = SerialPort("COM4");

    comPort.open(mode: SerialPortMode.readWrite);

    // comPort.openReadWrite(); // 읽고 쓰기용으로 열기
    print(comPort.isOpen);

    try {
      // write on port
      print("Written Bytes : ${comPort.write(_stringToUint8List("HELLO WORLD!"))}");

      // read form port
      SerialPortReader reader = SerialPortReader(comPort);

      // SerialPortReader returns only Unit8List Data
      Stream<String> upcomingData = reader.stream.map((data) {
        print("in reader :: $data / ${String.fromCharCodes(data)}");
        return String.fromCharCodes(data);
      });

      upcomingData.listen((data) {
        print("read data: $data");
      });

    } on SerialPortError catch(err, _) {
      print(SerialPort.lastError);
      print(err);
      // comPort.close();
    }

    return Container();
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    print("codeUnits $codeUnits");
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    print("uint8list $uint8list");
    return uint8list;
  }
}