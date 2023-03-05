import 'dart:io';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';

import 'color_editor.dart';
import 'deco_editor.dart';

class Preview extends StatelessWidget {
  const Preview({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode,
      storage: DevicePreviewStorage.none(),
      devices: [
        Devices.ios.iPhone13ProMax,
        Devices.ios.iPad,
        Devices.android.onePlus8Pro,
      ],
      tools: [
        const DecoEditor(),
        const ColorEditor(),
        DevicePreviewScreenshot(
          onScreenshot: screenshotAsFiles(Directory('E:\\')),
        ),
        const DeviceSection(),
        const SystemSection(),
        const AccessibilitySection(),
        const SettingsSection(),
        // ...DevicePreview.defaultTools,
      ],
      // availableLocales: [
      //   Locale('en'),
      //   Locale('sv'),
      // ],
      builder: (context) => child, // Wrap your app
    );
  }
}
