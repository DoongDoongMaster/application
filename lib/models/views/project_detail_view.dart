import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class ProjectDetailView extends View {
  MusicInfos get musicInfos;
  ProjectInfos get projects;

  Expression<String> get musicId => musicInfos.id;
  Expression<String> get musicTitle => musicInfos.title;

  @override
  Query as() => select([
        projects.id,
        projects.title,
        projects.isLiked,
        projects.createdAt,
        musicId,
        musicTitle,
        musicInfos.artist,
        musicInfos.bpm,
        musicInfos.type,
        musicInfos.measureCount,
      ]).from(projects).join([
        innerJoin(musicInfos, projects.musicId.equalsExp(musicInfos.id)),
      ]);
}
