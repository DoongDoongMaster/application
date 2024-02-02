import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PracticeSettingModal extends StatefulWidget {
  const PracticeSettingModal({
    super.key,
  });

  @override
  State<PracticeSettingModal> createState() => _PracticeSettingModalState();
}

class _PracticeSettingModalState extends State<PracticeSettingModal> {
  static const int size = 5;
  static const List<double> speed = [0.5, 0.75, 1.0, 1.25, 1.5];
  int _value = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 540,
      height: 240,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 3,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 10,
              offset: Offset(0, 6),
              spreadRadius: 4,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // textBaseline: TextBaseline.ideographic,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context, -1.0);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: ColorStyles.primary,
                          size: 16,
                        ),
                        label: Text(
                          '나가기',
                          style: TextStyles.bodysmall
                              .copyWith(color: ColorStyles.primary),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: ColorStyles.secondary,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.arrow_back_ios_rounded,
                      //     color: ColorStyles.primary,
                      //     // size: 16,
                      //   ),
                      //   constraints: const BoxConstraints(),
                      //   padding: const EdgeInsets.fromLTRB(12, 0, 7, 0),
                      //   iconSize: 16,
                      //   tooltip: '나가기',
                      //   style: const ButtonStyle(
                      //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //   ),
                      // ),
                      // Text(
                      //   '나가기',
                      //   style: TextStyles.bodysmall
                      //       .copyWith(color: ColorStyles.primary),
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "완곡 연주를 시작하기 전에",
                    style: TextStyles.bodyMedium
                        .copyWith(color: ColorStyles.onSurfaceBlack),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          const Divider(height: 0),
          Container(
            height: 96,
            decoration: const BoxDecoration(color: ColorStyles.background),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '속도를 설정할 수 있습니다.',
                  style: TextStyles.bodysmall
                      .copyWith(color: ColorStyles.onSurfaceBlackVariant),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (_value != 2) const SizedBox(width: 32),
                    Wrap(
                      spacing: 5.0,
                      children: List<Widget>.generate(
                        size,
                        (int index) {
                          bool selected = _value == index;
                          return ChoiceChip(
                            labelStyle: TextStyles.bodysmall.copyWith(
                                color: selected ? Colors.white : Colors.black),
                            backgroundColor: ColorStyles.lightGray,
                            // shadowColor: Colors.transparent,
                            // surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            label: Text('${speed[index]}x'),
                            selected: selected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _value = index;
                                }
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                    if (_value != 2)
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: const Icon(
                            Icons.history_rounded,
                            size: 16,
                            color: ColorStyles.secondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _value = 2;
                            });
                          },
                          style: IconButton.styleFrom(
                              backgroundColor: ColorStyles.lighterGray),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          SizedBox(
            height: 96,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context, speed[_value]);
              },
              icon: const Icon(
                Icons.play_circle_fill_rounded,
                size: 64,
                color: ColorStyles.primary,
                shadows: [ShadowStyles.dropShadowSmall],
              ),
            ),
          )
        ],
      ),
    );
  }
}
