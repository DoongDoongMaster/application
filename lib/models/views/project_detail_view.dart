import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/time_utils.dart';
import 'package:drift/drift.dart';

abstract class ProjectDetailView extends View {
  MusicInfos get musicInfos;
  ProjectInfos get projects;

  Expression<String> get musicId => musicInfos.id;
  Expression<String> get musicTitle => musicInfos.title;
  Expression<int> get musicLength => TimeUtils.getTotalDurationInSec(
      musicInfos.bpm, musicInfos.measureList.length);

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
        musicLength
      ]).from(projects).join([
        innerJoin(musicInfos, projects.musicId.equalsExp(musicInfos.id)),
      ]);
}
