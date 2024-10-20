import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:libserialport/libserialport.dart';

class SerialPortScreen extends StatefulWidget {
  @override
  State<SerialPortScreen> createState() => _SerialPortScreenState();
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

class _SerialPortScreenState extends State<SerialPortScreen> {
  var availablePorts = [];

  @override
  void initState() {
    super.initState();
    initPorts();
  }

  void initPorts() {
    setState(() {
      availablePorts = SerialPort.availablePorts;
    });
    print(availablePorts);
  }

  @override
  Widget build(BuildContext context) {
    initPorts();
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Serial Port", textDirection: TextDirection.ltr,),),
      body: Scrollbar(
        child: ListView(
          children: [
            for (final address in availablePorts)
              Builder(builder: (context) {
                final port = SerialPort(address);
                print("$port / $address");
                return ExpansionTile(
                  title: Text(address, textDirection: TextDirection.ltr),
                  children: [
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
              })
          ],
        ),
      ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  const CardListTile(this.name, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(value ?? 'N/A', textDirection: TextDirection.ltr),
        subtitle: Text(name, textDirection: TextDirection.ltr),
      ),
    );
  }
}