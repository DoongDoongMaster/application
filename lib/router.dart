import 'package:application/main.dart';
import 'package:application/screens/home_screen.dart';
import 'package:application/screens/login_screen.dart';
import 'package:application/screens/new_music_screen.dart';
import 'package:application/screens/prompt_screen.dart';
import 'package:application/screens/drill_setting_screen.dart';
import 'package:application/screens/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RouterPath {
  login,
  home,
  // list,
  // favoriteList,
  project,
  prompt,
  report,
  newMusic,
  drillSetting,
}

CustomTransitionPage buildPageWithDefaultTransition<T>(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.uri.queryParameters.containsKey('refresh')
        ? UniqueKey()
        : state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GoRouter goRouter = GoRouter(
  initialLocation: '/${RouterPath.login.name}',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/${RouterPath.login.name}',
      name: RouterPath.login.name,
      pageBuilder: (context, state) =>
          buildPageWithDefaultTransition(context, state, const LoginScreen()),
    ),
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
          projectId: state.uri.queryParameters["projectId"],
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
          PromptScreen(
            musicId: state.pathParameters["musicId"],
            projectId: state.pathParameters["projectId"],
            drillId: state.uri.queryParameters["drillId"],
          ),
        );
      },
    ),
    GoRoute(
      path: '/${RouterPath.drillSetting.name}/:projectId',
      name: RouterPath.drillSetting.name,
      pageBuilder: (context, state) {
        if (state.pathParameters["projectId"] == null) {
          return goHome(context, state);
        }
        return buildPageWithDefaultTransition(
          context,
          state,
          DrillSettingScreen(
            projectId: state.pathParameters["projectId"],
          ),
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
    ),
    GoRoute(
      path: '/${RouterPath.newMusic.name}',
      name: RouterPath.newMusic.name,
      pageBuilder: (context, state) {
        if (state.uri.queryParameters["fileName"] == null ||
            state.uri.queryParameters["filePath"] == null) {
          return goHome(context, state);
        }
        return buildPageWithDefaultTransition(
          context,
          state,
          NewMusicScreen(
            fileName: state.uri.queryParameters["fileName"],
            filePath: state.uri.queryParameters["filePath"],
          ),
        );
      },
    ),
  ],
  redirect: (context, state) {
    if (!fbService.isloggedIn) {
      return '/${RouterPath.login.name}';
    }
    return null;
  },
);

CustomTransitionPage<dynamic> goHome(
    BuildContext context, GoRouterState state) {
  return buildPageWithDefaultTransition(
    context,
    state,
    const HomeScreen(),
  );
}
