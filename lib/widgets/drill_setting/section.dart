import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/widgets/positioned_container.dart';
import 'package:flutter/material.dart';

enum SectionType {
  one(level: 1, color: ColorStyles.primary),
  two(level: 2, color: Color(0xFF5EC505)),
  three(level: 3, color: Color(0xFF269EFB)),
  four(level: 4, color: Color(0xFFAA26FB));

  const SectionType({
    required this.color,
    required this.level,
  });

  static const double height = 20;
  static const int count = 4;
  final Color color;
  final int level;
  double get marginBottom => SectionType.height * (level - 4);
}

/// 구간이 악보에 표시될 때 단위 -> 여러줄에 걸친 구간은 여러 section으로 이루어져 있음
class Section {
  final String id;
  final int start, end;
  final bool hasLeftBorder, hasRightBorder;
  late final Cursor cursor;
  late final SectionType type;
  bool isSelected;

  Section({
    required this.id,
    required this.start,
    required this.end,
    required this.hasLeftBorder,
    required this.hasRightBorder,
    this.isSelected = false,
  });
}

/// 이어지는 부분 border 그리면 안됨!!!!!
class SectionWidget extends StatelessWidget {
  static const double gap = 4;
  final Section data;
  final bool isActive;
  final bool isSelected;
  const SectionWidget({
    super.key,
    required this.data,
    required this.isActive,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    late Color color;
    if (isActive) {
      color = data.type.color;
    } else {
      color = ColorStyles.secondary;
    }
    if (isSelected) {
      color = color.withOpacity(0.8);
    } else {
      color = color.withOpacity(0.24);
    }

    BorderSide borderSide = BorderSide(
      color: color,
      strokeAlign: BorderSide.strokeAlignInside,
      width: 1,
      style: BorderStyle.solid,
    );
    return PositionedContainer(
      cursor: data.cursor.copyWith(
        x: data.cursor.x + (data.hasLeftBorder ? gap : 0),
        w: data.cursor.w -
            (data.hasLeftBorder ? gap : 0) -
            (data.hasRightBorder ? gap : 0),
        y: data.cursor.y + data.type.marginBottom,
      ),
      height: SectionType.height,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: borderSide,
          bottom: borderSide,
          left: data.hasLeftBorder ? borderSide : BorderSide.none,
          right: data.hasRightBorder ? borderSide : BorderSide.none,
        ),
        borderRadius: BorderRadius.horizontal(
          left: data.hasLeftBorder ? const Radius.circular(4) : Radius.zero,
          right: data.hasRightBorder ? const Radius.circular(4) : Radius.zero,
        ),
      ),
    );
  }
}

class SectionMarker extends StatelessWidget {
  static const double markerSize = 24;
  final Section data;
  final bool isActive;
  const SectionMarker({super.key, required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: data.cursor.x - markerSize / 2 + SectionWidget.gap,
      top: data.cursor.y -
          markerSize / 2 +
          SectionType.height / 2 +
          SectionType.height +
          data.type.marginBottom,
      child: Icon(
        Icons.circle,
        color: isActive
            ? data.type.color
            : ColorStyles.secondary.withOpacity(0.54),
        size: markerSize,
      ),
    );
  }
}
