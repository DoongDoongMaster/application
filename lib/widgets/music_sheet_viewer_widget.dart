import 'dart:typed_data';
import 'package:application/styles/shadow_styles.dart';
import 'package:flutter/material.dart';

class MusicSheetBox extends DecoratedBox {
  MusicSheetBox({super.key, required Widget child})
      : super(
          decoration: const BoxDecoration(
            boxShadow: [ShadowStyles.shadow200],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: child,
          ),
        );
}

class MusicSheetWidget extends StatelessWidget {
  const MusicSheetWidget({
    super.key,
    required this.image,
  });

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.memory(
        image,
        width: 1024,
      ),
    );
  }
}
