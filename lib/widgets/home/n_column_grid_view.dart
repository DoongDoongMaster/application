import 'package:flutter/material.dart';

/// 4칸 스크롤 영역.
class NColumnGridView extends StatelessWidget {
  final int colCount;
  final List<Widget> gridList;
  final double spacing;
  const NColumnGridView({
    super.key,
    required this.gridList,
    required this.colCount,
    this.spacing = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      mainAxisSpacing: spacing,
      crossAxisCount: colCount,
      children: gridList,
    );
  }
}
