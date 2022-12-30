import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isDisabled;
  final bool isOutlined;
  final Color? bgColor;
  final Color? textColor;
  final String? label;
  final double? height;
  final double? width;
  final Function()? onPressed;
  final TextStyle? textStyle;
  const AppButton(
      {super.key,
      this.isDisabled = false,
      this.isOutlined = false,
      this.bgColor,
      this.textColor,
      this.label,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle});

  const AppButton.outlined(
      {super.key,
      this.isDisabled = false,
      this.bgColor,
      this.textColor,
      this.label,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle})
      : isOutlined = true;
  const AppButton.secondary({
    super.key,
    this.isDisabled = false,
    this.isOutlined = false,
    this.label,
    this.onPressed,
    this.height,
    this.width,
    this.textStyle,
  })  : bgColor = const Color(0xfff8e3fa),
        textColor = const Color(0xffbf28ce);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isDisabled
                      ? const Color(0x3fbdbdbd)
                      : const Color(0xffbf28ce),
                  width: 1,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                label ?? 'Continue',
                style: const TextStyle(
                  color: Color(0xffbf28ce),
                  fontFamily: 'Outfit',
                  fontSize: 14,
                ),
              ))
          : ElevatedButton(
              onPressed: isDisabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: isDisabled
                    ? const Color(0x3fbdbdbd)
                    : bgColor ?? const Color(0xffbf28ce),
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                label ?? 'Continue',
                textAlign: TextAlign.center,
                style: textStyle ??
                    TextStyle(
                      color: isDisabled
                          ? const Color(0xffbdbdbd)
                          : textColor ?? Colors.white,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.24,
                    ),
              ),
            ),
    );
  }
}
