import 'package:application/models/entity/music_infos.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:application/screens/report_screen.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/screens/music_list_screen.dart';
import 'package:application/screens/project_screen.dart';
import 'package:application/screens/prev_prompt_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterPath {
  list,
  listRefresh,
  favoriteList,
  project,
  musicList,
  musicListDDM,
  musicListUser,
  prompt,
  report,
}

CustomTransitionPage buildPageWithDefaultTransition<T>(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    // key: state.uri.queryParameters.containsKey('refresh')
    //     ? UniqueKey()
    //     : state.pageKey,
    // key: state.pageKey,
    key: UniqueKey(),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RouterPath.list.name}',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/${RouterPath.list.name}',
      name: RouterPath.list.name,
      pageBuilder: (context, state) => goHome(context, state),
    ),
    GoRoute(
        path: '/${RouterPath.favoriteList.name}',
        name: RouterPath.favoriteList.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context, state, const HomeScreen(favoriteOnly: true))),
    GoRoute(
      path: '/${RouterPath.project.name}/:id',
      name: RouterPath.project.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, ProjectScreen(projectId: state.pathParameters['id'])),
    ),
    GoRoute(
      path: '/${RouterPath.musicList.name}',
      name: RouterPath.musicList.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context, state, const MusicListScreen()),
    ),
    GoRoute(
      path: '/${RouterPath.musicList.name}/${MusicType.ddm.name}',
      name: RouterPath.musicListDDM.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context,
        state,
        const MusicListScreen(filter: MusicType.ddm),
      ),
    ),
    GoRoute(
      path: '/${RouterPath.musicList.name}/${MusicType.user.name}',
      name: RouterPath.musicListUser.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context,
        state,
        const MusicListScreen(filter: MusicType.user),
      ),
    ),
    GoRoute(
      path: '/${RouterPath.prompt.name}/:musicId/:projectId',
      name: RouterPath.prompt.name,
      pageBuilder: (context, state) {
        if (state.pathParameters["musicId"] == null ||
            state.pathParameters["projectId"] == null) {
          return goHome(context, state);
        }
        return buildPageWithDefaultTransition(
          context,
          state,
          // PrevPromptScreen(
          //   musicId: state.pathParameters["musicId"],
          //   projectId: state.pathParameters["projectId"],
          // ),
          PromptScreen(
              musicId: state.pathParameters["musicId"],
              projectId: state.pathParameters["projectId"]),
        );
      },
    ),
    GoRoute(
      path: '/${RouterPath.report.name}/:id',
      name: RouterPath.report.name,
      pageBuilder: (context, state) {
        return buildPageWithDefaultTransition(
          context,
          state,
          ReportScreen(
            practiceId: state.pathParameters["id"],
          ),
        );
      },
    )
  ],
);

CustomTransitionPage<dynamic> goHome(
    BuildContext context, GoRouterState state) {
  return buildPageWithDefaultTransition(context, state, const HomeScreen());
}
