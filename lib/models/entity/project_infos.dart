import 'package:application/models/entity/default_table.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:drift/drift.dart';

class ProjectInfo extends DefaultEntity {
  final String musicId, title;
  final bool isLiked;

  ProjectInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    required this.musicId,
    required this.title,
    required this.isLiked,
  }) : super();
}

@UseRowClass(ProjectInfo)
class ProjectInfos extends DefaultTable {
  TextColumn get title => text()();
  TextColumn get musicId =>
      text().references(MusicInfos, #id, onDelete: KeyAction.restrict)();
  BoolColumn get isLiked => boolean().withDefault(const Constant(false))();
}
