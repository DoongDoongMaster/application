import 'package:application/models/entity/music_infos.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/screens/music_list_screen.dart';
import 'package:application/screens/project_screen.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterPath {
  list,
  favoriteList,
  project,
  musicList,
  prompt,
  musicListDDM,
  musicListUser,
}

CustomTransitionPage buildPageWithDefaultTransition<T>(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RouterPath.musicList}',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/${RouterPath.list}',
        name: RouterPath.list.name,
        pageBuilder: (context, state) =>
            buildPageWithDefaultTransition(context, state, const HomeScreen())),
    GoRoute(
        path: '/${RouterPath.favoriteList}',
        name: RouterPath.favoriteList.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context, state, const HomeScreen(favoriteOnly: true))),
    GoRoute(
      path: '/${RouterPath.project}/:id',
      name: RouterPath.project.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, ProjectScreen(projectId: state.pathParameters['id'])),
    ),
    GoRoute(
      path: '/${RouterPath.musicList}',
      name: RouterPath.musicList.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, const MusicListScreen()),
    ),
    GoRoute(
      path: '/${RouterPath.musicList}/${MusicType.ddm.name}',
      name: RouterPath.musicListDDM.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context,
          state,
          const MusicListScreen(
            filter: MusicType.ddm,
          )),
    ),
    GoRoute(
      path: '/${RouterPath.musicList}/${MusicType.user.name}',
      name: RouterPath.musicListUser.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context,
          state,
          const MusicListScreen(
            filter: MusicType.user,
          )),
    ),
    GoRoute(
      path: '/${RouterPath.prompt}/:id',
      name: RouterPath.prompt.name,
      pageBuilder: (context, state) {
        return buildPageWithDefaultTransition(
          context,
          state,
          PromptScreen(
            music: state.extra as MusicInfo,
            projectId: state.pathParameters["id"],
          ),
        );
      },
    )
  ],
);
