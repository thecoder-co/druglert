import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  const ShadowContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(187, 187, 187, 0.16),
            spreadRadius: 8,
            blurRadius: 23,
            offset: Offset(5, 15), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
