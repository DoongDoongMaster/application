import 'package:application/models/convertors/music_entry_convertor.dart';
import 'package:application/models/entity/default_table.dart';
import 'package:drift/drift.dart';

enum ReportType { full, drill }

class DefaultReportInfo extends DefaultEntity {
  final String title;
  final int bpm;
  final bool isNew;
  List<MusicEntry>? transcription;

  DefaultReportInfo({
    super.id = "",
    super.createdAt,
    super.updatedAt,
    this.title = "",
    this.bpm = 90,
    this.isNew = false,
    this.transcription = const [],
  }) : super();
}

@UseRowClass(DefaultReportInfo)
class DefalutReportInfos extends DefaultTable {
  TextColumn get title => text().clientDefault(() => DateTime.now()
      .toString()
      .replaceAll(RegExp(r':\d\d\.\d+'), '')
      .replaceAll('-', '.'))();

  IntColumn get bpm => integer()();
  BoolColumn get isNew => boolean().withDefault(const Constant(false))();

  TextColumn get transcription => text()
      .map(const MusicEntryListConvertor())
      .withDefault(Constant(const MusicEntryListConvertor().toSql([])))();
}
