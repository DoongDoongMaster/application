import 'package:application/models/db/app_database.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReportListItem extends StatelessWidget {
  final PracticeListViewData data;
  const ReportListItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {}, //TODO: report 페이지 연결하기
      style: TextButton.styleFrom(
        shape: const LinearBorder(
          side: BorderSide(color: ColorStyles.gray),
          top: LinearBorderEdge(size: 1),
        ),
        padding: EdgeInsets.zero,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: Colors.black,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 6,
            height: 45,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: data.score == null
                    ? ColorStyles.graphWrongComponent
                    : data.isNew
                        ? ColorStyles.primary
                        : ColorStyles.secondary.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            data.title,
            style: TextStyles.bodyMedium,
            maxLines: 1,
          ),
          const Spacer(),
          if (data.score != null && data.isNew)
            Text(
              "new    ",
              style: TextStyles.bodysmall.copyWith(color: ColorStyles.primary),
            ),
          if (data.speed != null)
            _BlackGrayText(
                blackStr: data.speed!.toStringAsFixed(2), grayStr: 'x'),
          if (data.score == null)
            const SizedBox(
              width: 180,
              child: _ProcessingFlag(),
            )
          else ...[
            SizedBox(
              width: 75,
              child: _BlackGrayText(
                  blackStr: data.score.toString(), grayStr: '/100'),
            ),
            const SizedBox(width: 15),
            // 점수 별점으로 표기
            for (var i = 0; i < 5; i++)
              Transform.translate(
                offset: Offset(-4.0 * i, 0),
                child: Icon(
                  Icons.star_rounded,
                  color: i < data.score! / 20
                      ? ColorStyles.primary
                      : ColorStyles.stroke,
                  size: 18,
                ),
              ),
          ],
          SizedBox(
            height: 30,
            width: 30,
            child: PopupMenuButton(
              padding: EdgeInsets.zero,
              onSelected: (value) {
                switch (value) {
                  case 0:
                  // TODO: 연습 삭제 함수 만들기.
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 28,
                  value: 0,
                  child: ListTile(
                    trailing: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                    ),
                    leading: Text("삭제하기"),
                  ),
                )
              ],
              icon: const Icon(
                Icons.more_horiz_rounded,
                size: 20,
                color: ColorStyles.secondary,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _ProcessingFlag extends StatelessWidget {
  const _ProcessingFlag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 25),
        CustomPaint(painter: _ChatBubbleNip(Colors.black)),
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [ShadowStyles.shadow300]),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.replay_rounded, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                SizedBox(
                  height: 18,
                  child: AutoSizeText(
                    "채점 중...",
                    style: const TextStyle(color: ColorStyles.primary),
                    maxLines: 1,
                    maxFontSize: TextStyles.bodysmall.fontSize!,
                    minFontSize: 1,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ChatBubbleNip extends CustomPainter {
  final Color bgColor;

  _ChatBubbleNip(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(0, -6);
    path.lineTo(-10, 0);
    path.lineTo(0, 6);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _BlackGrayText extends StatelessWidget {
  final String blackStr, grayStr;
  const _BlackGrayText({
    required this.blackStr,
    required this.grayStr,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyles.bodyMedium,
        children: [
          TextSpan(text: blackStr),
          TextSpan(
            text: grayStr,
            style: const TextStyle(color: ColorStyles.graphMiss),
          ),
        ],
      ),
      textAlign: TextAlign.end,
    );
  }
}
