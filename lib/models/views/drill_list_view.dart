import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class DrillMusicView extends View {
  ProjectInfos get project;
  MusicInfos get music;

  @override
  Query as() => select([
        project.id,
        project.musicId,
        project.title,
        music.sheetImage,
        music.measureList,
      ]).from(project).join([
        innerJoin(music, music.id.equalsExp(project.musicId)),
      ]);
}

class DrillListData {
  final String musicId, projectTitle, projectId;
  final Uint8List? sheetImage;
  final List<Cursor> measureList;
  final List<DrillInfo> drillList;

  DrillListData({
    required DrillMusicViewData musicdata,
    required this.drillList,
  })  : projectId = musicdata.id,
        musicId = musicdata.musicId,
        projectTitle = musicdata.title,
        sheetImage = musicdata.sheetImage,
        measureList = musicdata.measureList;
}
