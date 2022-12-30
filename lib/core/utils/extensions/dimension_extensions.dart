import 'package:flutter/material.dart';

extension GetAppHeight on num {
  // convert height
  double appHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const figmaDesignHeight = 844;
    double newScreenHeight = figmaDesignHeight / this.toDouble();
    return screenHeight / newScreenHeight;
  }

  //  convert width
  double appWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaDesignWidth = 390;
    double newScreenWidth = figmaDesignWidth / this.toDouble();
    return screenWidth / newScreenWidth;
  }
}
