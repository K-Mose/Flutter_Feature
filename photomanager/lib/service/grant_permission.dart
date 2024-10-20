import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> granPermissions() async {
  try {
    final bool videoGranted = await Permission.videos.isGranted;
    final bool photosGranted = await Permission.photos.isGranted;

    if (!photosGranted || !videoGranted) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
        Permission.videos,
      ].request();

      if (statuses[Permission.videos] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.photos] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  } catch (e) {
    debugPrint('Error granting permission: $e');
    rethrow;
  }
}