import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkPermissionFile(BuildContext context) async {
  print("permission Check ::: FILE");
  final requestStatus = await Permission.photos.request();
  final requestStatus2 = await Permission.storage.request();
  final status = await Permission.photos.status;
  print("permission Check ::: $status");
  print("permission Check ::: $requestStatus");
  if (Platform.isAndroid) {

  }
  if (status.isGranted || status.isLimited) {
    print("permission Check ::: granted");
    return true;
  }
  else if (status.isDenied || requestStatus.isDenied) {
    print("permission Check ::: denied");
  }
  else if (status.isPermanentlyDenied || requestStatus.isPermanentlyDenied
      || status.isRestricted || requestStatus.isRestricted) {
    print("permission Check ::: permanentlyDenied");
  }
  return false;
}