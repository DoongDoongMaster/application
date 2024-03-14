import 'package:application/screens/home_screen.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:application/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterPath {
  home,
  // list,
  // favoriteList,
  project,
  prompt,
  report,
}

CustomTransitionPage buildPageWithDefaultTransition<T>(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.uri.queryParameters.containsKey('refresh')
        ? UniqueKey()
        : state.pageKey,

    // key: UniqueKey(),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RouterPath.home.name}',
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //   path: '/${RouterPath.list.name}',
    //   name: RouterPath.list.name,
    //   pageBuilder: (context, state) => goHome(context, state),
    // ),
    // GoRoute(
    //     path: '/${RouterPath.favoriteList.name}',
    //     name: RouterPath.favoriteList.name,
    //     pageBuilder: (context, state) => buildPageWithDefaultTransition(
    //         context, state, const HomeScreen(favoriteOnly: true))),
    GoRoute(
      path: '/${RouterPath.home.name}',
      name: RouterPath.home.name,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context,
        state,
        HomeScreen(
          homeTab: state.uri.queryParameters["tab"] == null
              ? null
              : HomeTab.values.byName(state.uri.queryParameters["tab"]!),
        ),
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
  return buildPageWithDefaultTransition(
    context,
    state,
    const HomeScreen(),
  );
}
