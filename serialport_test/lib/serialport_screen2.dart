import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

extension IntToString on int {
  String toHex() => '0x${toRadixString(16)}';
  String toPadded([int width = 3]) => toString().padLeft(width, '0');
  String toTransport() {
    switch (this) {
      case SerialPortTransport.usb:
        return 'USB';
      case SerialPortTransport.bluetooth:
        return 'Bluetooth';
      case SerialPortTransport.native:
        return 'Native';
      default:
        return 'Unknown';
    }
  }
}

class _ExampleAppState extends State<ExampleApp> {
  var availablePorts = [];

  @override
  void initState() {
    super.initState();
    initPorts();
    SerialPort port = SerialPort("COM3");
    // port.open(mode: 3);
    port.openReadWrite();

    Uint8List data = _stringToUint8List("hello?");//Uint8List.fromList("Hello World!".codeUnits);
    print("write data");
    print(port.write(data));
  }

  void initPorts() {
    setState(() => availablePorts = SerialPort.availablePorts);
    print(availablePorts);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Serial Port example'),
        ),
        body: ListView(
          children: [
            for (final address in availablePorts)
              Builder(builder: (context) {
                final port = SerialPort(address);
                port.openReadWrite();
                return ExpansionTile(
                  title: Text(address),
                  children: [
                    TextButton(onPressed: () {
                      print("Written Bytes : ${port.write(_stringToUint8List("HELLO WORLD!"))}");

                      // read form port
                      SerialPortReader reader = SerialPortReader(port);

                      // SerialPortReader returns only Unit8List Data
                      Stream<String> upcomingData = reader.stream.map((data) {
                        print("in reader :: $data / ${String.fromCharCodes(data)}");
                        return String.fromCharCodes(data);
                      });

                      upcomingData.listen((data) {
                        print("read data: $data");
                      });
                    }, child: Text("Send data")),
                    CardListTile('Description', port.description),
                    CardListTile('Transport', port.transport.toTransport()),
                    CardListTile('USB Bus', port.busNumber?.toPadded()),
                    CardListTile('USB Device', port.deviceNumber?.toPadded()),
                    CardListTile('Vendor ID', port.vendorId?.toHex()),
                    CardListTile('Product ID', port.productId?.toHex()),
                    CardListTile('Manufacturer', port.manufacturer),
                    CardListTile('Product Name', port.productName),
                    CardListTile('Serial Number', port.serialNumber),
                    CardListTile('MAC Address', port.macAddress),
                  ],
                );
              }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: initPorts,
        ),
      ),
    );
  }

  Uint8List _stringToUint8List(String data) {
    List<int> codeUnits = data.codeUnits;
    print("codeUnits $codeUnits");
    for (int i in codeUnits) {
      print(i.toHex());
    }
    Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}