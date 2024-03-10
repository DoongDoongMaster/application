import 'package:application/widgets/home/music_list_body.dart';
import 'package:application/widgets/home/project_body.dart';
import 'package:application/widgets/home/project_list_body.dart';
import 'package:application/widgets/home/navigation_panel.dart';
import 'package:flutter/material.dart';

enum HomeTab {
  favoriteProjectList,
  projectList,
  musicList,
  project,
}

class HomeScreen extends StatefulWidget {
  final HomeTab? homeTab;
  const HomeScreen({super.key, this.homeTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

typedef NavigationFunction = void Function(HomeTab tab, {String? selectedId});

class _HomeScreenState extends State<HomeScreen> {
  late HomeTab currentTab;
  String? projectId;
  bool isProjectListOpen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentTab = widget.homeTab ?? HomeTab.projectList;
  }

  void changeTab(HomeTab tab, {String? selectedId}) {
    setState(() {
      currentTab = tab;
      projectId = selectedId;
    });
  }

  void toggleProjectList() {
    setState(() {
      isProjectListOpen = !isProjectListOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          NavigationPanel(
            currentTab: currentTab,
            isProjectListOpen: isProjectListOpen,
            projectId: projectId,
            onTab: changeTab,
            toggleList: toggleProjectList,
          ),
          Expanded(
            key: const ValueKey<String>('home-body'),
            child: HomeBody(
              currentTab: currentTab,
              projectId: projectId,
              changeTab: changeTab,
            ),
          )
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final HomeTab currentTab;
  final String? projectId;
  final NavigationFunction changeTab;

  const HomeBody({
    super.key,
    required this.currentTab,
    required this.projectId,
    required this.changeTab,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentTab) {
      case HomeTab.musicList:
        return const MusicListBody(
          key: ValueKey<String>('music-list'),
        );
      case HomeTab.project:
        return ProjectBody(
            key: const ValueKey<String>('project'), projectId: projectId!);
      case HomeTab.favoriteProjectList:
        return ProjectListBody(
          key: const ValueKey<String>('project-list'),
          favoriteOnly: true,
          onTab: changeTab,
        );
      case HomeTab.projectList:
        return ProjectListBody(
          key: const ValueKey<String>('favorite-project-list'),
          onTab: changeTab,
        );
    }
  }
}
