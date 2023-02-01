import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kReleaseMode;
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'color_editor.dart';
import 'deco_editor.dart';

Widget Preview(Widget child) {
  return DevicePreview(
    enabled: !kReleaseMode,
    storage: DevicePreviewStorage.none(),
    devices: [
      Devices.ios.iPhone13ProMax,
      Devices.ios.iPad,
      Devices.android.onePlus8Pro,
    ],
    tools: [
      DecoEditor(),
      ColorEditor(),
      DevicePreviewScreenshot(
        onScreenshot: screenshotAsFiles(Directory('E:\\')),
      ),
      DeviceSection(),
      SystemSection(),
      AccessibilitySection(),
      SettingsSection(),
      // ...DevicePreview.defaultTools,
    ],
    // availableLocales: [
    //   Locale('en'),
    //   Locale('sv'),
    // ],
    builder: (context) => child, // Wrap your app
  );
}
