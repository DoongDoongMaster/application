import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/views/project_summary_view.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/delete_confirm_dialog.dart';
import 'package:application/widgets/no_content_widget.dart';
import 'package:application/widgets/project/analysis_summary.dart';
import 'package:application/widgets/project/panel.dart';
import 'package:application/widgets/project/report_list_item.dart';
import 'package:application/widgets/responsive_project_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectBody extends StatelessWidget {
  final String projectId;
  final void Function()? closeProject;
  const ProjectBody({super.key, required this.projectId, this.closeProject});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                titleSpacing: 0,
                expandedHeight: 288 + 24,
                collapsedHeight: 112 + 24,
                backgroundColor: ColorStyles.background,
                flexibleSpace: FutureBuilder<List<ProjectDetailViewData>>(
                    future: (database.select(database.projectDetailView)
                          ..where((tbl) => tbl.id.equals(projectId)))
                        .get(),
                    initialData: [
                      ProjectDetailViewData(
                        id: '',
                        title: '-',
                        musicTitle: '-',
                        musicId: '',
                        isLiked: false,
                        createdAt: DateTime.now(),
                        artist: '-',
                        bpm: 90,
                        type: MusicType.ddm,
                        measureList: [],
                      )
                    ],
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isEmpty) {
                        context.goNamed(RouterPath.home.name);
                        return const CircularProgressIndicator();
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _TopHeaderTemp(
                              key: Key(
                                  '$projectId-top-header-${snapshot.data![0].isLiked}'),
                              initialLiked: snapshot.data![0].isLiked,
                              projectId: projectId,
                              closeProject: closeProject,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: ProjectHeader(data: snapshot.data![0]),
                            ),
                          ],
                        );
                      }
                    }),
              ),
              FutureBuilder<AnalysisSummaryData?>(
                  future: database.getAnalysisSummaryData(projectId, 8),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else if (snapshot.data!.accuracyList.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: SizedBox(),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, bottom: 15, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5),
                                foregroundColor: Colors.black,
                                minimumSize: const Size(0, 0),
                                disabledIconColor: ColorStyles.lightGray,
                                iconColor: ColorStyles.primary,
                              ),
                              onPressed: () {}, //TODO: 그래프 자세히 보기
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '완곡 점수 그래프',
                                    style: TextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 2,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                            if (snapshot.data!.accuracyList.isNotEmpty)
                              AnalysisSummary(data: snapshot.data!),
                          ],
                        ),
                      ),
                    );
                  }),
              FutureBuilder<List<PracticeListViewData>>(
                future: database.getPracticeList(projectId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 24),
                        child: Panel(
                          size: const Size(0, 400),
                          child: const Center(
                            child: NoContentWidget(
                              title: '연주 기록이 비어 있음',
                              subTitle: '완곡 연주 버튼을 눌러 연주를 시작하세요.',
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.only(left: 40),
                    sliver: DecoratedSliver(
                      position: DecorationPosition.background,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                            color: Colors.transparent.withOpacity(0.08),
                            // color: Colors.red,
                          ),
                        ],
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "완곡 레포트",
                                  style: TextStyles.bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                            return ReportListItem(
                              data: snapshot.data![index - 1],
                            );
                          },
                          childCount: snapshot.data!.length + 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProjectHeader extends StatelessWidget {
  final ProjectDetailViewData data;
  const ProjectHeader({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: _BigThumbnail(data.type),
          ),
          Expanded(
            child: ResponsiveProjectHeader(projectDetailInfo: data),
          ),
        ],
      ),
    );
  }
}

class _TopHeaderTemp extends StatefulWidget {
  final bool initialLiked;
  final String projectId;
  final void Function()? closeProject;
  const _TopHeaderTemp({
    super.key,
    required this.initialLiked,
    required this.projectId,
    this.closeProject,
  });

  @override
  State<_TopHeaderTemp> createState() => _TopHeaderTempState();
}

class _TopHeaderTempState extends State<_TopHeaderTemp> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.closeProject != null)
          TextButton(
            onPressed: widget.closeProject,
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Text("연습장",
                    style: TextStyles.bodyMedium
                        .copyWith(color: ColorStyles.primary))
              ],
            ),
          ),
        const Spacer(),
        IconButton(
          icon: Icon(
              isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded),
          iconSize: 20,
          color: isLiked ? Colors.red : null,
          onPressed: () async {
            isLiked = (await database.toggleProjectLike(widget.projectId) != 0);
            setState(() {});
          },
          style: IconButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: ColorStyles.gray,
            padding: EdgeInsets.zero,
            fixedSize: const Size(24, 24),
          ),
          constraints: const BoxConstraints(),
        ),
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorStyles.gray,
          ),
          child: PopupMenuButton(
            iconSize: 20,
            icon: const Icon(Icons.more_horiz_rounded),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onSelected: (value) async {
              switch (value) {
                case 0:
                  var response = await showDialog<DeleteConfirm>(
                      context: context,
                      builder: (context) => DeleteConfirmDialog(
                          guideText: '연습장을 삭제하면 연습장의 모든 기록도 삭제됩니다!'));

                  if (response == DeleteConfirm.ok) {
                    database.deleteProject(widget.projectId).then((value) {
                      context.pushReplacementNamed(RouterPath.home.name,
                          queryParameters: {'refresh': ''});
                    });
                  }
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
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

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
