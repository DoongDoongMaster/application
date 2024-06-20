import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;

Uint8List cropImage(
  Uint8List image, {
  required Rect rect,
  double scale = 1,
}) {
  imglib.Image src = imglib.decodeImage(image)!;
  var x = (rect.left * scale).toInt();
  var y = (rect.top * scale).toInt();
  var w = (rect.width * scale).toInt();
  if (w == 0) {
    w = src.width - x;
  }
  var h = (rect.height * scale).toInt();
  if (h == 0) {
    h = src.height - y;
  }

  return imglib.encodePng(
    imglib.copyCrop(
      src,
      x: x,
      y: y,
      width: w,
      height: h,
      antialias: true,
    ),
  );
}
