import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/drill_report_info.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class ProjectSummaryView extends View {
  MusicInfos get musicInfo;
  ProjectInfos get projectInfo;
  PracticeInfos get practiceList;

  Expression<int> get bestScore => practiceList.score.max();

  @override
  Query as() => select([
        projectInfo.id,
        musicInfo.sourceCount,
        musicInfo.musicEntries,
        bestScore,
        musicInfo.hitCount,
      ]).from(projectInfo).join([
        innerJoin(musicInfo, musicInfo.id.equalsExp(projectInfo.musicId)),
        leftOuterJoin(
            practiceList, practiceList.projectId.equalsExp(projectInfo.id)),
      ])
        ..groupBy([projectInfo.id]);
}

abstract class PracticeAnalysisView extends View {
  PracticeInfos get practiceList;

  @override
  Query as() => select([
        practiceList.id,
        practiceList.projectId,
        practiceList.accuracyCount,
        practiceList.result,
        practiceList.score,
        practiceList.createdAt,
      ]).from(practiceList);
}

class AnalysisSummaryData {
  final ComponentCount sourceCount, sourceCnt;
  final int? bestScore, hitCount;
  final AccuracyCount? bestCount;

  final List<double?> scoreList;
  final List<AccuracyCount?> accuracyList;

  AnalysisSummaryData({
    required ProjectSummaryViewData projectInfo,
    required List<PracticeAnalysisViewData> practiceList,
    this.bestCount,
  })  : sourceCount = projectInfo.sourceCount,
        sourceCnt = ComponentCount.fromMusicEntries(projectInfo.musicEntries),
        bestScore = projectInfo.bestScore,
        hitCount = projectInfo.hitCount,
        scoreList = practiceList.map((d) => d.score?.toDouble()).toList(),
        accuracyList = practiceList
            .map((d) => AccuracyCount.fromScoredEntries(d.result ?? []))
            .toList();

  AnalysisSummaryData.fromDrillReport({
    required int bestIdx,
    required this.sourceCnt,
    required this.hitCount,
    required List<int> scores,
    required this.accuracyList,
  })  : sourceCount = ComponentCount(),
        bestScore = scores[bestIdx].toInt(),
        bestCount = accuracyList[bestIdx],
        scoreList = scores.map((e) => e.toDouble()).toList();
}
