import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/main.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 연습장 화면 왼쪽 패널
class NavigationPanel extends StatefulWidget {
  final RouterPath currentPath;
  final String? projectId;

  const NavigationPanel({
    super.key,
    this.currentPath = RouterPath.list,
    this.projectId,
  });

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  bool isProjectListOpen = true;

  void changePath(
    bool isSelected, {
    required RouterPath path,
    Map<String, String> params = const <String, String>{},
  }) {
    if (!isSelected) {
      return;
    }
    if (path == widget.currentPath) {
      context.pushReplacementNamed(path.name, pathParameters: params);
    } else {
      context.goNamed(path.name, pathParameters: params);
    }
  }

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
            isSelected: widget.currentPath == RouterPath.favoriteList,
            onSelected: (x) => changePath(x, path: RouterPath.favoriteList),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 12),
            child: ActionChip(
              onPressed: () {
                setState(() {
                  isProjectListOpen = !isProjectListOpen;
                });
              },
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
              isSelected: widget.currentPath == RouterPath.list,
              onSelected: (x) => changePath(x, path: RouterPath.list),
            ),
            const Divider(),
            FutureBuilder<List<ProjectSidebarViewData>>(
              future: database.select(database.projectSidebarView).get(),
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
                                isSelected: widget.projectId == data.id,
                                onSelected: (x) => changePath(
                                  x,
                                  path: RouterPath.project,
                                  params: {"id": data.id},
                                ),
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
            isSelected: widget.currentPath == RouterPath.musicList,
            onSelected: (x) => changePath(x, path: RouterPath.musicList),
            iconBgColor: widget.currentPath == RouterPath.musicList
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
      // backgroundColor: Colors.transparent,
      // surfaceTintColor: Colors.transparent,
      // shadowColor: Colors.transparent,
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
