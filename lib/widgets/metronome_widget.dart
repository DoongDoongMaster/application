import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MetronomeWidget extends StatelessWidget {
  final ValueListenable<int> listenable;
  final bool isVisible;
  final double circleSize;
  const MetronomeWidget({
    super.key,
    required this.listenable,
    required this.isVisible,
    required this.circleSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: listenable,
      builder: (context, value, child) {
        return Visibility(
          visible: isVisible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 4; i++)
                CountCircle(
                  isFilled: i == value,
                  size: circleSize,
                )
            ],
          ),
        );
      },
    );
  }
}

class CountCircle extends StatelessWidget {
  final bool isFilled;
  final double size;
  const CountCircle({
    super.key,
    required this.isFilled,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:
                isFilled ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(180),
            border: Border.all(color: Theme.of(context).primaryColor, width: 3),
          ),
        ),
      ),
    );
  }
}
