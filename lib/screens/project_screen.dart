import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/home/Navigation_panel.dart';
import 'package:application/widgets/no_content_widget.dart';
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
                    if (context.canPop())
                      const BackButtonWithText(label: '연습장'),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: _BigThumbnail(projectDetailInfo.type),
                              ),
                              Expanded(
                                child: ResponsiveProjectHeader(
                                    projectDetailInfo: projectDetailInfo),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 24),
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF3F1ED),
                            ),
                            alignment: Alignment.center,
                            child: const NoContentWidget(
                              title: '연주 기록이 비어 있음',
                              subTitle: '완곡 연주 버튼을 눌러 연주를 시작하세요.',
                            ),
                          ),
                        ),
                      ),
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
  final MusicType musicType;
  const _BigThumbnail(this.musicType);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: musicType == MusicType.ddm
            ? ColorStyles.primaryLight
            : ColorStyles.secondary,
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
        ],
      ),
      child: Image.asset(
        'assets/images/logo.png',
        color: musicType != MusicType.ddm ? Colors.transparent : null,
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
  final String label;
  const BackButtonWithText({
    super.key,
    required this.label,
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
          Text(label,
              style: TextStyles.bodyMedium.copyWith(color: ColorStyles.primary))
        ],
      ),
    );
  }
}
