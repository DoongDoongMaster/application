import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:drift/drift.dart';

class ProjectInfo {
  final String id, musicId, title;
  final bool isLiked;

  ProjectInfo({
    required this.id,
    required this.musicId,
    required this.title,
    required this.isLiked,
  });
}

@UseRowClass(ProjectInfo)
class ProjectInfos extends DefaultTable {
  TextColumn get title => text()();
  TextColumn get musicId =>
      text().references(MusicInfos, #id, onDelete: KeyAction.restrict)();
  BoolColumn get isLiked => boolean().withDefault(const Constant(false))();
}
