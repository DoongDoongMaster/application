import 'package:application/router.dart';
import 'package:application/widgets/home/Navigation_panel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectScreen extends StatelessWidget {
  final String? projectId;

  const ProjectScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    if (projectId == null) {
      context.go(RouterPath.list.name);
    }
    return const Scaffold(
      body: Row(
        children: [
          NavigationPanel(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [],
          ),
        ],
      ),
    );
  }
}
