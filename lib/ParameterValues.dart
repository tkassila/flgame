import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as io;

enum Platform { android, ios, web, }
class PlatformClass {
    static Platform getPlatform() {
        if (io.Platform.isAndroid) return Platform.android;
        if (io.Platform.isIOS) return Platform.ios;
        return Platform.web;
        //  throw UnimplementedError('Unsupported');
  }
}

class ScreenValues {
  ScreenValues(
  {
    required this.bScreenReaderIsUsed,
    required this.deviceWidth,
    required this.padding_right,
    required this.padding_left,
    required this.availableWidth,
    required this.deviceHeight,
    required this.availableHeight,
}){
    calculateInitValues();
  }

  final bool bScreenReaderIsUsed;
  final double deviceWidth;
  final double padding_right;
  final double padding_left;
  final double availableWidth;
  final double deviceHeight;
  final double availableHeight;
  static final int minusDynamicContainerSizeOfLGame = !kIsWeb ? 18 : 38;
  static double containerWidth = 80;
  static double containerHeight = 80;
  static final bool isWeb = kIsWeb /* PlatformClass.getPlatform() == Platform.web */
  /* kIsWeb */;

  void calculateInitValues()
  {
    ScreenValues.containerWidth = (availableWidth / 4).ceilToDouble() - ScreenValues.minusDynamicContainerSizeOfLGame;
    ScreenValues.containerHeight = ScreenValues.containerWidth;
  }
  static ValueNotifier<bool>? notifier;
}

class ParameterValues extends InheritedWidget {
 // static final int minusDynamicContainerSizeOfLGame = 18;
//  static ScreenValues screenValues = new ScreenValues();

  const ParameterValues({super.key,  required this.screenValues,
    required super.child });
  final ScreenValues screenValues;

  static ParameterValues? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ParameterValues>();
  }

  @override
  bool updateShouldNotify(ParameterValues oldWidget) {
    return true;
  }
}