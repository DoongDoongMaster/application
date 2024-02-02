// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MusicInfosTable extends MusicInfos
    with TableInfo<$MusicInfosTable, MusicInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MusicInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bpmMeta = const VerificationMeta('bpm');
  @override
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cursorListMeta =
      const VerificationMeta('cursorList');
  @override
  late final GeneratedColumnWithTypeConverter<List<Cursors>, String>
      cursorList = GeneratedColumn<String>('cursor_list', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<Cursors>>($MusicInfosTable.$convertercursorList);
  static const VerificationMeta _measureListMeta =
      const VerificationMeta('measureList');
  @override
  late final GeneratedColumnWithTypeConverter<List<Cursors>, String>
      measureList = GeneratedColumn<String>('measure_list', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<Cursors>>($MusicInfosTable.$convertermeasureList);
  static const VerificationMeta _sheetSvgMeta =
      const VerificationMeta('sheetSvg');
  @override
  late final GeneratedColumn<Uint8List> sheetSvg = GeneratedColumn<Uint8List>(
      'sheet_svg', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        title,
        bpm,
        artist,
        cursorList,
        measureList,
        sheetSvg,
        type
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'music_infos';
  @override
  VerificationContext validateIntegrity(Insertable<MusicInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('bpm')) {
      context.handle(
          _bpmMeta, bpm.isAcceptableOrUnknown(data['bpm']!, _bpmMeta));
    } else if (isInserting) {
      context.missing(_bpmMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    context.handle(_cursorListMeta, const VerificationResult.success());
    context.handle(_measureListMeta, const VerificationResult.success());
    if (data.containsKey('sheet_svg')) {
      context.handle(_sheetSvgMeta,
          sheetSvg.isAcceptableOrUnknown(data['sheet_svg']!, _sheetSvgMeta));
    } else if (isInserting) {
      context.missing(_sheetSvgMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MusicInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MusicInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      cursorList: $MusicInfosTable.$convertercursorList.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cursor_list'])!),
      sheetSvg: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}sheet_svg'])!,
      measureList: $MusicInfosTable.$convertermeasureList.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}measure_list'])!),
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
    );
  }

  @override
  $MusicInfosTable createAlias(String alias) {
    return $MusicInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Cursors>, String> $convertercursorList =
      const CursorListConvertor();
  static TypeConverter<List<Cursors>, String> $convertermeasureList =
      const CursorListConvertor();
  static JsonTypeConverter2<MusicType, int, int> $convertertype =
      const EnumIndexConverter<MusicType>(MusicType.values);
}

class MusicInfosCompanion extends UpdateCompanion<MusicInfo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> title;
  final Value<int> bpm;
  final Value<String> artist;
  final Value<List<Cursors>> cursorList;
  final Value<List<Cursors>> measureList;
  final Value<Uint8List> sheetSvg;
  final Value<MusicType> type;
  final Value<int> rowid;
  const MusicInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.bpm = const Value.absent(),
    this.artist = const Value.absent(),
    this.cursorList = const Value.absent(),
    this.measureList = const Value.absent(),
    this.sheetSvg = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MusicInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String title,
    required int bpm,
    required String artist,
    required List<Cursors> cursorList,
    required List<Cursors> measureList,
    required Uint8List sheetSvg,
    required MusicType type,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        bpm = Value(bpm),
        artist = Value(artist),
        cursorList = Value(cursorList),
        measureList = Value(measureList),
        sheetSvg = Value(sheetSvg),
        type = Value(type);
  static Insertable<MusicInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<int>? bpm,
    Expression<String>? artist,
    Expression<String>? cursorList,
    Expression<String>? measureList,
    Expression<Uint8List>? sheetSvg,
    Expression<int>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (bpm != null) 'bpm': bpm,
      if (artist != null) 'artist': artist,
      if (cursorList != null) 'cursor_list': cursorList,
      if (measureList != null) 'measure_list': measureList,
      if (sheetSvg != null) 'sheet_svg': sheetSvg,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MusicInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<int>? bpm,
      Value<String>? artist,
      Value<List<Cursors>>? cursorList,
      Value<List<Cursors>>? measureList,
      Value<Uint8List>? sheetSvg,
      Value<MusicType>? type,
      Value<int>? rowid}) {
    return MusicInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      bpm: bpm ?? this.bpm,
      artist: artist ?? this.artist,
      cursorList: cursorList ?? this.cursorList,
      measureList: measureList ?? this.measureList,
      sheetSvg: sheetSvg ?? this.sheetSvg,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (bpm.present) {
      map['bpm'] = Variable<int>(bpm.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (cursorList.present) {
      map['cursor_list'] = Variable<String>(
          $MusicInfosTable.$convertercursorList.toSql(cursorList.value));
    }
    if (measureList.present) {
      map['measure_list'] = Variable<String>(
          $MusicInfosTable.$convertermeasureList.toSql(measureList.value));
    }
    if (sheetSvg.present) {
      map['sheet_svg'] = Variable<Uint8List>(sheetSvg.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($MusicInfosTable.$convertertype.toSql(type.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MusicInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('bpm: $bpm, ')
          ..write('artist: $artist, ')
          ..write('cursorList: $cursorList, ')
          ..write('measureList: $measureList, ')
          ..write('sheetSvg: $sheetSvg, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectInfosTable extends ProjectInfos
    with TableInfo<$ProjectInfosTable, ProjectInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _musicIdMeta =
      const VerificationMeta('musicId');
  @override
  late final GeneratedColumn<String> musicId = GeneratedColumn<String>(
      'music_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES music_infos (id)'));
  static const VerificationMeta _isLikedMeta =
      const VerificationMeta('isLiked');
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
      'is_liked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liked" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, title, musicId, isLiked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'project_infos';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('music_id')) {
      context.handle(_musicIdMeta,
          musicId.isAcceptableOrUnknown(data['music_id']!, _musicIdMeta));
    } else if (isInserting) {
      context.missing(_musicIdMeta);
    }
    if (data.containsKey('is_liked')) {
      context.handle(_isLikedMeta,
          isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProjectInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      musicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isLiked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liked'])!,
    );
  }

  @override
  $ProjectInfosTable createAlias(String alias) {
    return $ProjectInfosTable(attachedDatabase, alias);
  }
}

class ProjectInfosCompanion extends UpdateCompanion<ProjectInfo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> title;
  final Value<String> musicId;
  final Value<bool> isLiked;
  final Value<int> rowid;
  const ProjectInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.musicId = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String title,
    required String musicId,
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        musicId = Value(musicId);
  static Insertable<ProjectInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String>? musicId,
    Expression<bool>? isLiked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (musicId != null) 'music_id': musicId,
      if (isLiked != null) 'is_liked': isLiked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<String>? musicId,
      Value<bool>? isLiked,
      Value<int>? rowid}) {
    return ProjectInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      musicId: musicId ?? this.musicId,
      isLiked: isLiked ?? this.isLiked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (musicId.present) {
      map['music_id'] = Variable<String>(musicId.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('musicId: $musicId, ')
          ..write('isLiked: $isLiked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PracticeInfosTable extends PracticeInfos
    with TableInfo<$PracticeInfosTable, PracticeInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toIso8601String());
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bpmMeta = const VerificationMeta('bpm');
  @override
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
      'is_new', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_new" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES project_infos (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, title, score, bpm, isNew, projectId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_infos';
  @override
  VerificationContext validateIntegrity(Insertable<PracticeInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('bpm')) {
      context.handle(
          _bpmMeta, bpm.isAcceptableOrUnknown(data['bpm']!, _bpmMeta));
    } else if (isInserting) {
      context.missing(_bpmMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
          _isNewMeta, isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PracticeInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
    );
  }

  @override
  $PracticeInfosTable createAlias(String alias) {
    return $PracticeInfosTable(attachedDatabase, alias);
  }
}

class PracticeInfosCompanion extends UpdateCompanion<PracticeInfo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> title;
  final Value<int?> score;
  final Value<int> bpm;
  final Value<bool> isNew;
  final Value<String> projectId;
  final Value<int> rowid;
  const PracticeInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.score = const Value.absent(),
    this.bpm = const Value.absent(),
    this.isNew = const Value.absent(),
    this.projectId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PracticeInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.score = const Value.absent(),
    required int bpm,
    this.isNew = const Value.absent(),
    required String projectId,
    this.rowid = const Value.absent(),
  })  : bpm = Value(bpm),
        projectId = Value(projectId);
  static Insertable<PracticeInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<int>? score,
    Expression<int>? bpm,
    Expression<bool>? isNew,
    Expression<String>? projectId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (score != null) 'score': score,
      if (bpm != null) 'bpm': bpm,
      if (isNew != null) 'is_new': isNew,
      if (projectId != null) 'project_id': projectId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PracticeInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<int?>? score,
      Value<int>? bpm,
      Value<bool>? isNew,
      Value<String>? projectId,
      Value<int>? rowid}) {
    return PracticeInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      score: score ?? this.score,
      bpm: bpm ?? this.bpm,
      isNew: isNew ?? this.isNew,
      projectId: projectId ?? this.projectId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (bpm.present) {
      map['bpm'] = Variable<int>(bpm.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('score: $score, ')
          ..write('bpm: $bpm, ')
          ..write('isNew: $isNew, ')
          ..write('projectId: $projectId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class MusicThumbnailViewData extends DataClass {
  final String id;
  final MusicType type;
  final String title;
  final String artist;
  final Uint8List sheetSvg;
  const MusicThumbnailViewData(
      {required this.id,
      required this.type,
      required this.title,
      required this.artist,
      required this.sheetSvg});
  factory MusicThumbnailViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MusicThumbnailViewData(
      id: serializer.fromJson<String>(json['id']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      sheetSvg: serializer.fromJson<Uint8List>(json['sheetSvg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type':
          serializer.toJson<int>($MusicInfosTable.$convertertype.toJson(type)),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'sheetSvg': serializer.toJson<Uint8List>(sheetSvg),
    };
  }

  MusicThumbnailViewData copyWith(
          {String? id,
          MusicType? type,
          String? title,
          String? artist,
          Uint8List? sheetSvg}) =>
      MusicThumbnailViewData(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        sheetSvg: sheetSvg ?? this.sheetSvg,
      );
  @override
  String toString() {
    return (StringBuffer('MusicThumbnailViewData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('sheetSvg: $sheetSvg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, title, artist, $driftBlobEquality.hash(sheetSvg));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MusicThumbnailViewData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.artist == this.artist &&
          $driftBlobEquality.equals(other.sheetSvg, this.sheetSvg));
}

class $MusicThumbnailViewView
    extends ViewInfo<$MusicThumbnailViewView, MusicThumbnailViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $MusicThumbnailViewView(this.attachedDatabase, [this._alias]);
  $MusicInfosTable get musicInfos =>
      attachedDatabase.musicInfos.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns => [id, type, title, artist, sheetSvg];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'music_thumbnail_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $MusicThumbnailViewView get asDslTable => this;
  @override
  MusicThumbnailViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MusicThumbnailViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      sheetSvg: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}sheet_svg'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.id, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.type, false),
              type: DriftSqlType.int)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.artist, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<Uint8List> sheetSvg = GeneratedColumn<Uint8List>(
      'sheet_svg', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.sheetSvg, false),
      type: DriftSqlType.blob);
  @override
  $MusicThumbnailViewView createAlias(String alias) {
    return $MusicThumbnailViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(musicInfos)..addColumns($columns));
  @override
  Set<String> get readTables => const {'music_infos'};
}

class ProjectDetailViewData extends DataClass {
  final String id;
  final String title;
  final bool isLiked;
  final DateTime createdAt;
  final String? musicId;
  final String? musicTitle;
  final String artist;
  final int bpm;
  final MusicType type;
  final int? musicLength;
  const ProjectDetailViewData(
      {required this.id,
      required this.title,
      required this.isLiked,
      required this.createdAt,
      this.musicId,
      this.musicTitle,
      required this.artist,
      required this.bpm,
      required this.type,
      this.musicLength});
  factory ProjectDetailViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectDetailViewData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      musicId: serializer.fromJson<String?>(json['musicId']),
      musicTitle: serializer.fromJson<String?>(json['musicTitle']),
      artist: serializer.fromJson<String>(json['artist']),
      bpm: serializer.fromJson<int>(json['bpm']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      musicLength: serializer.fromJson<int?>(json['musicLength']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'isLiked': serializer.toJson<bool>(isLiked),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'musicId': serializer.toJson<String?>(musicId),
      'musicTitle': serializer.toJson<String?>(musicTitle),
      'artist': serializer.toJson<String>(artist),
      'bpm': serializer.toJson<int>(bpm),
      'type':
          serializer.toJson<int>($MusicInfosTable.$convertertype.toJson(type)),
      'musicLength': serializer.toJson<int?>(musicLength),
    };
  }

  ProjectDetailViewData copyWith(
          {String? id,
          String? title,
          bool? isLiked,
          DateTime? createdAt,
          Value<String?> musicId = const Value.absent(),
          Value<String?> musicTitle = const Value.absent(),
          String? artist,
          int? bpm,
          MusicType? type,
          Value<int?> musicLength = const Value.absent()}) =>
      ProjectDetailViewData(
        id: id ?? this.id,
        title: title ?? this.title,
        isLiked: isLiked ?? this.isLiked,
        createdAt: createdAt ?? this.createdAt,
        musicId: musicId.present ? musicId.value : this.musicId,
        musicTitle: musicTitle.present ? musicTitle.value : this.musicTitle,
        artist: artist ?? this.artist,
        bpm: bpm ?? this.bpm,
        type: type ?? this.type,
        musicLength: musicLength.present ? musicLength.value : this.musicLength,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectDetailViewData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isLiked: $isLiked, ')
          ..write('createdAt: $createdAt, ')
          ..write('musicId: $musicId, ')
          ..write('musicTitle: $musicTitle, ')
          ..write('artist: $artist, ')
          ..write('bpm: $bpm, ')
          ..write('type: $type, ')
          ..write('musicLength: $musicLength')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isLiked, createdAt, musicId,
      musicTitle, artist, bpm, type, musicLength);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectDetailViewData &&
          other.id == this.id &&
          other.title == this.title &&
          other.isLiked == this.isLiked &&
          other.createdAt == this.createdAt &&
          other.musicId == this.musicId &&
          other.musicTitle == this.musicTitle &&
          other.artist == this.artist &&
          other.bpm == this.bpm &&
          other.type == this.type &&
          other.musicLength == this.musicLength);
}

class $ProjectDetailViewView
    extends ViewInfo<$ProjectDetailViewView, ProjectDetailViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $ProjectDetailViewView(this.attachedDatabase, [this._alias]);
  $MusicInfosTable get musicInfos =>
      attachedDatabase.musicInfos.createAlias('t0');
  $ProjectInfosTable get projects =>
      attachedDatabase.projectInfos.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        isLiked,
        createdAt,
        musicId,
        musicTitle,
        artist,
        bpm,
        type,
        musicLength
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'project_detail_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $ProjectDetailViewView get asDslTable => this;
  @override
  ProjectDetailViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectDetailViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isLiked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liked'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      musicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_id']),
      musicTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_title']),
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      musicLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}music_length']),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(projects.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(projects.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
      'is_liked', aliasedName, false,
      generatedAs: GeneratedAs(projects.isLiked, false),
      type: DriftSqlType.bool,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liked" IN (0, 1))'));
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(projects.createdAt, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<String> musicId = GeneratedColumn<String>(
      'music_id', aliasedName, true,
      generatedAs: GeneratedAs(musicInfos.id, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> musicTitle = GeneratedColumn<String>(
      'music_title', aliasedName, true,
      generatedAs: GeneratedAs(musicInfos.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.artist, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.bpm, false), type: DriftSqlType.int);
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.type, false),
              type: DriftSqlType.int)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  late final GeneratedColumn<int> musicLength = GeneratedColumn<int>(
      'music_length', aliasedName, true,
      generatedAs: GeneratedAs(
          TimeUtils.getTotalDurationInSec(
              musicInfos.bpm, musicInfos.measureList.length),
          false),
      type: DriftSqlType.int);
  @override
  $ProjectDetailViewView createAlias(String alias) {
    return $ProjectDetailViewView(attachedDatabase, alias);
  }

  @override
  Query? get query => (attachedDatabase.selectOnly(projects)
        ..addColumns($columns))
      .join([innerJoin(musicInfos, projects.musicId.equalsExp(musicInfos.id))]);
  @override
  Set<String> get readTables => const {'music_infos', 'project_infos'};
}

