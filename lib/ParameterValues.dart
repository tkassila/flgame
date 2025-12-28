import 'package:flutter/material.dart';

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
  static final int minusDynamicContainerSizeOfLGame = 18;
  static double containerWidth = 80;
  static double containerHeight = 80;
  void calculateInitValues()
  {
    ScreenValues.containerWidth = (availableWidth / 4).ceilToDouble() - ScreenValues.minusDynamicContainerSizeOfLGame;
    ScreenValues.containerHeight = ScreenValues.containerWidth;
  }
}

class ParameterValues extends InheritedWidget {
 // static final int minusDynamicContainerSizeOfLGame = 18;
//  static ScreenValues screenValues = new ScreenValues();

  const ParameterValues({ required this.screenValues,
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