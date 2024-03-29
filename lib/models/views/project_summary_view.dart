import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
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
        bestScore,
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
        practiceList.score,
        practiceList.createdAt,
      ]).from(practiceList);
}

class AnalysisSummaryData {
  final ComponentCount sourceCount;
  final int? bestScore;
  final AccuracyCount? bestCount;

  final List<double?> scoreList;
  final List<AccuracyCount?> accuracyList;

  AnalysisSummaryData({
    required ProjectSummaryViewData projectInfo,
    required List<PracticeAnalysisViewData> practiceList,
    this.bestCount,
  })  : sourceCount = projectInfo.sourceCount,
        bestScore = projectInfo.bestScore,
        scoreList = practiceList.map((d) => d.score?.toDouble()).toList(),
        accuracyList = practiceList.map((d) => d.accuracyCount).toList();
}