class ProjectSidebarViewData extends DataClass {
  final String id;
  final String title;
  final MusicType type;
  const ProjectSidebarViewData(
      {required this.id, required this.title, required this.type});
  factory ProjectSidebarViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectSidebarViewData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'type':
          serializer.toJson<int>($MusicInfosTable.$convertertype.toJson(type)),
    };
  }

  ProjectSidebarViewData copyWith(
          {String? id, String? title, MusicType? type}) =>
      ProjectSidebarViewData(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectSidebarViewData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectSidebarViewData &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type);
}

class $ProjectSidebarViewView
    extends ViewInfo<$ProjectSidebarViewView, ProjectSidebarViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $ProjectSidebarViewView(this.attachedDatabase, [this._alias]);
  $ProjectInfosTable get projects =>
      attachedDatabase.projectInfos.createAlias('t0');
  $MusicInfosTable get musicInfos =>
      attachedDatabase.musicInfos.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [id, title, type];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'project_sidebar_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $ProjectSidebarViewView get asDslTable => this;
  @override
  ProjectSidebarViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectSidebarViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(projects.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(projects.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.type, false),
              type: DriftSqlType.int)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  @override
  $ProjectSidebarViewView createAlias(String alias) {
    return $ProjectSidebarViewView(attachedDatabase, alias);
  }

  @override
  Query? get query => (attachedDatabase.selectOnly(projects)
        ..addColumns($columns))
      .join([innerJoin(musicInfos, musicInfos.id.equalsExp(projects.musicId))]);
  @override
  Set<String> get readTables => const {'project_infos', 'music_infos'};
}

