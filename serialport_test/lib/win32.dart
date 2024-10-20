import 'package:flutter/material.dart';
import 'package:serial_port_win32/serial_port_win32.dart';

class SerialPortWin32 extends StatefulWidget {
  @override
  State<SerialPortWin32> createState() => _SerialPortWin32State();
}

class _SerialPortWin32State extends State<SerialPortWin32> {
  var ports = [];
  SerialPort? port;
  @override
  void initState() {
    super.initState();
    port = SerialPort("COM1", openNow: true, ByteSize: 8, ReadIntervalTimeout: 1, ReadTotalTimeoutConstant: 2);
    openNewPort();
    ports = SerialPort.getAvailablePorts();
    print(ports);
    print(port);
  }

  void openNewPort() {
    if (port != null) {
      port!.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(ports);
    print(ports.length);
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: ports.length,
          itemBuilder: (context, index) {
            return Text(ports[index]);
          },
        ),
      ),
    );
  }
}