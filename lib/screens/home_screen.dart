import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/router.dart';
import 'package:application/widgets/home/add_new_button.dart';
import 'package:application/widgets/home/n_column_grid_view.dart';
import 'package:application/widgets/home/navigation_panel.dart';
import 'package:application/widgets/home/project_preview.dart';
import 'package:application/widgets/home/home_header.dart';
import 'package:application/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 연습장 목록 화면 (모든 연습장 / 즐겨찾는 연습)
class HomeScreen extends StatelessWidget {
  final bool favoriteOnly;
  static const int colCount = 4;
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
                                size: ProjectPreview.size,
                                onPressed: () =>
                                    context.goNamed(RouterPath.musicList.name),
                              ),
                            )
                        ];

                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return NColumnGridView(
                                colCount: colCount,
                                gridList: [
                                  ...gridList,
                                  ...snapshot.data!
                                      .where((data) =>
                                          data.isLiked || !favoriteOnly)
                                      .map((data) => UnconstrainedBox(
                                            child: ProjectPreview(data: data),
                                          ))
                                ]);
                          }
                        }
                        return Column(
                          children: [
                            NColumnGridView(
                                colCount: colCount, gridList: gridList),
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
