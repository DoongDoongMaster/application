import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class ProjectThumbnailView extends View {
  PracticeInfos get practices;
  MusicInfos get musicInfos;
  ProjectInfos get projects;

  Expression<int> get unreadCount => practices.id.count();

  @override
  Query as() => select([
        projects.id,
        projects.title,
        projects.isLiked,
        musicInfos.type,
        unreadCount,
      ]).from(projects).join([
        innerJoin(musicInfos, musicInfos.id.equalsExp(projects.musicId)),
        leftOuterJoin(practices, practices.projectId.equalsExp(projects.id)),
      ])
        ..groupBy([projects.id]);
}
