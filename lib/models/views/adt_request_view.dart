import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class ADTRequestView extends View {
  PracticeInfos get practice;
  ProjectInfos get project;
  MusicInfos get music;

  Expression<String> get musicId => music.id;

  @override
  Query as() => select([
        practice.id,
        practice.bpm,
        music.musicEntries,
        musicId,
      ]).from(practice).join([
        innerJoin(project, project.id.equalsExp(practice.projectId)),
        innerJoin(music, music.id.equalsExp(project.musicId))
      ]);
}
