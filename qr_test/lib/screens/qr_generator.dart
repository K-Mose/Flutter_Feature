import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorScreen extends StatelessWidget {
  QrGeneratorScreen({super.key});

  final qrKey = GlobalKey();
  String qrData = 'My Qr Data';
  final lists = [
    RepaintBoundary(
      child: QrImageView(
        data: "27EuXwTBdpM3X+nDv+Jxz8/+IoFOEtlJtjk4Ix1R7DrCNSBY1AkAH0P9zjbl3ZmgSBfs1pAeAVQAv/zrZr21awM3IW29OOT+FqYhijL95V2ckPWnuQ/GUi+lEPtWWiDg/+Q90puboVGEt3Cs9TfRf2NKKvePkFXLFoyz+DK8LGblNeHcgU6/rQg05pyZjohFN/mfCJWAUVrygSCXhWazWw==",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),/*
    RepaintBoundary(
      child: QrImageView(
        data: "Don't look at me!",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "https://www.naver.com",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "orderId=1",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "Your Data 1",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "Please look at me!",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "https://www.google.com",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),
    RepaintBoundary(
      child: QrImageView(
        data: "대충 스테이션 결제 정보에다가 pg사 연결 어캐하지",
        version: QrVersions.auto,
        size: 300.0,
      ),
    ),*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Generator"),
      ),
      body: GridView(
        gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio:  1/1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        padding: const EdgeInsets.all(10),
        children: lists
      ),
    );
  }
}
// """
// {
// "stationId":1,
// "stationName":"강남-KT-강남역1번출구",
// "stationAddress":"서울시 영등포구 국제금융로 3길 32",
// "returnBattery":[
// {"serialNo":"1234","remainSOC":10,"useSOC":90},
// {"serialNo":"1234","remainSOC":10,"useSOC":90}
// ],
// "reserveNo":"12345678",
// "totalAmount":90000}
// }
// """;