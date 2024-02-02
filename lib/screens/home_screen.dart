import 'dart:math';

import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/home/add_new_button.dart';
import 'package:application/widgets/home/navigation_panel.dart';
import 'package:application/widgets/home_header.dart';
import 'package:application/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 연습장 목록 화면 (모든 연습장 / 즐겨찾는 연습)
class HomeScreen extends StatelessWidget {
  final bool favoriteOnly;
  const HomeScreen({
    super.key,
    this.favoriteOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationPanel(
              currentPath:
                  favoriteOnly ? RouterPath.favoriteList : RouterPath.list),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const HomeHeader(label: '연습장'),
                  Expanded(
                    child: FutureBuilder<List<ProjectThumbnailViewData>>(
                      future:
                          database.select(database.projectThumbnailView).get(),
                      builder: (context, snapshot) {
                        List<Widget> gridList = [
                          if (!favoriteOnly)
                            UnconstrainedBox(
                              child: AddNewButton(
                                label: '연습 추가',
                                size: _ProjectPreview.size,
                                onPressed: () =>
                                    context.goNamed(RouterPath.musicList.name),
                              ),
                            )
                        ];

                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return FourColumnGridView(gridList: [
                              ...gridList,
                              ...snapshot.data!
                                  .where(
                                      (data) => data.isLiked || !favoriteOnly)
                                  .map((data) => UnconstrainedBox(
                                        child: _ProjectPreview(data: data),
                                      ))
                            ]);
                          }
                        }
                        return Column(
                          children: [
                            FourColumnGridView(gridList: gridList),
                            const SizedBox(height: 20),
                            const NoContentWidget(
                              title: "연습장이 비어 있음",
                              subTitle: "새로운 연습을 추가하세요.",
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 4칸 스크롤 영역.
class FourColumnGridView extends StatelessWidget {
  const FourColumnGridView({
    super.key,
    required this.gridList,
  });

  final List<Widget> gridList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      children: gridList,
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  /// 연습 미리보기 카드 크기
  static const Size size = Size(154, 154);
  final ProjectThumbnailViewData data;

  const _ProjectPreview({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: data.unreadCount!,
      alignment: Alignment.topRight,
      offset: Offset(
          5 * max(-2, 2 - data.unreadCount.toString().length.toDouble()), -5),
      isLabelVisible: data.unreadCount != 0,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed(
            RouterPath.project.name,
            pathParameters: {"id": data.id},
          );
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
          shadowColor: Colors.transparent.withOpacity(0.7),
        ),
        child: Badge(
          label: Icon(
            Icons.favorite_rounded,
            color: data.isLiked ? const Color(0xFFFF0000) : Colors.transparent,
            shadows: [
              if (!data.isLiked) ...[
                BoxShadow(
                  color: Colors.transparent.withOpacity(0.25),
                  offset: const Offset(0, 0),
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
              Text(
                data.title,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
