import 'dart:ui';
import 'package:flutter/material.dart';

class ZoomableContainer extends StatelessWidget {
  final Widget child;

  const ZoomableContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20),
      minScale: 0.5,
      maxScale: 3.0,
      child:child
    );
  }
}
