import 'dart:math';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectPreview extends StatelessWidget {
  /// 연습 미리보기 카드 크기
  static const Size size = Size(154, 154);
  static final AutoSizeGroup _autoSizeGroup = AutoSizeGroup();
  final ProjectThumbnailViewData data;

  const ProjectPreview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: data.unreadCount ?? 0,
      alignment: Alignment.topRight,
      offset: Offset(
          5 * max(-2, 2 - data.unreadCount.toString().length.toDouble()), -5),
      isLabelVisible: (data.unreadCount ?? 0) > 0,
      child: ElevatedButton(
        onPressed: () {
          if (data.id.isNotEmpty) {
            context.pushNamed(
              RouterPath.project.name,
              pathParameters: {"id": data.id},
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Colors.white,
              width: 2.4,
              strokeAlign: -1,
            ),
          ),
          fixedSize: size,
          padding: const EdgeInsets.all(2.4),
          elevation: 2,
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.7),
        ),
        child: Badge(
          label: Icon(
            Icons.favorite_rounded,
            color: data.isLiked ? const Color(0xFFFF0000) : Colors.transparent,
            shadows: [
              if (!data.isLiked) ...[
                const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: data.type == MusicType.ddm
                      ? const Color(0xFFFFDD9E)
                      : const Color(0xFF898B9E),
                  blurRadius: 0,
                  offset: const Offset(0, 3),
                  spreadRadius: 0,
                )
              ]
            ],
          ),
          offset: const Offset(-12, 12),
          backgroundColor: Colors.transparent,
          largeSize: 24,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: data.type == MusicType.ddm
                          ? ColorStyles.primaryLight
                          : ColorStyles.secondary),
                  child: data.type == MusicType.ddm
                      ? Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 2),
                          child: Image.asset(
                            'assets/images/logo.png',
                          ),
                        )
                      : null,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      data.title,
                      // "dsafd",
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 12,
                      group: _autoSizeGroup,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
