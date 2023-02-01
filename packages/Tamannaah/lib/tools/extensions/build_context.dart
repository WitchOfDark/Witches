import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart'
    show BuildContext, ModalRoute, Size, MediaQueryData, Orientation, MediaQuery;
import 'dart:math';

extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}

class Device {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIos => Platform.isIOS;
  static bool get isMobile => isAndroid || isIos;
  static bool get isWebMobile => isAndroid || isIos || isWeb;
  static bool get isWindows => Platform.isWindows;
  static bool get isMac => Platform.isMacOS;
  static bool get isPc => isMac || isWindows;
  static bool get isWeb => kIsWeb;
}

extension SizedContext on BuildContext {
  double get pixelsPerInch => Platform.isAndroid || Platform.isIOS ? 150 : 96;

  bool get keyboardVisible => mq.viewInsets.bottom != 0;

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  double get shortPx => sizePx.shortestSide;

  double get ratiotPx => mq.devicePixelRatio;
  double get txScale => mq.textScaleFactor;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  double get ratioHW => sizePx.height / sizePx.width;

  /// Returns diagonal screen pixels
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Returns pixel size in Inches
  Size get sizeInches {
    final Size pxSize = sizePx;
    return Size(pxSize.width / pixelsPerInch, pxSize.height / pixelsPerInch);
  }

  /// Returns screen width in Inches
  double get widthInches => sizeInches.width;

  /// Returns screen height in Inches
  double get heightInches => sizeInches.height;

  /// Returns screen diagonal in Inches
  double get diagonalInches => diagonalPx / pixelsPerInch;

  /// Returns fraction (0-1) of screen width in pixels
  double widthPct(double fraction) => fraction * widthPx;

  /// Returns fraction (0-1) of screen height in pixels
  double heightPct(double fraction) => fraction * heightPx;
}
