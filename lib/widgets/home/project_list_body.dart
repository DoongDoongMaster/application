import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/widgets/home/project_body.dart';
import 'package:application/widgets/home/add_new_button.dart';
import 'package:application/widgets/home/n_column_grid_view.dart';
import 'package:application/widgets/home/project_preview.dart';
import 'package:application/widgets/home/home_header.dart';
import 'package:application/widgets/no_content_widget.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

/// 연습장 목록 화면 (모든 연습장 / 즐겨찾는 연습)
class ProjectListBody extends StatefulWidget {
  final bool favoriteOnly;
  static const int colCount = 4;
  final NavigationFunction onTab;

  const ProjectListBody({
    super.key,
    this.favoriteOnly = false,
    required this.onTab,
  });

  @override
  State<ProjectListBody> createState() => _ProjectListBodyState();
}

class _ProjectListBodyState extends State<ProjectListBody> {
  String? selectedId;

  selectProject(String id) {
    setState(() {
      selectedId = id;
    });
  }

  closeProject() {
    setState(() {
      selectedId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (selectedId == null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const HomeHeader(label: '연습장'),
                Expanded(
                  child: FutureBuilder<List<ProjectThumbnailViewData>>(
                    future: (database.select(database.projectThumbnailView)
                          ..orderBy([(u) => drift.OrderingTerm.desc(u.title)]))
                        .get(),
                    builder: (context, snapshot) {
                      List<Widget> gridList = [
                        if (!widget.favoriteOnly)
                          UnconstrainedBox(
                            child: AddNewButton(
                              label: '연습 추가',
                              size: ProjectPreview.size,
                              onPressed: () => widget.onTab(HomeTab.musicList),
                            ),
                          )
                      ];

                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return NColumnGridView(
                            colCount: ProjectListBody.colCount,
                            gridList: [
                              ...gridList,
                              ...snapshot.data!
                                  .where((data) =>
                                      data.isLiked || !widget.favoriteOnly)
                                  .map((data) => UnconstrainedBox(
                                        child: ProjectPreview(
                                          data: data,
                                          onPressed: () =>
                                              selectProject(data.id),
                                        ),
                                      ))
                            ],
                          );
                        }
                      }
                      return Column(
                        children: [
                          NColumnGridView(
                              colCount: ProjectListBody.colCount,
                              gridList: gridList),
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
          )
        else
          ProjectBody(
            key: const ValueKey<String>('project'),
            projectId: selectedId!,
            closeProject: closeProject,
          )
      ],
    );
  }
}
