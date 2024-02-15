import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/one_line_text_with_marquee.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResponsiveProjectHeader extends StatelessWidget {
  static const double threshold = 200;
  const ResponsiveProjectHeader({
    super.key,
    required this.projectDetailInfo,
  });

  final ProjectDetailViewData projectDetailInfo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxHeight >= threshold
            ? _VerticalContent(
                maxHeight: constraints.maxHeight,
                projectDetailInfo: projectDetailInfo,
              )
            : _HorizontalContent(
                musicId: projectDetailInfo.musicId!,
                projectId: projectDetailInfo.id,
                title: projectDetailInfo.title,
              );
      },
    );
  }
}

/// 연습장 정보 최소 위젯.
class _HorizontalContent extends StatelessWidget {
  final String musicId, projectId, title;
  const _HorizontalContent(
      {required this.musicId, required this.title, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5),
      child: Row(
        children: [
          Expanded(
            child: OneLineTextWithMarquee(
              title,
              style: TextStyles.headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
              child: _StartButtonSet(
            flexNum: const [1, 1],
            musicId: musicId,
            projectId: projectId,
          )),
        ],
      ),
    );
  }
}

/// 연습장 정보 기본 위젯.
class _VerticalContent extends StatelessWidget {
  static const double heightThresh = 220;
  final double maxHeight;
  final ProjectDetailViewData projectDetailInfo;

  const _VerticalContent({
    required this.maxHeight,
    required this.projectDetailInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: OneLineTextWithMarquee(
                    projectDetailInfo.title,
                    alignment: Alignment.centerLeft,
                    style: TextStyles.headlineMedium
                        .copyWith(fontWeight: FontWeight.bold, height: 1),
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: OneLineTextWithMarquee(
                          projectDetailInfo.musicTitle!,
                          alignment: Alignment.bottomLeft,
                          style: TextStyles.headlineSmall.copyWith(height: 1.5),
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          projectDetailInfo.artist,
                          style: TextStyles.titleMedium.copyWith(
                            color: ColorStyles.darkGray,
                            height: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: maxHeight > heightThresh ? 3 : 1,
            child: Column(
              children: [
                if (maxHeight > heightThresh)
                  Expanded(
                    child: _InfoText(
                      artist: projectDetailInfo.artist,
                      bpm: projectDetailInfo.bpm,
                      length: projectDetailInfo.musicLength!,
                      createdAt: projectDetailInfo.createdAt,
                    ),
                  ),
                Expanded(
                  child: _StartButtonSet(
                    flexNum: const [3, 2],
                    musicId: projectDetailInfo.musicId!,
                    projectId: projectDetailInfo.id,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 완곡 연주, 구간 연습 버튼
class _StartButtonSet extends StatelessWidget {
  final List<int> flexNum;
  final String musicId, projectId;
  const _StartButtonSet({
    required this.flexNum,
    required this.musicId,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexNum[0],
          child: TextButtonWithIcon(
            label: '완곡 연주',
            icon: Icons.play_arrow_rounded,
            bgColor: ColorStyles.gray,
            color: ColorStyles.primary,
            onPressed: () {
              if (musicId.isEmpty) {
                return;
              }
              (database.select(database.musicInfos)
                    ..where((tbl) => tbl.id.equals(musicId)))
                  .getSingle()
                  .then((value) {
                context.pushNamed(RouterPath.prompt.name,
                    extra: value, pathParameters: {"id": projectId});
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: flexNum[1],
          child: TextButtonWithIcon(
            label: '구간 연습',
            icon: Icons.repeat_rounded,
            bgColor: const Color(0xFFFF6F1D),
            color: Colors.white,
            onPressed: () {}, // TODO: 구간연습 연결하기!!!
          ),
        )
      ],
    );
  }
}

class TextButtonWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color color;
  final void Function() onPressed;
  const TextButtonWithIcon({
    super.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          backgroundColor: bgColor,
          iconColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            opticalSize: 24,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyles.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// bpm, 재생시간, 생성일자 정보.
class _InfoText extends StatelessWidget {
  final String artist;
  final int bpm;
  final int length;
  final Duration duration;
  final DateTime createdAt;
  _InfoText({
    required this.bpm,
    required this.length,
    required this.createdAt,
    required this.artist,
  }) : duration = Duration(seconds: length);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AutoSizeText.rich(
        TextSpan(
          style: TextStyles.bodyLarge.copyWith(height: 1.25),
          children: [
            const TextSpan(
                text: 'BPM ', style: TextStyle(color: ColorStyles.darkGray)),
            TextSpan(text: bpm.toString()),
            const TextSpan(
                text: '\n재생 시간 ',
                style: TextStyle(color: ColorStyles.darkGray)),
            TextSpan(
                text: Duration(seconds: length).toString().substring(2, 7)),
            const TextSpan(
                text: '\n생성 일자 ',
                style: TextStyle(color: ColorStyles.darkGray)),
            TextSpan(
              text: createdAt.toString().substring(0, 10).replaceAll('-', '.'),
            ),
          ],
        ),
        overflowReplacement: Text(
          "",
          style: TextStyles.titleMedium.copyWith(
            color: ColorStyles.darkGray,
            height: 0.8,
          ),
        ),
        maxLines: 5,
        minFontSize: 10,
      ),
    );
  }
}
