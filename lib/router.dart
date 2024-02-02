import 'package:application/models/entity/music_infos.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/screens/music_list_screen.dart';
import 'package:application/screens/project_screen.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterPath { list, favoriteList, project, musicList, prompt }

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
  initialLocation: '/list',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/list',
        name: RouterPath.list.name,
        pageBuilder: (context, state) =>
            buildPageWithDefaultTransition(context, state, const HomeScreen())),
    GoRoute(
        path: '/favorite-list',
        name: RouterPath.favoriteList.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context, state, const HomeScreen(favoriteOnly: true))),
    GoRoute(
      path: '/project/:id',
      name: RouterPath.project.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, ProjectScreen(projectId: state.pathParameters['id'])),
    ),
    GoRoute(
      path: '/music-list',
      name: RouterPath.musicList.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, const MusicListScreen()),
    ),
    GoRoute(
      path: '/prompt/:id',
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
