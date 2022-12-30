import 'package:flutter/material.dart';

extension WidgetSpacing on num {
  SizedBox get spacingW => SizedBox(width: toDouble());
  SizedBox get spacingH => SizedBox(height: toDouble());
}

extension WidgetVisibility on Widget {
  Widget get visible => this;
  Widget get invisible => const SizedBox.shrink();
}

extension WidgetPadding on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

// align widget horizontal

extension WidgetAlignHorizontal on Widget {
  /// puts widget in a row and aligns it to the left
  Widget get alignLeft => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          this,
        ],
      );

  /// puts widget in a row and aligns it to the right
  Widget get alignRight => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          this,
        ],
      );

  /// puts widget in a row and aligns it to the center
  Widget get alignCenter => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this,
        ],
      );
}
