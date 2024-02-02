import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/home/Navigation_panel.dart';
import 'package:application/widgets/responsive_project_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectScreen extends StatefulWidget {
  final String? projectId;

  const ProjectScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  ProjectDetailViewData projectDetailInfo = ProjectDetailViewData(
    id: '',
    title: '연습장',
    musicTitle: '곡 제목',
    musicId: '',
    isLiked: false,
    createdAt: DateTime.now(),
    artist: '이름 없는 아티스트',
    bpm: 100,
    type: MusicType.ddm,
    musicLength: 0,
  );

  @override
  void initState() {
    super.initState();
    (database.select(database.projectDetailView)
          ..where((tbl) => tbl.id.equals(widget.projectId!)))
        .getSingle()
        .then((value) => setState(() {
              projectDetailInfo = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.projectId == null) {
      context.go(RouterPath.list.name);
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationPanel(
            currentPath: RouterPath.project,
            projectId: widget.projectId,
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    if (context.canPop()) const BackButtonWithText(),
                    const Spacer(),
                    IconButtonWithGrayBackground(
                      icon: projectDetailInfo.isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: projectDetailInfo.isLiked ? Colors.red : null,
                      onPressed: () async {
                        projectDetailInfo = projectDetailInfo.copyWith(
                            isLiked: (await database
                                    .toggleProjectLike(widget.projectId!) !=
                                0));

                        setState(() {});
                      },
                    ),
                    IconButtonWithGrayBackground(
                      icon: Icons.more_horiz_rounded,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        titleSpacing: 0,
                        expandedHeight: 288,
                        collapsedHeight: 112,
                        backgroundColor: ColorStyles.background,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 24, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: _BigThumbnail(),
                              ),
                              Expanded(
                                child: ResponsiveProjectHeader(
                                    projectDetailInfo: projectDetailInfo),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// items
                      for (var i = 0; i < 10; i++) ...[
                        SliverToBoxAdapter(
                          child: Container(
                            color: Colors.black,
                            height: 100,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            color: Colors.blue,
                            height: 100,
                          ),
                        )
                      ]
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 연습 섬네일 TODO: 사용자 등록 악보 섬네일 따로 처리 필요함.
class _BigThumbnail extends StatelessWidget {
  const _BigThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ColorStyles.primaryLight,
          border: Border.all(
            color: Colors.white,
            width: 2.4,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorStyles.blackShadow8,
              blurRadius: 24,
              offset: Offset(0, 12),
            )
          ]),
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}

/// 작은 아이콘 버튼 & 회색 원 배경
class IconButtonWithGrayBackground extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final void Function() onPressed;
  const IconButtonWithGrayBackground({
    super.key,
    required this.icon,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 20,
      color: color,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: ColorStyles.gray,
        padding: EdgeInsets.zero,
        fixedSize: const Size(24, 24),
      ),
      constraints: const BoxConstraints(),
    );
  }
}

class BackButtonWithText extends StatelessWidget {
  const BackButtonWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pop();
      },
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back_ios_rounded,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text("연습장",
              style: TextStyles.bodyMedium.copyWith(color: ColorStyles.primary))
        ],
      ),
    );
  }
}