class ProjectThumbnailViewData extends DataClass {
  final String id;
  final String title;
  final bool isLiked;
  final MusicType type;
  final int? unreadCount;
  const ProjectThumbnailViewData(
      {required this.id,
      required this.title,
      required this.isLiked,
      required this.type,
      this.unreadCount});
  factory ProjectThumbnailViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectThumbnailViewData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      unreadCount: serializer.fromJson<int?>(json['unreadCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'isLiked': serializer.toJson<bool>(isLiked),
      'type':
          serializer.toJson<int>($MusicInfosTable.$convertertype.toJson(type)),
      'unreadCount': serializer.toJson<int?>(unreadCount),
    };
  }

  ProjectThumbnailViewData copyWith(
          {String? id,
          String? title,
          bool? isLiked,
          MusicType? type,
          Value<int?> unreadCount = const Value.absent()}) =>
      ProjectThumbnailViewData(
        id: id ?? this.id,
        title: title ?? this.title,
        isLiked: isLiked ?? this.isLiked,
        type: type ?? this.type,
        unreadCount: unreadCount.present ? unreadCount.value : this.unreadCount,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectThumbnailViewData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isLiked: $isLiked, ')
          ..write('type: $type, ')
          ..write('unreadCount: $unreadCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isLiked, type, unreadCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectThumbnailViewData &&
          other.id == this.id &&
          other.title == this.title &&
          other.isLiked == this.isLiked &&
          other.type == this.type &&
          other.unreadCount == this.unreadCount);
}

class $ProjectThumbnailViewView
    extends ViewInfo<$ProjectThumbnailViewView, ProjectThumbnailViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $ProjectThumbnailViewView(this.attachedDatabase, [this._alias]);
  $PracticeInfosTable get practices =>
      attachedDatabase.practiceInfos.createAlias('t0');
  $MusicInfosTable get musicInfos =>
      attachedDatabase.musicInfos.createAlias('t1');
  $ProjectInfosTable get projects =>
      attachedDatabase.projectInfos.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns => [id, title, isLiked, type, unreadCount];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'project_thumbnail_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $ProjectThumbnailViewView get asDslTable => this;
  @override
  ProjectThumbnailViewData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectThumbnailViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isLiked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liked'])!,
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      unreadCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread_count']),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(projects.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(projects.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
      'is_liked', aliasedName, false,
      generatedAs: GeneratedAs(projects.isLiked, false),
      type: DriftSqlType.bool,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liked" IN (0, 1))'));
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.type, false),
              type: DriftSqlType.int)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
      'unread_count', aliasedName, true,
      generatedAs: GeneratedAs(practices.id.count(), false),
      type: DriftSqlType.int);
  @override
  $ProjectThumbnailViewView createAlias(String alias) {
    return $ProjectThumbnailViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(projects)..addColumns($columns)).join([
        innerJoin(musicInfos, musicInfos.id.equalsExp(projects.musicId)),
        leftOuterJoin(practices, practices.projectId.equalsExp(projects.id))
      ])
        ..groupBy([projects.id]);
  @override
  Set<String> get readTables =>
      const {'practice_infos', 'music_infos', 'project_infos'};
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $MusicInfosTable musicInfos = $MusicInfosTable(this);
  late final $ProjectInfosTable projectInfos = $ProjectInfosTable(this);
  late final $PracticeInfosTable practiceInfos = $PracticeInfosTable(this);
  late final $MusicThumbnailViewView musicThumbnailView =
      $MusicThumbnailViewView(this);
  late final $ProjectDetailViewView projectDetailView =
      $ProjectDetailViewView(this);
  late final $ProjectSidebarViewView projectSidebarView =
      $ProjectSidebarViewView(this);
  late final $ProjectThumbnailViewView projectThumbnailView =
      $ProjectThumbnailViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        musicInfos,
        projectInfos,
        practiceInfos,
        musicThumbnailView,
        projectDetailView,
        projectSidebarView,
        projectThumbnailView
      ];
}
