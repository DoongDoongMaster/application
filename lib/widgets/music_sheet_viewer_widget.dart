import 'dart:typed_data';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:flutter/material.dart';

class MusicSheetBox extends DecoratedBox {
  const MusicSheetBox({super.key, required Widget child})
      : super(
          decoration: const BoxDecoration(
            boxShadow: [ShadowStyles.shadow200],
            color: Colors.white,
          ),
          child: child,
        );
}

class MusicSheetWidget extends Image {
  MusicSheetWidget({
    super.key,
    required Uint8List image,
  }) : super.memory(image, width: MusicInfo.imageWidth);
}
