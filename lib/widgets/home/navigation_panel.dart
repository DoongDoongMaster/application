import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/main.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

/// 연습장 화면 왼쪽 패널
class NavigationPanel extends StatelessWidget {
  final HomeTab currentTab;
  final String? projectId;
  final bool isProjectListOpen;
  final NavigationFunction onTab;
  final void Function() toggleList;
  // final RouterPath currentPath;
  // final String? projectId;

  const NavigationPanel({
    super.key,
    required this.currentTab,
    required this.isProjectListOpen,
    required this.projectId,
    required this.onTab,
    required this.toggleList,
    // this.currentPath = RouterPath.home,
    // this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 4,
      decoration: const BoxDecoration(
        color: ColorStyles.panelBackground,
        border: Border(
          right:
              BorderSide(color: ColorStyles.stroke, width: 1, strokeAlign: -1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 40, 14, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Text(
              "둥둥마스터",
              style: TextStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          MenuChip(
            label: "즐겨찾는 연습",
            icon: Icons.favorite_border_rounded,
            // onSelected: (x) => changePath(x, path: RouterPath.favoriteList),
            isSelected: currentTab == HomeTab.favoriteProjectList,
            onSelected: (_) => onTab(HomeTab.favoriteProjectList),
          ),
          MenuChip(
            label: "악보 리스트",
            icon: Icons.queue_music_rounded,
            // onSelected: (x) => changePath(x, path: RouterPath.favoriteList),
            isSelected: currentTab == HomeTab.musicList,
            onSelected: (_) => onTab(HomeTab.musicList),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 12),
            child: ActionChip(
              onPressed: toggleList,
              labelPadding: const EdgeInsets.symmetric(vertical: 3),
              visualDensity: const VisualDensity(vertical: -3),
              padding: EdgeInsets.zero,
              label: Row(
                children: [
                  const SizedBox(width: 8),
                  Text("연습장",
                      style: TextStyles.titleLarge
                          .copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(
                    isProjectListOpen
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right_rounded,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          if (isProjectListOpen) ...[
            MenuChip(
              label: "모든 연습장",
              icon: Icons.apps_rounded,
              isSelected: currentTab == HomeTab.projectList,
              onSelected: (_) => onTab(HomeTab.projectList),
            ),
            const Divider(),
            FutureBuilder<List<ProjectSidebarViewData>>(
              future: (database.select(database.projectSidebarView)
                    ..orderBy([
                      (u) => drift.OrderingTerm.desc(
                          database.projectSidebarView.createdAt)
                    ]))
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: snapshot.data!
                          .map((data) => MenuChip(
                                label: data.title,
                                isSelected: projectId == data.id,
                                onSelected: (_) =>
                                    onTab(HomeTab.project, selectedId: data.id),
                                iconBgColor: data.type == MusicType.ddm
                                    ? ColorStyles.primaryLight
                                    : ColorStyles.secondary,
                                iconWidget: data.type == MusicType.ddm
                                    ? Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                        ),
                                      )
                                    : null,
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ] else
            const Spacer(),
          MenuChip(
            label: "새로운 연습",
            isSelected: currentTab == HomeTab.musicList,
            onSelected: (_) => onTab(HomeTab.musicList),
            iconBgColor: currentTab == HomeTab.musicList
                ? Colors.transparent
                : const Color(0xFFE7E7EE),
            icon: Icons.add_rounded,
            textDefaultColor: ColorStyles.primary,
          ),
        ],
      ),
    );
  }
}

class MenuChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData? icon;
  final Widget? iconWidget;
  final Color iconBgColor;
  final Color textDefaultColor;
  final void Function(bool) onSelected;

  const MenuChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.icon,
    this.iconBgColor = Colors.transparent,
    this.textDefaultColor = Colors.black,
    this.iconWidget,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      selected: isSelected,
      labelPadding: const EdgeInsets.symmetric(vertical: 3),
      visualDensity: const VisualDensity(vertical: -3),
      labelStyle: TextStyles.bodyLarge.copyWith(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.white : textDefaultColor,
        overflow: TextOverflow.ellipsis,
      ),
      avatar: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: iconBgColor,
        ),
        child: iconWidget ??
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : ColorStyles.primary,
            ),
      ),
      label: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      onSelected: onSelected,
    );
  }
}
