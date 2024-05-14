import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:drift/drift.dart';

abstract class DrillMusicView extends View {
  ProjectInfos get project;
  MusicInfos get music;

  Expression<String> get projectId => project.id;
  @override
  Query as() => select([
        projectId,
        project.musicId,
        music.sheetImage,
        music.measureList,
      ]).from(project).join([
        innerJoin(music, music.id.equalsExp(project.musicId)),
      ]);
}

class DrillListData {
  final String musicId;
  final Uint8List? sheetImage;
  final List<Cursor> measureList;
  final List<DrillInfo> drillList;

  DrillListData({
    required DrillMusicViewData musicdata,
    required this.drillList,
  })  : musicId = musicdata.musicId,
        sheetImage = musicdata.sheetImage,
        measureList = musicdata.measureList;
}
