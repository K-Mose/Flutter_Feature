import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State createState() {
    return _QrScannerState();
  }
}



class _QrScannerState extends State<QrScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final qrKey = GlobalKey(debugLabel: 'QR');

  var pgConnectiong = false;

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((data) {
      setState(() {
        result = data;
        pgConnectiong = true;
        controller.stopCamera();
      });
      // 로딩화면 띄우고
    });
    // controller.flipCamera();
  }


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS){
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: QRView(
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 20,
                    borderWidth: 5,
                    cutOutSize: 250
                  ),
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                )
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: (result != null) ?
                    Column(
                      children: [
                        SizedBox(height: 30,),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}"
                          )
                        ),
                      ],
                    )
                    : const Text("Scan a Code")
                )
              )
            ],
          ),
          if (pgConnectiong)
            Container(
              height: double.infinity,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (pgConnectiong)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: TextButton(onPressed: () {
                setState(() {
                  pgConnectiong = false;
                  controller!.resumeCamera();
                });
              }, child: const Text("Cancel"))
            )

        ]
      ),
    );
  }
}