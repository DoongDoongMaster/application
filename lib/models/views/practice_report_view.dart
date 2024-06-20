import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class PracticeReportView extends View {
  PracticeInfos get practice;
  MusicInfos get musicInfo;
  ProjectInfos get projectInfo;
  PracticeInfos get practiceList;

  Expression<String> get musicId => musicInfo.id;
  Expression<String> get musicTitle => musicInfo.title;
  Expression<String> get musicArtist => musicInfo.artist;
  Expression<int> get sourceBPM => musicInfo.bpm;

  Expression<String> get projectId => projectInfo.id;

  Expression<int> get bestScore => practiceList.score.max();

  @override
  Query as() => select([
        practice.id,
        practice.bpm,
        practice.speed,
        practice.score,
        practice.accuracyCount,
        practice.componentCount,
        practice.isNew,
        practice.result,
        musicInfo.sourceCount,
        musicInfo.musicEntries,
        musicInfo.xmlData,
        musicInfo.hitCount,
        musicInfo.measureList,
        musicId,
        musicTitle,
        musicArtist,
        sourceBPM,
        projectId,
        bestScore,
      ]).from(practice).join([
        innerJoin(projectInfo, projectInfo.id.equalsExp(practice.projectId)),
        innerJoin(musicInfo, musicInfo.id.equalsExp(projectInfo.musicId)),
        leftOuterJoin(
            practiceList, practiceList.projectId.equalsExp(practice.projectId)),
      ])
        ..groupBy([practice.id]);
}
