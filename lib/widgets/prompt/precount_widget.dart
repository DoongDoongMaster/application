import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PrecountWidget extends StatefulWidget {
  final int usPerBeat;
  final int usPerSixteenth;
  final Future<void> Function() startPractice;

  const PrecountWidget({
    super.key,
    required this.usPerBeat,
    required this.startPractice,
  }) : usPerSixteenth = usPerBeat ~/ 4;

  @override
  State<PrecountWidget> createState() => _PrecountWidgetState();
}

class _PrecountWidgetState extends State<PrecountWidget> {
  late final Ticker _ticker;

  static const int quaterCountMax = 4;
  static const int sixteenthCountMax = 4 * quaterCountMax;

  int quaterCount = 0;
  int sixteenthCount = -4;
  int usCounter = 0;

  @override
  void initState() {
    super.initState();

    _ticker = Ticker((Duration elapsed) {
      if (elapsed.inMicroseconds - usCounter >= widget.usPerSixteenth) {
        usCounter = elapsed.inMicroseconds;
        setState(() {
          sixteenthCount++;
        });

        if (sixteenthCount == sixteenthCountMax) {
          _ticker.stop();
          _ticker.dispose();
          Navigator.pop(context);
        }
      }
    });
    startPrecount();
  }

  startPrecount() async {
    sixteenthCount = 0;
    await widget.startPractice();
    _ticker.start();
  }

  @override
  void dispose() {
    super.dispose();
    if (_ticker.isActive) {
      _ticker.stop();
      _ticker.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 135,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < quaterCountMax; i++)
            CountCircle(
              usPerSixteenth: widget.usPerSixteenth,
              count: sixteenthCount % 4,
              label: (i + 1).toString(),
              isActive: (sixteenthCount ~/ 4 == i),
            )
        ],
      ),
    );
  }
}

class CountCircle extends StatelessWidget {
  static final List<double> _borderRadius = [14, 30.5, 5, 14];
  final int usPerSixteenth;
  final int count;
  final String label;
  final bool isActive;

  const CountCircle({
    super.key,
    required this.count,
    required this.label,
    required this.usPerSixteenth,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 100,
        width: 100,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color:
                isActive ? ColorStyles.primary : ColorStyles.secondaryShadow90,
            shape: BoxShape.circle,
            boxShadow: [
              isActive
                  ? BoxShadow(
                      spreadRadius: _borderRadius[count],
                      color: ColorStyles.primaryShadow50,
                    )
                  : const BoxShadow(),
              ShadowStyles.dropShadow,
            ],
          ),
          duration: Duration(microseconds: usPerSixteenth),
          child: Center(
            child: Text(
              label,
              style: TextStyles.displayLarge.copyWith(
                color: isActive ? Colors.white : ColorStyles.whiteShadow80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
