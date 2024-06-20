import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class ProjectSidebarView extends View {
  ProjectInfos get projects;
  MusicInfos get musicInfos;

  @override
  Query as() => select(
          [projects.id, projects.title, musicInfos.type, projects.createdAt])
      .from(projects)
      .join([innerJoin(musicInfos, musicInfos.id.equalsExp(projects.musicId))]);
}
