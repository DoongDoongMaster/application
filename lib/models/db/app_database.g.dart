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
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
      defaultValue: const Constant("이름 없는 악보"));
  static const VerificationMeta _bpmMeta = const VerificationMeta('bpm');
  @override
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(90));
  static const VerificationMeta _measureCountMeta =
      const VerificationMeta('measureCount');
  @override
  late final GeneratedColumn<int> measureCount = GeneratedColumn<int>(
      'measure_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("이름 없는 아티스트"));
  static const VerificationMeta _cursorListMeta =
      const VerificationMeta('cursorList');
  @override
  late final GeneratedColumnWithTypeConverter<List<Cursor>, String> cursorList =
      GeneratedColumn<String>('cursor_list', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(const CursorListConvertor().toSql([])))
          .withConverter<List<Cursor>>($MusicInfosTable.$convertercursorList);
  static const VerificationMeta _measureListMeta =
      const VerificationMeta('measureList');
  @override
  late final GeneratedColumnWithTypeConverter<List<Cursor>, String>
      measureList = GeneratedColumn<String>('measure_list', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(const CursorListConvertor().toSql([])))
          .withConverter<List<Cursor>>($MusicInfosTable.$convertermeasureList);
  static const VerificationMeta _sheetImageMeta =
      const VerificationMeta('sheetImage');
  @override
  late final GeneratedColumn<Uint8List> sheetImage = GeneratedColumn<Uint8List>(
      'sheet_image', aliasedName, false,
      type: DriftSqlType.blob,
      requiredDuringInsert: false,
      clientDefault: () => Uint8List(0));
  static const VerificationMeta _xmlDataMeta =
      const VerificationMeta('xmlData');
  @override
  late final GeneratedColumn<Uint8List> xmlData = GeneratedColumn<Uint8List>(
      'xml_data', aliasedName, false,
      type: DriftSqlType.blob,
      requiredDuringInsert: false,
      clientDefault: () => Uint8List(0));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              clientDefault: () => 0)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  static const VerificationMeta _sourceCountMeta =
      const VerificationMeta('sourceCount');
  @override
  late final GeneratedColumnWithTypeConverter<ComponentCount,
      String> sourceCount = GeneratedColumn<String>(
          'source_count', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue:
              Constant(const ComponentCountConvertor().toSql(ComponentCount())))
      .withConverter<ComponentCount>($MusicInfosTable.$convertersourceCount);
  static const VerificationMeta _musicEntriesMeta =
      const VerificationMeta('musicEntries');
  @override
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      musicEntries = GeneratedColumn<String>(
              'music_entries', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(const MusicEntryListConvertor().toSql([])))
          .withConverter<List<MusicEntry>>(
              $MusicInfosTable.$convertermusicEntries);
  static const VerificationMeta _hitCountMeta =
      const VerificationMeta('hitCount');
  @override
  late final GeneratedColumn<int> hitCount = GeneratedColumn<int>(
      'hit_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        title,
        bpm,
        measureCount,
        artist,
        cursorList,
        measureList,
        sheetImage,
        xmlData,
        type,
        sourceCount,
        musicEntries,
        hitCount
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
    }
    if (data.containsKey('bpm')) {
      context.handle(
          _bpmMeta, bpm.isAcceptableOrUnknown(data['bpm']!, _bpmMeta));
    }
    if (data.containsKey('measure_count')) {
      context.handle(
          _measureCountMeta,
          measureCount.isAcceptableOrUnknown(
              data['measure_count']!, _measureCountMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    context.handle(_cursorListMeta, const VerificationResult.success());
    context.handle(_measureListMeta, const VerificationResult.success());
    if (data.containsKey('sheet_image')) {
      context.handle(
          _sheetImageMeta,
          sheetImage.isAcceptableOrUnknown(
              data['sheet_image']!, _sheetImageMeta));
    }
    if (data.containsKey('xml_data')) {
      context.handle(_xmlDataMeta,
          xmlData.isAcceptableOrUnknown(data['xml_data']!, _xmlDataMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_sourceCountMeta, const VerificationResult.success());
    context.handle(_musicEntriesMeta, const VerificationResult.success());
    if (data.containsKey('hit_count')) {
      context.handle(_hitCountMeta,
          hitCount.isAcceptableOrUnknown(data['hit_count']!, _hitCountMeta));
    }
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      hitCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hit_count'])!,
      cursorList: $MusicInfosTable.$convertercursorList.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cursor_list'])!),
      measureList: $MusicInfosTable.$convertermeasureList.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}measure_list'])!),
      type: $MusicInfosTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      sheetImage: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}sheet_image'])!,
      xmlData: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}xml_data'])!,
      sourceCount: $MusicInfosTable.$convertersourceCount.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}source_count'])!),
      musicEntries: $MusicInfosTable.$convertermusicEntries.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}music_entries'])!),
    );
  }

  @override
  $MusicInfosTable createAlias(String alias) {
    return $MusicInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Cursor>, String> $convertercursorList =
      const CursorListConvertor();
  static TypeConverter<List<Cursor>, String> $convertermeasureList =
      const CursorListConvertor();
  static JsonTypeConverter2<MusicType, int, int> $convertertype =
      const EnumIndexConverter<MusicType>(MusicType.values);
  static TypeConverter<ComponentCount, String> $convertersourceCount =
      const ComponentCountConvertor();
  static TypeConverter<List<MusicEntry>, String> $convertermusicEntries =
      const MusicEntryListConvertor();
}

class MusicInfosCompanion extends UpdateCompanion<MusicInfo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> title;
  final Value<int> bpm;
  final Value<int> measureCount;
  final Value<String> artist;
  final Value<List<Cursor>> cursorList;
  final Value<List<Cursor>> measureList;
  final Value<Uint8List> sheetImage;
  final Value<Uint8List> xmlData;
  final Value<MusicType> type;
  final Value<ComponentCount> sourceCount;
  final Value<List<MusicEntry>> musicEntries;
  final Value<int> hitCount;
  final Value<int> rowid;
  const MusicInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.bpm = const Value.absent(),
    this.measureCount = const Value.absent(),
    this.artist = const Value.absent(),
    this.cursorList = const Value.absent(),
    this.measureList = const Value.absent(),
    this.sheetImage = const Value.absent(),
    this.xmlData = const Value.absent(),
    this.type = const Value.absent(),
    this.sourceCount = const Value.absent(),
    this.musicEntries = const Value.absent(),
    this.hitCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MusicInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.bpm = const Value.absent(),
    this.measureCount = const Value.absent(),
    this.artist = const Value.absent(),
    this.cursorList = const Value.absent(),
    this.measureList = const Value.absent(),
    this.sheetImage = const Value.absent(),
    this.xmlData = const Value.absent(),
    this.type = const Value.absent(),
    this.sourceCount = const Value.absent(),
    this.musicEntries = const Value.absent(),
    this.hitCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<MusicInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<int>? bpm,
    Expression<int>? measureCount,
    Expression<String>? artist,
    Expression<String>? cursorList,
    Expression<String>? measureList,
    Expression<Uint8List>? sheetImage,
    Expression<Uint8List>? xmlData,
    Expression<int>? type,
    Expression<String>? sourceCount,
    Expression<String>? musicEntries,
    Expression<int>? hitCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (bpm != null) 'bpm': bpm,
      if (measureCount != null) 'measure_count': measureCount,
      if (artist != null) 'artist': artist,
      if (cursorList != null) 'cursor_list': cursorList,
      if (measureList != null) 'measure_list': measureList,
      if (sheetImage != null) 'sheet_image': sheetImage,
      if (xmlData != null) 'xml_data': xmlData,
      if (type != null) 'type': type,
      if (sourceCount != null) 'source_count': sourceCount,
      if (musicEntries != null) 'music_entries': musicEntries,
      if (hitCount != null) 'hit_count': hitCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MusicInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<int>? bpm,
      Value<int>? measureCount,
      Value<String>? artist,
      Value<List<Cursor>>? cursorList,
      Value<List<Cursor>>? measureList,
      Value<Uint8List>? sheetImage,
      Value<Uint8List>? xmlData,
      Value<MusicType>? type,
      Value<ComponentCount>? sourceCount,
      Value<List<MusicEntry>>? musicEntries,
      Value<int>? hitCount,
      Value<int>? rowid}) {
    return MusicInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      bpm: bpm ?? this.bpm,
      measureCount: measureCount ?? this.measureCount,
      artist: artist ?? this.artist,
      cursorList: cursorList ?? this.cursorList,
      measureList: measureList ?? this.measureList,
      sheetImage: sheetImage ?? this.sheetImage,
      xmlData: xmlData ?? this.xmlData,
      type: type ?? this.type,
      sourceCount: sourceCount ?? this.sourceCount,
      musicEntries: musicEntries ?? this.musicEntries,
      hitCount: hitCount ?? this.hitCount,
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
    if (measureCount.present) {
      map['measure_count'] = Variable<int>(measureCount.value);
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
    if (sheetImage.present) {
      map['sheet_image'] = Variable<Uint8List>(sheetImage.value);
    }
    if (xmlData.present) {
      map['xml_data'] = Variable<Uint8List>(xmlData.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($MusicInfosTable.$convertertype.toSql(type.value));
    }
    if (sourceCount.present) {
      map['source_count'] = Variable<String>(
          $MusicInfosTable.$convertersourceCount.toSql(sourceCount.value));
    }
    if (musicEntries.present) {
      map['music_entries'] = Variable<String>(
          $MusicInfosTable.$convertermusicEntries.toSql(musicEntries.value));
    }
    if (hitCount.present) {
      map['hit_count'] = Variable<int>(hitCount.value);
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
          ..write('measureCount: $measureCount, ')
          ..write('artist: $artist, ')
          ..write('cursorList: $cursorList, ')
          ..write('measureList: $measureList, ')
          ..write('sheetImage: $sheetImage, ')
          ..write('xmlData: $xmlData, ')
          ..write('type: $type, ')
          ..write('sourceCount: $sourceCount, ')
          ..write('musicEntries: $musicEntries, ')
          ..write('hitCount: $hitCount, ')
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
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES music_infos (id) ON DELETE RESTRICT'));
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now()
          .toString()
          .replaceAll(RegExp(r':\d\d\.\d+'), '')
          .replaceAll('-', '.'));
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
      defaultValue: const Constant(false));
  static const VerificationMeta _transcriptionMeta =
      const VerificationMeta('transcription');
  @override
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      transcription = GeneratedColumn<String>(
              'transcription', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(const MusicEntryListConvertor().toSql([])))
          .withConverter<List<MusicEntry>>(
              $PracticeInfosTable.$convertertranscription);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES project_infos (id) ON DELETE RESTRICT'));
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _componentCountMeta =
      const VerificationMeta('componentCount');
  @override
  late final GeneratedColumnWithTypeConverter<ComponentCount?, String>
      componentCount = GeneratedColumn<String>(
              'component_count', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ComponentCount?>(
              $PracticeInfosTable.$convertercomponentCountn);
  static const VerificationMeta _accuracyCountMeta =
      const VerificationMeta('accuracyCount');
  @override
  late final GeneratedColumnWithTypeConverter<AccuracyCount?, String>
      accuracyCount = GeneratedColumn<String>(
              'accuracy_count', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<AccuracyCount?>(
              $PracticeInfosTable.$converteraccuracyCountn);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumnWithTypeConverter<List<ScoredEntry>?,
      String> result = GeneratedColumn<String>('result', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: Constant(const ScoredEntryListConvertor().toSql([])))
      .withConverter<List<ScoredEntry>?>($PracticeInfosTable.$converterresultn);
  @override
  List<GeneratedColumn> get $columns => [
        title,
        bpm,
        isNew,
        transcription,
        id,
        createdAt,
        updatedAt,
        projectId,
        speed,
        componentCount,
        accuracyCount,
        score,
        result
      ];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
    context.handle(_transcriptionMeta, const VerificationResult.success());
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
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    }
    context.handle(_componentCountMeta, const VerificationResult.success());
    context.handle(_accuracyCountMeta, const VerificationResult.success());
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    context.handle(_resultMeta, const VerificationResult.success());
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      transcription: $PracticeInfosTable.$convertertranscription.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}transcription'])!),
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
      accuracyCount: $PracticeInfosTable.$converteraccuracyCountn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}accuracy_count'])),
      componentCount: $PracticeInfosTable.$convertercomponentCountn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}component_count'])),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      result: $PracticeInfosTable.$converterresultn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result'])),
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed'])!,
    );
  }

  @override
  $PracticeInfosTable createAlias(String alias) {
    return $PracticeInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<List<MusicEntry>, String> $convertertranscription =
      const MusicEntryListConvertor();
  static TypeConverter<ComponentCount, String> $convertercomponentCount =
      const ComponentCountConvertor();
  static TypeConverter<ComponentCount?, String?> $convertercomponentCountn =
      NullAwareTypeConverter.wrap($convertercomponentCount);
  static TypeConverter<AccuracyCount, String> $converteraccuracyCount =
      const AccuracyCountConvertor();
  static TypeConverter<AccuracyCount?, String?> $converteraccuracyCountn =
      NullAwareTypeConverter.wrap($converteraccuracyCount);
  static TypeConverter<List<ScoredEntry>, String> $converterresult =
      const ScoredEntryListConvertor();
  static TypeConverter<List<ScoredEntry>?, String?> $converterresultn =
      NullAwareTypeConverter.wrap($converterresult);
}

class PracticeInfosCompanion extends UpdateCompanion<PracticeInfo> {
  final Value<String> title;
  final Value<int> bpm;
  final Value<bool> isNew;
  final Value<List<MusicEntry>> transcription;
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> projectId;
  final Value<double> speed;
  final Value<ComponentCount?> componentCount;
  final Value<AccuracyCount?> accuracyCount;
  final Value<int?> score;
  final Value<List<ScoredEntry>?> result;
  final Value<int> rowid;
  const PracticeInfosCompanion({
    this.title = const Value.absent(),
    this.bpm = const Value.absent(),
    this.isNew = const Value.absent(),
    this.transcription = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.speed = const Value.absent(),
    this.componentCount = const Value.absent(),
    this.accuracyCount = const Value.absent(),
    this.score = const Value.absent(),
    this.result = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PracticeInfosCompanion.insert({
    this.title = const Value.absent(),
    required int bpm,
    this.isNew = const Value.absent(),
    this.transcription = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String projectId,
    this.speed = const Value.absent(),
    this.componentCount = const Value.absent(),
    this.accuracyCount = const Value.absent(),
    this.score = const Value.absent(),
    this.result = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : bpm = Value(bpm),
        projectId = Value(projectId);
  static Insertable<PracticeInfo> custom({
    Expression<String>? title,
    Expression<int>? bpm,
    Expression<bool>? isNew,
    Expression<String>? transcription,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? projectId,
    Expression<double>? speed,
    Expression<String>? componentCount,
    Expression<String>? accuracyCount,
    Expression<int>? score,
    Expression<String>? result,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (bpm != null) 'bpm': bpm,
      if (isNew != null) 'is_new': isNew,
      if (transcription != null) 'transcription': transcription,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (projectId != null) 'project_id': projectId,
      if (speed != null) 'speed': speed,
      if (componentCount != null) 'component_count': componentCount,
      if (accuracyCount != null) 'accuracy_count': accuracyCount,
      if (score != null) 'score': score,
      if (result != null) 'result': result,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PracticeInfosCompanion copyWith(
      {Value<String>? title,
      Value<int>? bpm,
      Value<bool>? isNew,
      Value<List<MusicEntry>>? transcription,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? projectId,
      Value<double>? speed,
      Value<ComponentCount?>? componentCount,
      Value<AccuracyCount?>? accuracyCount,
      Value<int?>? score,
      Value<List<ScoredEntry>?>? result,
      Value<int>? rowid}) {
    return PracticeInfosCompanion(
      title: title ?? this.title,
      bpm: bpm ?? this.bpm,
      isNew: isNew ?? this.isNew,
      transcription: transcription ?? this.transcription,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      projectId: projectId ?? this.projectId,
      speed: speed ?? this.speed,
      componentCount: componentCount ?? this.componentCount,
      accuracyCount: accuracyCount ?? this.accuracyCount,
      score: score ?? this.score,
      result: result ?? this.result,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (bpm.present) {
      map['bpm'] = Variable<int>(bpm.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (transcription.present) {
      map['transcription'] = Variable<String>($PracticeInfosTable
          .$convertertranscription
          .toSql(transcription.value));
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (componentCount.present) {
      map['component_count'] = Variable<String>($PracticeInfosTable
          .$convertercomponentCountn
          .toSql(componentCount.value));
    }
    if (accuracyCount.present) {
      map['accuracy_count'] = Variable<String>($PracticeInfosTable
          .$converteraccuracyCountn
          .toSql(accuracyCount.value));
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(
          $PracticeInfosTable.$converterresultn.toSql(result.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeInfosCompanion(')
          ..write('title: $title, ')
          ..write('bpm: $bpm, ')
          ..write('isNew: $isNew, ')
          ..write('transcription: $transcription, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('projectId: $projectId, ')
          ..write('speed: $speed, ')
          ..write('componentCount: $componentCount, ')
          ..write('accuracyCount: $accuracyCount, ')
          ..write('score: $score, ')
          ..write('result: $result, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillInfosTable extends DrillInfos
    with TableInfo<$DrillInfosTable, DrillInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES project_infos (id) ON DELETE RESTRICT'));
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<int> start = GeneratedColumn<int>(
      'start', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<int> end = GeneratedColumn<int>(
      'end', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, projectId, start, end];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_infos';
  @override
  VerificationContext validateIntegrity(Insertable<DrillInfo> instance,
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
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DrillInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start'])!,
      end: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end'])!,
    );
  }

  @override
  $DrillInfosTable createAlias(String alias) {
    return $DrillInfosTable(attachedDatabase, alias);
  }
}

class DrillInfosCompanion extends UpdateCompanion<DrillInfo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> projectId;
  final Value<int> start;
  final Value<int> end;
  final Value<int> rowid;
  const DrillInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String projectId,
    required int start,
    required int end,
    this.rowid = const Value.absent(),
  })  : projectId = Value(projectId),
        start = Value(start),
        end = Value(end);
  static Insertable<DrillInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? projectId,
    Expression<int>? start,
    Expression<int>? end,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (projectId != null) 'project_id': projectId,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? projectId,
      Value<int>? start,
      Value<int>? end,
      Value<int>? rowid}) {
    return DrillInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      projectId: projectId ?? this.projectId,
      start: start ?? this.start,
      end: end ?? this.end,
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
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (start.present) {
      map['start'] = Variable<int>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<int>(end.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('projectId: $projectId, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrillReportInfosTable extends DrillReportInfos
    with TableInfo<$DrillReportInfosTable, DrillReportInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrillReportInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now()
          .toString()
          .replaceAll(RegExp(r':\d\d\.\d+'), '')
          .replaceAll('-', '.'));
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
      defaultValue: const Constant(false));
  static const VerificationMeta _transcriptionMeta =
      const VerificationMeta('transcription');
  @override
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      transcription = GeneratedColumn<String>(
              'transcription', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(const MusicEntryListConvertor().toSql([])))
          .withConverter<List<MusicEntry>>(
              $DrillReportInfosTable.$convertertranscription);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  static const VerificationMeta _drillIdMeta =
      const VerificationMeta('drillId');
  @override
  late final GeneratedColumn<String> drillId = GeneratedColumn<String>(
      'drill_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES drill_infos (id) ON DELETE RESTRICT'));
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _scoresMeta = const VerificationMeta('scores');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>?, String> scores =
      GeneratedColumn<String>('scores', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<int>?>($DrillReportInfosTable.$converterscoresn);
  static const VerificationMeta _resultsMeta =
      const VerificationMeta('results');
  @override
  late final GeneratedColumnWithTypeConverter<List<List<ScoredEntry>>?, String>
      results = GeneratedColumn<String>('results', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue:
                  Constant(const ScoredEntry2dListConvertor().toSql([])))
          .withConverter<List<List<ScoredEntry>>?>(
              $DrillReportInfosTable.$converterresultsn);
  @override
  List<GeneratedColumn> get $columns => [
        title,
        bpm,
        isNew,
        transcription,
        id,
        createdAt,
        updatedAt,
        drillId,
        count,
        scores,
        results
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drill_report_infos';
  @override
  VerificationContext validateIntegrity(Insertable<DrillReportInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
    context.handle(_transcriptionMeta, const VerificationResult.success());
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
    if (data.containsKey('drill_id')) {
      context.handle(_drillIdMeta,
          drillId.isAcceptableOrUnknown(data['drill_id']!, _drillIdMeta));
    } else if (isInserting) {
      context.missing(_drillIdMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    context.handle(_scoresMeta, const VerificationResult.success());
    context.handle(_resultsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DrillReportInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillReportInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      transcription: $DrillReportInfosTable.$convertertranscription.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}transcription'])!),
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
      results: $DrillReportInfosTable.$converterresultsn.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}results'])),
      scores: $DrillReportInfosTable.$converterscoresn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scores'])),
      drillId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drill_id'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
    );
  }

  @override
  $DrillReportInfosTable createAlias(String alias) {
    return $DrillReportInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<List<MusicEntry>, String> $convertertranscription =
      const MusicEntryListConvertor();
  static TypeConverter<List<int>, String> $converterscores =
      const ListConverter();
  static TypeConverter<List<int>?, String?> $converterscoresn =
      NullAwareTypeConverter.wrap($converterscores);
  static TypeConverter<List<List<ScoredEntry>>, String> $converterresults =
      const ScoredEntry2dListConvertor();
  static TypeConverter<List<List<ScoredEntry>>?, String?> $converterresultsn =
      NullAwareTypeConverter.wrap($converterresults);
}

class DrillReportInfosCompanion extends UpdateCompanion<DrillReportInfo> {
  final Value<String> title;
  final Value<int> bpm;
  final Value<bool> isNew;
  final Value<List<MusicEntry>> transcription;
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> drillId;
  final Value<int> count;
  final Value<List<int>?> scores;
  final Value<List<List<ScoredEntry>>?> results;
  final Value<int> rowid;
  const DrillReportInfosCompanion({
    this.title = const Value.absent(),
    this.bpm = const Value.absent(),
    this.isNew = const Value.absent(),
    this.transcription = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.drillId = const Value.absent(),
    this.count = const Value.absent(),
    this.scores = const Value.absent(),
    this.results = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrillReportInfosCompanion.insert({
    this.title = const Value.absent(),
    required int bpm,
    this.isNew = const Value.absent(),
    this.transcription = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String drillId,
    this.count = const Value.absent(),
    this.scores = const Value.absent(),
    this.results = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : bpm = Value(bpm),
        drillId = Value(drillId);
  static Insertable<DrillReportInfo> custom({
    Expression<String>? title,
    Expression<int>? bpm,
    Expression<bool>? isNew,
    Expression<String>? transcription,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? drillId,
    Expression<int>? count,
    Expression<String>? scores,
    Expression<String>? results,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (bpm != null) 'bpm': bpm,
      if (isNew != null) 'is_new': isNew,
      if (transcription != null) 'transcription': transcription,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (drillId != null) 'drill_id': drillId,
      if (count != null) 'count': count,
      if (scores != null) 'scores': scores,
      if (results != null) 'results': results,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrillReportInfosCompanion copyWith(
      {Value<String>? title,
      Value<int>? bpm,
      Value<bool>? isNew,
      Value<List<MusicEntry>>? transcription,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? drillId,
      Value<int>? count,
      Value<List<int>?>? scores,
      Value<List<List<ScoredEntry>>?>? results,
      Value<int>? rowid}) {
    return DrillReportInfosCompanion(
      title: title ?? this.title,
      bpm: bpm ?? this.bpm,
      isNew: isNew ?? this.isNew,
      transcription: transcription ?? this.transcription,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      drillId: drillId ?? this.drillId,
      count: count ?? this.count,
      scores: scores ?? this.scores,
      results: results ?? this.results,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (bpm.present) {
      map['bpm'] = Variable<int>(bpm.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (transcription.present) {
      map['transcription'] = Variable<String>($DrillReportInfosTable
          .$convertertranscription
          .toSql(transcription.value));
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (drillId.present) {
      map['drill_id'] = Variable<String>(drillId.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (scores.present) {
      map['scores'] = Variable<String>(
          $DrillReportInfosTable.$converterscoresn.toSql(scores.value));
    }
    if (results.present) {
      map['results'] = Variable<String>(
          $DrillReportInfosTable.$converterresultsn.toSql(results.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrillReportInfosCompanion(')
          ..write('title: $title, ')
          ..write('bpm: $bpm, ')
          ..write('isNew: $isNew, ')
          ..write('transcription: $transcription, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('drillId: $drillId, ')
          ..write('count: $count, ')
          ..write('scores: $scores, ')
          ..write('results: $results, ')
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
  final Uint8List sheetImage;
  final DateTime createdAt;
  const MusicThumbnailViewData(
      {required this.id,
      required this.type,
      required this.title,
      required this.artist,
      required this.sheetImage,
      required this.createdAt});
  factory MusicThumbnailViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MusicThumbnailViewData(
      id: serializer.fromJson<String>(json['id']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      sheetImage: serializer.fromJson<Uint8List>(json['sheetImage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'sheetImage': serializer.toJson<Uint8List>(sheetImage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MusicThumbnailViewData copyWith(
          {String? id,
          MusicType? type,
          String? title,
          String? artist,
          Uint8List? sheetImage,
          DateTime? createdAt}) =>
      MusicThumbnailViewData(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        sheetImage: sheetImage ?? this.sheetImage,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('MusicThumbnailViewData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('sheetImage: $sheetImage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, title, artist, $driftBlobEquality.hash(sheetImage), createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MusicThumbnailViewData &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.artist == this.artist &&
          $driftBlobEquality.equals(other.sheetImage, this.sheetImage) &&
          other.createdAt == this.createdAt);
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
  List<GeneratedColumn> get $columns =>
      [id, type, title, artist, sheetImage, createdAt];
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
      sheetImage: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}sheet_image'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
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
  late final GeneratedColumn<Uint8List> sheetImage = GeneratedColumn<Uint8List>(
      'sheet_image', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.sheetImage, false),
      type: DriftSqlType.blob);
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(musicInfos.createdAt, false),
      type: DriftSqlType.dateTime);
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
  final List<Cursor> measureList;
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
      required this.measureList});
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
      measureList: serializer.fromJson<List<Cursor>>(json['measureList']),
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
      'measureList': serializer.toJson<List<Cursor>>(measureList),
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
          List<Cursor>? measureList}) =>
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
        measureList: measureList ?? this.measureList,
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
          ..write('measureList: $measureList')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isLiked, createdAt, musicId,
      musicTitle, artist, bpm, type, measureList);
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
          other.measureList == this.measureList);
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
        measureList
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
      measureList: $MusicInfosTable.$convertermeasureList.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}measure_list'])!),
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
  late final GeneratedColumnWithTypeConverter<List<Cursor>, String>
      measureList = GeneratedColumn<String>('measure_list', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.measureList, false),
              type: DriftSqlType.string)
          .withConverter<List<Cursor>>($MusicInfosTable.$convertermeasureList);
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
  final DateTime createdAt;
  const ProjectSidebarViewData(
      {required this.id,
      required this.title,
      required this.type,
      required this.createdAt});
  factory ProjectSidebarViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectSidebarViewData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: $MusicInfosTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProjectSidebarViewData copyWith(
          {String? id, String? title, MusicType? type, DateTime? createdAt}) =>
      ProjectSidebarViewData(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectSidebarViewData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, type, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectSidebarViewData &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
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
  List<GeneratedColumn> get $columns => [id, title, type, createdAt];
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(projects.createdAt, false),
      type: DriftSqlType.dateTime);
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
  final DateTime createdAt;
  final MusicType type;
  final int? unreadCount;
  const ProjectThumbnailViewData(
      {required this.id,
      required this.title,
      required this.isLiked,
      required this.createdAt,
      required this.type,
      this.unreadCount});
  factory ProjectThumbnailViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectThumbnailViewData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'type':
          serializer.toJson<int>($MusicInfosTable.$convertertype.toJson(type)),
      'unreadCount': serializer.toJson<int?>(unreadCount),
    };
  }

  ProjectThumbnailViewData copyWith(
          {String? id,
          String? title,
          bool? isLiked,
          DateTime? createdAt,
          MusicType? type,
          Value<int?> unreadCount = const Value.absent()}) =>
      ProjectThumbnailViewData(
        id: id ?? this.id,
        title: title ?? this.title,
        isLiked: isLiked ?? this.isLiked,
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        unreadCount: unreadCount.present ? unreadCount.value : this.unreadCount,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectThumbnailViewData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isLiked: $isLiked, ')
          ..write('createdAt: $createdAt, ')
          ..write('type: $type, ')
          ..write('unreadCount: $unreadCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, isLiked, createdAt, type, unreadCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectThumbnailViewData &&
          other.id == this.id &&
          other.title == this.title &&
          other.isLiked == this.isLiked &&
          other.createdAt == this.createdAt &&
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
  List<GeneratedColumn> get $columns =>
      [id, title, isLiked, createdAt, type, unreadCount];
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
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
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
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(projects.createdAt, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumnWithTypeConverter<MusicType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              generatedAs: GeneratedAs(musicInfos.type, false),
              type: DriftSqlType.int)
          .withConverter<MusicType>($MusicInfosTable.$convertertype);
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
      'unread_count', aliasedName, true,
      generatedAs: GeneratedAs(practices.isNew.dartCast<int>().sum(), false),
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

class ProjectSummaryViewData extends DataClass {
  final String id;
  final ComponentCount sourceCount;
  final List<MusicEntry> musicEntries;
  final int? bestScore;
  final int hitCount;
  const ProjectSummaryViewData(
      {required this.id,
      required this.sourceCount,
      required this.musicEntries,
      this.bestScore,
      required this.hitCount});
  factory ProjectSummaryViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectSummaryViewData(
      id: serializer.fromJson<String>(json['id']),
      sourceCount: serializer.fromJson<ComponentCount>(json['sourceCount']),
      musicEntries: serializer.fromJson<List<MusicEntry>>(json['musicEntries']),
      bestScore: serializer.fromJson<int?>(json['bestScore']),
      hitCount: serializer.fromJson<int>(json['hitCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceCount': serializer.toJson<ComponentCount>(sourceCount),
      'musicEntries': serializer.toJson<List<MusicEntry>>(musicEntries),
      'bestScore': serializer.toJson<int?>(bestScore),
      'hitCount': serializer.toJson<int>(hitCount),
    };
  }

  ProjectSummaryViewData copyWith(
          {String? id,
          ComponentCount? sourceCount,
          List<MusicEntry>? musicEntries,
          Value<int?> bestScore = const Value.absent(),
          int? hitCount}) =>
      ProjectSummaryViewData(
        id: id ?? this.id,
        sourceCount: sourceCount ?? this.sourceCount,
        musicEntries: musicEntries ?? this.musicEntries,
        bestScore: bestScore.present ? bestScore.value : this.bestScore,
        hitCount: hitCount ?? this.hitCount,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectSummaryViewData(')
          ..write('id: $id, ')
          ..write('sourceCount: $sourceCount, ')
          ..write('musicEntries: $musicEntries, ')
          ..write('bestScore: $bestScore, ')
          ..write('hitCount: $hitCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sourceCount, musicEntries, bestScore, hitCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectSummaryViewData &&
          other.id == this.id &&
          other.sourceCount == this.sourceCount &&
          other.musicEntries == this.musicEntries &&
          other.bestScore == this.bestScore &&
          other.hitCount == this.hitCount);
}

class $ProjectSummaryViewView
    extends ViewInfo<$ProjectSummaryViewView, ProjectSummaryViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $ProjectSummaryViewView(this.attachedDatabase, [this._alias]);
  $MusicInfosTable get musicInfo =>
      attachedDatabase.musicInfos.createAlias('t0');
  $ProjectInfosTable get projectInfo =>
      attachedDatabase.projectInfos.createAlias('t1');
  $PracticeInfosTable get practiceList =>
      attachedDatabase.practiceInfos.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns =>
      [id, sourceCount, musicEntries, bestScore, hitCount];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'project_summary_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $ProjectSummaryViewView get asDslTable => this;
  @override
  ProjectSummaryViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectSummaryViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sourceCount: $MusicInfosTable.$convertersourceCount.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}source_count'])!),
      musicEntries: $MusicInfosTable.$convertermusicEntries.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}music_entries'])!),
      bestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_score']),
      hitCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hit_count'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(projectInfo.id, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<ComponentCount, String>
      sourceCount = GeneratedColumn<String>('source_count', aliasedName, false,
              generatedAs: GeneratedAs(musicInfo.sourceCount, false),
              type: DriftSqlType.string)
          .withConverter<ComponentCount>(
              $MusicInfosTable.$convertersourceCount);
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      musicEntries = GeneratedColumn<String>(
              'music_entries', aliasedName, false,
              generatedAs: GeneratedAs(musicInfo.musicEntries, false),
              type: DriftSqlType.string)
          .withConverter<List<MusicEntry>>(
              $MusicInfosTable.$convertermusicEntries);
  late final GeneratedColumn<int> bestScore = GeneratedColumn<int>(
      'best_score', aliasedName, true,
      generatedAs: GeneratedAs(practiceList.score.max(), false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> hitCount = GeneratedColumn<int>(
      'hit_count', aliasedName, false,
      generatedAs: GeneratedAs(musicInfo.hitCount, false),
      type: DriftSqlType.int);
  @override
  $ProjectSummaryViewView createAlias(String alias) {
    return $ProjectSummaryViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(projectInfo)..addColumns($columns)).join([
        innerJoin(musicInfo, musicInfo.id.equalsExp(projectInfo.musicId)),
        leftOuterJoin(
            practiceList, practiceList.projectId.equalsExp(projectInfo.id))
      ])
        ..groupBy([projectInfo.id]);
  @override
  Set<String> get readTables =>
      const {'music_infos', 'project_infos', 'practice_infos'};
}

class PracticeReportViewData extends DataClass {
  final String id;
  final int bpm;
  final double speed;
  final int? score;
  final AccuracyCount? accuracyCount;
  final ComponentCount? componentCount;
  final bool isNew;
  final List<ScoredEntry>? result;
  final ComponentCount sourceCount;
  final List<MusicEntry> musicEntries;
  final Uint8List xmlData;
  final int hitCount;
  final List<Cursor> measureList;
  final String? musicId;
  final String? musicTitle;
  final String? musicArtist;
  final int? sourceBPM;
  final String? projectId;
  final int? bestScore;
  const PracticeReportViewData(
      {required this.id,
      required this.bpm,
      required this.speed,
      this.score,
      this.accuracyCount,
      this.componentCount,
      required this.isNew,
      this.result,
      required this.sourceCount,
      required this.musicEntries,
      required this.xmlData,
      required this.hitCount,
      required this.measureList,
      this.musicId,
      this.musicTitle,
      this.musicArtist,
      this.sourceBPM,
      this.projectId,
      this.bestScore});
  factory PracticeReportViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeReportViewData(
      id: serializer.fromJson<String>(json['id']),
      bpm: serializer.fromJson<int>(json['bpm']),
      speed: serializer.fromJson<double>(json['speed']),
      score: serializer.fromJson<int?>(json['score']),
      accuracyCount: serializer.fromJson<AccuracyCount?>(json['accuracyCount']),
      componentCount:
          serializer.fromJson<ComponentCount?>(json['componentCount']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      result: serializer.fromJson<List<ScoredEntry>?>(json['result']),
      sourceCount: serializer.fromJson<ComponentCount>(json['sourceCount']),
      musicEntries: serializer.fromJson<List<MusicEntry>>(json['musicEntries']),
      xmlData: serializer.fromJson<Uint8List>(json['xmlData']),
      hitCount: serializer.fromJson<int>(json['hitCount']),
      measureList: serializer.fromJson<List<Cursor>>(json['measureList']),
      musicId: serializer.fromJson<String?>(json['musicId']),
      musicTitle: serializer.fromJson<String?>(json['musicTitle']),
      musicArtist: serializer.fromJson<String?>(json['musicArtist']),
      sourceBPM: serializer.fromJson<int?>(json['sourceBPM']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      bestScore: serializer.fromJson<int?>(json['bestScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bpm': serializer.toJson<int>(bpm),
      'speed': serializer.toJson<double>(speed),
      'score': serializer.toJson<int?>(score),
      'accuracyCount': serializer.toJson<AccuracyCount?>(accuracyCount),
      'componentCount': serializer.toJson<ComponentCount?>(componentCount),
      'isNew': serializer.toJson<bool>(isNew),
      'result': serializer.toJson<List<ScoredEntry>?>(result),
      'sourceCount': serializer.toJson<ComponentCount>(sourceCount),
      'musicEntries': serializer.toJson<List<MusicEntry>>(musicEntries),
      'xmlData': serializer.toJson<Uint8List>(xmlData),
      'hitCount': serializer.toJson<int>(hitCount),
      'measureList': serializer.toJson<List<Cursor>>(measureList),
      'musicId': serializer.toJson<String?>(musicId),
      'musicTitle': serializer.toJson<String?>(musicTitle),
      'musicArtist': serializer.toJson<String?>(musicArtist),
      'sourceBPM': serializer.toJson<int?>(sourceBPM),
      'projectId': serializer.toJson<String?>(projectId),
      'bestScore': serializer.toJson<int?>(bestScore),
    };
  }

  PracticeReportViewData copyWith(
          {String? id,
          int? bpm,
          double? speed,
          Value<int?> score = const Value.absent(),
          Value<AccuracyCount?> accuracyCount = const Value.absent(),
          Value<ComponentCount?> componentCount = const Value.absent(),
          bool? isNew,
          Value<List<ScoredEntry>?> result = const Value.absent(),
          ComponentCount? sourceCount,
          List<MusicEntry>? musicEntries,
          Uint8List? xmlData,
          int? hitCount,
          List<Cursor>? measureList,
          Value<String?> musicId = const Value.absent(),
          Value<String?> musicTitle = const Value.absent(),
          Value<String?> musicArtist = const Value.absent(),
          Value<int?> sourceBPM = const Value.absent(),
          Value<String?> projectId = const Value.absent(),
          Value<int?> bestScore = const Value.absent()}) =>
      PracticeReportViewData(
        id: id ?? this.id,
        bpm: bpm ?? this.bpm,
        speed: speed ?? this.speed,
        score: score.present ? score.value : this.score,
        accuracyCount:
            accuracyCount.present ? accuracyCount.value : this.accuracyCount,
        componentCount:
            componentCount.present ? componentCount.value : this.componentCount,
        isNew: isNew ?? this.isNew,
        result: result.present ? result.value : this.result,
        sourceCount: sourceCount ?? this.sourceCount,
        musicEntries: musicEntries ?? this.musicEntries,
        xmlData: xmlData ?? this.xmlData,
        hitCount: hitCount ?? this.hitCount,
        measureList: measureList ?? this.measureList,
        musicId: musicId.present ? musicId.value : this.musicId,
        musicTitle: musicTitle.present ? musicTitle.value : this.musicTitle,
        musicArtist: musicArtist.present ? musicArtist.value : this.musicArtist,
        sourceBPM: sourceBPM.present ? sourceBPM.value : this.sourceBPM,
        projectId: projectId.present ? projectId.value : this.projectId,
        bestScore: bestScore.present ? bestScore.value : this.bestScore,
      );
  @override
  String toString() {
    return (StringBuffer('PracticeReportViewData(')
          ..write('id: $id, ')
          ..write('bpm: $bpm, ')
          ..write('speed: $speed, ')
          ..write('score: $score, ')
          ..write('accuracyCount: $accuracyCount, ')
          ..write('componentCount: $componentCount, ')
          ..write('isNew: $isNew, ')
          ..write('result: $result, ')
          ..write('sourceCount: $sourceCount, ')
          ..write('musicEntries: $musicEntries, ')
          ..write('xmlData: $xmlData, ')
          ..write('hitCount: $hitCount, ')
          ..write('measureList: $measureList, ')
          ..write('musicId: $musicId, ')
          ..write('musicTitle: $musicTitle, ')
          ..write('musicArtist: $musicArtist, ')
          ..write('sourceBPM: $sourceBPM, ')
          ..write('projectId: $projectId, ')
          ..write('bestScore: $bestScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      bpm,
      speed,
      score,
      accuracyCount,
      componentCount,
      isNew,
      result,
      sourceCount,
      musicEntries,
      $driftBlobEquality.hash(xmlData),
      hitCount,
      measureList,
      musicId,
      musicTitle,
      musicArtist,
      sourceBPM,
      projectId,
      bestScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeReportViewData &&
          other.id == this.id &&
          other.bpm == this.bpm &&
          other.speed == this.speed &&
          other.score == this.score &&
          other.accuracyCount == this.accuracyCount &&
          other.componentCount == this.componentCount &&
          other.isNew == this.isNew &&
          other.result == this.result &&
          other.sourceCount == this.sourceCount &&
          other.musicEntries == this.musicEntries &&
          $driftBlobEquality.equals(other.xmlData, this.xmlData) &&
          other.hitCount == this.hitCount &&
          other.measureList == this.measureList &&
          other.musicId == this.musicId &&
          other.musicTitle == this.musicTitle &&
          other.musicArtist == this.musicArtist &&
          other.sourceBPM == this.sourceBPM &&
          other.projectId == this.projectId &&
          other.bestScore == this.bestScore);
}

class $PracticeReportViewView
    extends ViewInfo<$PracticeReportViewView, PracticeReportViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $PracticeReportViewView(this.attachedDatabase, [this._alias]);
  $PracticeInfosTable get practice =>
      attachedDatabase.practiceInfos.createAlias('t0');
  $MusicInfosTable get musicInfo =>
      attachedDatabase.musicInfos.createAlias('t1');
  $ProjectInfosTable get projectInfo =>
      attachedDatabase.projectInfos.createAlias('t2');
  $PracticeInfosTable get practiceList =>
      attachedDatabase.practiceInfos.createAlias('t3');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bpm,
        speed,
        score,
        accuracyCount,
        componentCount,
        isNew,
        result,
        sourceCount,
        musicEntries,
        xmlData,
        hitCount,
        measureList,
        musicId,
        musicTitle,
        musicArtist,
        sourceBPM,
        projectId,
        bestScore
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'practice_report_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $PracticeReportViewView get asDslTable => this;
  @override
  PracticeReportViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeReportViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      accuracyCount: $PracticeInfosTable.$converteraccuracyCountn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}accuracy_count'])),
      componentCount: $PracticeInfosTable.$convertercomponentCountn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}component_count'])),
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
      result: $PracticeInfosTable.$converterresultn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result'])),
      sourceCount: $MusicInfosTable.$convertersourceCount.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}source_count'])!),
      musicEntries: $MusicInfosTable.$convertermusicEntries.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}music_entries'])!),
      xmlData: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}xml_data'])!,
      hitCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hit_count'])!,
      measureList: $MusicInfosTable.$convertermeasureList.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}measure_list'])!),
      musicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_id']),
      musicTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_title']),
      musicArtist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_artist']),
      sourceBPM: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_b_p_m']),
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id']),
      bestScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}best_score']),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(practice.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      generatedAs: GeneratedAs(practice.bpm, false), type: DriftSqlType.int);
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, false,
      generatedAs: GeneratedAs(practice.speed, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      generatedAs: GeneratedAs(practice.score, false), type: DriftSqlType.int);
  late final GeneratedColumnWithTypeConverter<AccuracyCount?, String>
      accuracyCount = GeneratedColumn<String>(
              'accuracy_count', aliasedName, true,
              generatedAs: GeneratedAs(practice.accuracyCount, false),
              type: DriftSqlType.string)
          .withConverter<AccuracyCount?>(
              $PracticeInfosTable.$converteraccuracyCountn);
  late final GeneratedColumnWithTypeConverter<ComponentCount?, String>
      componentCount = GeneratedColumn<String>(
              'component_count', aliasedName, true,
              generatedAs: GeneratedAs(practice.componentCount, false),
              type: DriftSqlType.string)
          .withConverter<ComponentCount?>(
              $PracticeInfosTable.$convertercomponentCountn);
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
      'is_new', aliasedName, false,
      generatedAs: GeneratedAs(practice.isNew, false),
      type: DriftSqlType.bool,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_new" IN (0, 1))'));
  late final GeneratedColumnWithTypeConverter<List<ScoredEntry>?, String>
      result = GeneratedColumn<String>('result', aliasedName, true,
              generatedAs: GeneratedAs(practice.result, false),
              type: DriftSqlType.string)
          .withConverter<List<ScoredEntry>?>(
              $PracticeInfosTable.$converterresultn);
  late final GeneratedColumnWithTypeConverter<ComponentCount, String>
      sourceCount = GeneratedColumn<String>('source_count', aliasedName, false,
              generatedAs: GeneratedAs(musicInfo.sourceCount, false),
              type: DriftSqlType.string)
          .withConverter<ComponentCount>(
              $MusicInfosTable.$convertersourceCount);
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      musicEntries = GeneratedColumn<String>(
              'music_entries', aliasedName, false,
              generatedAs: GeneratedAs(musicInfo.musicEntries, false),
              type: DriftSqlType.string)
          .withConverter<List<MusicEntry>>(
              $MusicInfosTable.$convertermusicEntries);
  late final GeneratedColumn<Uint8List> xmlData = GeneratedColumn<Uint8List>(
      'xml_data', aliasedName, false,
      generatedAs: GeneratedAs(musicInfo.xmlData, false),
      type: DriftSqlType.blob);
  late final GeneratedColumn<int> hitCount = GeneratedColumn<int>(
      'hit_count', aliasedName, false,
      generatedAs: GeneratedAs(musicInfo.hitCount, false),
      type: DriftSqlType.int);
  late final GeneratedColumnWithTypeConverter<List<Cursor>, String>
      measureList = GeneratedColumn<String>('measure_list', aliasedName, false,
              generatedAs: GeneratedAs(musicInfo.measureList, false),
              type: DriftSqlType.string)
          .withConverter<List<Cursor>>($MusicInfosTable.$convertermeasureList);
  late final GeneratedColumn<String> musicId = GeneratedColumn<String>(
      'music_id', aliasedName, true,
      generatedAs: GeneratedAs(musicInfo.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> musicTitle = GeneratedColumn<String>(
      'music_title', aliasedName, true,
      generatedAs: GeneratedAs(musicInfo.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> musicArtist = GeneratedColumn<String>(
      'music_artist', aliasedName, true,
      generatedAs: GeneratedAs(musicInfo.artist, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> sourceBPM = GeneratedColumn<int>(
      'source_b_p_m', aliasedName, true,
      generatedAs: GeneratedAs(musicInfo.bpm, false), type: DriftSqlType.int);
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, true,
      generatedAs: GeneratedAs(projectInfo.id, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> bestScore = GeneratedColumn<int>(
      'best_score', aliasedName, true,
      generatedAs: GeneratedAs(practiceList.score.max(), false),
      type: DriftSqlType.int);
  @override
  $PracticeReportViewView createAlias(String alias) {
    return $PracticeReportViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(practice)..addColumns($columns)).join([
        innerJoin(projectInfo, projectInfo.id.equalsExp(practice.projectId)),
        innerJoin(musicInfo, musicInfo.id.equalsExp(projectInfo.musicId)),
        leftOuterJoin(
            practiceList, practiceList.projectId.equalsExp(practice.projectId))
      ])
        ..groupBy([practice.id]);
  @override
  Set<String> get readTables =>
      const {'practice_infos', 'music_infos', 'project_infos'};
}

class PracticeListViewData extends DataClass {
  final String id;
  final String projectId;
  final String title;
  final int bpm;
  final double speed;
  final int? score;
  final bool isNew;
  final DateTime createdAt;
  const PracticeListViewData(
      {required this.id,
      required this.projectId,
      required this.title,
      required this.bpm,
      required this.speed,
      this.score,
      required this.isNew,
      required this.createdAt});
  factory PracticeListViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeListViewData(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      title: serializer.fromJson<String>(json['title']),
      bpm: serializer.fromJson<int>(json['bpm']),
      speed: serializer.fromJson<double>(json['speed']),
      score: serializer.fromJson<int?>(json['score']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'title': serializer.toJson<String>(title),
      'bpm': serializer.toJson<int>(bpm),
      'speed': serializer.toJson<double>(speed),
      'score': serializer.toJson<int?>(score),
      'isNew': serializer.toJson<bool>(isNew),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PracticeListViewData copyWith(
          {String? id,
          String? projectId,
          String? title,
          int? bpm,
          double? speed,
          Value<int?> score = const Value.absent(),
          bool? isNew,
          DateTime? createdAt}) =>
      PracticeListViewData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        title: title ?? this.title,
        bpm: bpm ?? this.bpm,
        speed: speed ?? this.speed,
        score: score.present ? score.value : this.score,
        isNew: isNew ?? this.isNew,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('PracticeListViewData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('bpm: $bpm, ')
          ..write('speed: $speed, ')
          ..write('score: $score, ')
          ..write('isNew: $isNew, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, title, bpm, speed, score, isNew, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeListViewData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.title == this.title &&
          other.bpm == this.bpm &&
          other.speed == this.speed &&
          other.score == this.score &&
          other.isNew == this.isNew &&
          other.createdAt == this.createdAt);
}

class $PracticeListViewView
    extends ViewInfo<$PracticeListViewView, PracticeListViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $PracticeListViewView(this.attachedDatabase, [this._alias]);
  $PracticeInfosTable get practice =>
      attachedDatabase.practiceInfos.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, title, bpm, speed, score, isNew, createdAt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'practice_list_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $PracticeListViewView get asDslTable => this;
  @override
  PracticeListViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeListViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}speed'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      isNew: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_new'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(practice.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      generatedAs: GeneratedAs(practice.projectId, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(practice.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      generatedAs: GeneratedAs(practice.bpm, false), type: DriftSqlType.int);
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
      'speed', aliasedName, false,
      generatedAs: GeneratedAs(practice.speed, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      generatedAs: GeneratedAs(practice.score, false), type: DriftSqlType.int);
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
      'is_new', aliasedName, false,
      generatedAs: GeneratedAs(practice.isNew, false),
      type: DriftSqlType.bool,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_new" IN (0, 1))'));
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(practice.createdAt, false),
      type: DriftSqlType.dateTime);
  @override
  $PracticeListViewView createAlias(String alias) {
    return $PracticeListViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(practice)..addColumns($columns));
  @override
  Set<String> get readTables => const {'practice_infos'};
}

class PracticeAnalysisViewData extends DataClass {
  final String id;
  final String projectId;
  final AccuracyCount? accuracyCount;
  final List<ScoredEntry>? result;
  final int? score;
  final DateTime createdAt;
  const PracticeAnalysisViewData(
      {required this.id,
      required this.projectId,
      this.accuracyCount,
      this.result,
      this.score,
      required this.createdAt});
  factory PracticeAnalysisViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeAnalysisViewData(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      accuracyCount: serializer.fromJson<AccuracyCount?>(json['accuracyCount']),
      result: serializer.fromJson<List<ScoredEntry>?>(json['result']),
      score: serializer.fromJson<int?>(json['score']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'projectId': serializer.toJson<String>(projectId),
      'accuracyCount': serializer.toJson<AccuracyCount?>(accuracyCount),
      'result': serializer.toJson<List<ScoredEntry>?>(result),
      'score': serializer.toJson<int?>(score),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PracticeAnalysisViewData copyWith(
          {String? id,
          String? projectId,
          Value<AccuracyCount?> accuracyCount = const Value.absent(),
          Value<List<ScoredEntry>?> result = const Value.absent(),
          Value<int?> score = const Value.absent(),
          DateTime? createdAt}) =>
      PracticeAnalysisViewData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        accuracyCount:
            accuracyCount.present ? accuracyCount.value : this.accuracyCount,
        result: result.present ? result.value : this.result,
        score: score.present ? score.value : this.score,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('PracticeAnalysisViewData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('accuracyCount: $accuracyCount, ')
          ..write('result: $result, ')
          ..write('score: $score, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, accuracyCount, result, score, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeAnalysisViewData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.accuracyCount == this.accuracyCount &&
          other.result == this.result &&
          other.score == this.score &&
          other.createdAt == this.createdAt);
}

class $PracticeAnalysisViewView
    extends ViewInfo<$PracticeAnalysisViewView, PracticeAnalysisViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $PracticeAnalysisViewView(this.attachedDatabase, [this._alias]);
  $PracticeInfosTable get practiceList =>
      attachedDatabase.practiceInfos.createAlias('t0');
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, accuracyCount, result, score, createdAt];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'practice_analysis_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $PracticeAnalysisViewView get asDslTable => this;
  @override
  PracticeAnalysisViewData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeAnalysisViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      accuracyCount: $PracticeInfosTable.$converteraccuracyCountn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}accuracy_count'])),
      result: $PracticeInfosTable.$converterresultn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result'])),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(practiceList.id, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      generatedAs: GeneratedAs(practiceList.projectId, false),
      type: DriftSqlType.string);
  late final GeneratedColumnWithTypeConverter<AccuracyCount?, String>
      accuracyCount = GeneratedColumn<String>(
              'accuracy_count', aliasedName, true,
              generatedAs: GeneratedAs(practiceList.accuracyCount, false),
              type: DriftSqlType.string)
          .withConverter<AccuracyCount?>(
              $PracticeInfosTable.$converteraccuracyCountn);
  late final GeneratedColumnWithTypeConverter<List<ScoredEntry>?, String>
      result = GeneratedColumn<String>('result', aliasedName, true,
              generatedAs: GeneratedAs(practiceList.result, false),
              type: DriftSqlType.string)
          .withConverter<List<ScoredEntry>?>(
              $PracticeInfosTable.$converterresultn);
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      generatedAs: GeneratedAs(practiceList.score, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      generatedAs: GeneratedAs(practiceList.createdAt, false),
      type: DriftSqlType.dateTime);
  @override
  $PracticeAnalysisViewView createAlias(String alias) {
    return $PracticeAnalysisViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(practiceList)..addColumns($columns));
  @override
  Set<String> get readTables => const {'practice_infos'};
}

class ADTRequestViewData extends DataClass {
  final String id;
  final int bpm;
  final List<MusicEntry> musicEntries;
  final String? musicId;
  const ADTRequestViewData(
      {required this.id,
      required this.bpm,
      required this.musicEntries,
      this.musicId});
  factory ADTRequestViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ADTRequestViewData(
      id: serializer.fromJson<String>(json['id']),
      bpm: serializer.fromJson<int>(json['bpm']),
      musicEntries: serializer.fromJson<List<MusicEntry>>(json['musicEntries']),
      musicId: serializer.fromJson<String?>(json['musicId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bpm': serializer.toJson<int>(bpm),
      'musicEntries': serializer.toJson<List<MusicEntry>>(musicEntries),
      'musicId': serializer.toJson<String?>(musicId),
    };
  }

  ADTRequestViewData copyWith(
          {String? id,
          int? bpm,
          List<MusicEntry>? musicEntries,
          Value<String?> musicId = const Value.absent()}) =>
      ADTRequestViewData(
        id: id ?? this.id,
        bpm: bpm ?? this.bpm,
        musicEntries: musicEntries ?? this.musicEntries,
        musicId: musicId.present ? musicId.value : this.musicId,
      );
  @override
  String toString() {
    return (StringBuffer('ADTRequestViewData(')
          ..write('id: $id, ')
          ..write('bpm: $bpm, ')
          ..write('musicEntries: $musicEntries, ')
          ..write('musicId: $musicId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bpm, musicEntries, musicId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ADTRequestViewData &&
          other.id == this.id &&
          other.bpm == this.bpm &&
          other.musicEntries == this.musicEntries &&
          other.musicId == this.musicId);
}

class $ADTRequestViewView
    extends ViewInfo<$ADTRequestViewView, ADTRequestViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $ADTRequestViewView(this.attachedDatabase, [this._alias]);
  $PracticeInfosTable get practice =>
      attachedDatabase.practiceInfos.createAlias('t0');
  $ProjectInfosTable get project =>
      attachedDatabase.projectInfos.createAlias('t1');
  $MusicInfosTable get music => attachedDatabase.musicInfos.createAlias('t2');
  @override
  List<GeneratedColumn> get $columns => [id, bpm, musicEntries, musicId];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'a_d_t_request_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $ADTRequestViewView get asDslTable => this;
  @override
  ADTRequestViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ADTRequestViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bpm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bpm'])!,
      musicEntries: $MusicInfosTable.$convertermusicEntries.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}music_entries'])!),
      musicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_id']),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(practice.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<int> bpm = GeneratedColumn<int>(
      'bpm', aliasedName, false,
      generatedAs: GeneratedAs(practice.bpm, false), type: DriftSqlType.int);
  late final GeneratedColumnWithTypeConverter<List<MusicEntry>, String>
      musicEntries = GeneratedColumn<String>(
              'music_entries', aliasedName, false,
              generatedAs: GeneratedAs(music.musicEntries, false),
              type: DriftSqlType.string)
          .withConverter<List<MusicEntry>>(
              $MusicInfosTable.$convertermusicEntries);
  late final GeneratedColumn<String> musicId = GeneratedColumn<String>(
      'music_id', aliasedName, true,
      generatedAs: GeneratedAs(music.id, false), type: DriftSqlType.string);
  @override
  $ADTRequestViewView createAlias(String alias) {
    return $ADTRequestViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(practice)..addColumns($columns)).join([
        innerJoin(project, project.id.equalsExp(practice.projectId)),
        innerJoin(music, music.id.equalsExp(project.musicId))
      ]);
  @override
  Set<String> get readTables =>
      const {'practice_infos', 'project_infos', 'music_infos'};
}

class DrillMusicViewData extends DataClass {
  final String id;
  final String musicId;
  final String title;
  final Uint8List sheetImage;
  final List<Cursor> measureList;
  const DrillMusicViewData(
      {required this.id,
      required this.musicId,
      required this.title,
      required this.sheetImage,
      required this.measureList});
  factory DrillMusicViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrillMusicViewData(
      id: serializer.fromJson<String>(json['id']),
      musicId: serializer.fromJson<String>(json['musicId']),
      title: serializer.fromJson<String>(json['title']),
      sheetImage: serializer.fromJson<Uint8List>(json['sheetImage']),
      measureList: serializer.fromJson<List<Cursor>>(json['measureList']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'musicId': serializer.toJson<String>(musicId),
      'title': serializer.toJson<String>(title),
      'sheetImage': serializer.toJson<Uint8List>(sheetImage),
      'measureList': serializer.toJson<List<Cursor>>(measureList),
    };
  }

  DrillMusicViewData copyWith(
          {String? id,
          String? musicId,
          String? title,
          Uint8List? sheetImage,
          List<Cursor>? measureList}) =>
      DrillMusicViewData(
        id: id ?? this.id,
        musicId: musicId ?? this.musicId,
        title: title ?? this.title,
        sheetImage: sheetImage ?? this.sheetImage,
        measureList: measureList ?? this.measureList,
      );
  @override
  String toString() {
    return (StringBuffer('DrillMusicViewData(')
          ..write('id: $id, ')
          ..write('musicId: $musicId, ')
          ..write('title: $title, ')
          ..write('sheetImage: $sheetImage, ')
          ..write('measureList: $measureList')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, musicId, title, $driftBlobEquality.hash(sheetImage), measureList);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrillMusicViewData &&
          other.id == this.id &&
          other.musicId == this.musicId &&
          other.title == this.title &&
          $driftBlobEquality.equals(other.sheetImage, this.sheetImage) &&
          other.measureList == this.measureList);
}

class $DrillMusicViewView
    extends ViewInfo<$DrillMusicViewView, DrillMusicViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$AppDatabase attachedDatabase;
  $DrillMusicViewView(this.attachedDatabase, [this._alias]);
  $ProjectInfosTable get project =>
      attachedDatabase.projectInfos.createAlias('t0');
  $MusicInfosTable get music => attachedDatabase.musicInfos.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns =>
      [id, musicId, title, sheetImage, measureList];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'drill_music_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $DrillMusicViewView get asDslTable => this;
  @override
  DrillMusicViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrillMusicViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      musicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}music_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      sheetImage: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}sheet_image'])!,
      measureList: $MusicInfosTable.$convertermeasureList.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}measure_list'])!),
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      generatedAs: GeneratedAs(project.id, false), type: DriftSqlType.string);
  late final GeneratedColumn<String> musicId = GeneratedColumn<String>(
      'music_id', aliasedName, false,
      generatedAs: GeneratedAs(project.musicId, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      generatedAs: GeneratedAs(project.title, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<Uint8List> sheetImage = GeneratedColumn<Uint8List>(
      'sheet_image', aliasedName, false,
      generatedAs: GeneratedAs(music.sheetImage, false),
      type: DriftSqlType.blob);
  late final GeneratedColumnWithTypeConverter<List<Cursor>, String>
      measureList = GeneratedColumn<String>('measure_list', aliasedName, false,
              generatedAs: GeneratedAs(music.measureList, false),
              type: DriftSqlType.string)
          .withConverter<List<Cursor>>($MusicInfosTable.$convertermeasureList);
  @override
  $DrillMusicViewView createAlias(String alias) {
    return $DrillMusicViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(project)..addColumns($columns))
          .join([innerJoin(music, music.id.equalsExp(project.musicId))]);
  @override
  Set<String> get readTables => const {'project_infos', 'music_infos'};
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $MusicInfosTable musicInfos = $MusicInfosTable(this);
  late final $ProjectInfosTable projectInfos = $ProjectInfosTable(this);
  late final $PracticeInfosTable practiceInfos = $PracticeInfosTable(this);
  late final $DrillInfosTable drillInfos = $DrillInfosTable(this);
  late final $DrillReportInfosTable drillReportInfos =
      $DrillReportInfosTable(this);
  late final $MusicThumbnailViewView musicThumbnailView =
      $MusicThumbnailViewView(this);
  late final $ProjectDetailViewView projectDetailView =
      $ProjectDetailViewView(this);
  late final $ProjectSidebarViewView projectSidebarView =
      $ProjectSidebarViewView(this);
  late final $ProjectThumbnailViewView projectThumbnailView =
      $ProjectThumbnailViewView(this);
  late final $ProjectSummaryViewView projectSummaryView =
      $ProjectSummaryViewView(this);
  late final $PracticeReportViewView practiceReportView =
      $PracticeReportViewView(this);
  late final $PracticeListViewView practiceListView =
      $PracticeListViewView(this);
  late final $PracticeAnalysisViewView practiceAnalysisView =
      $PracticeAnalysisViewView(this);
  late final $ADTRequestViewView aDTRequestView = $ADTRequestViewView(this);
  late final $DrillMusicViewView drillMusicView = $DrillMusicViewView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        musicInfos,
        projectInfos,
        practiceInfos,
        drillInfos,
        drillReportInfos,
        musicThumbnailView,
        projectDetailView,
        projectSidebarView,
        projectThumbnailView,
        projectSummaryView,
        practiceReportView,
        practiceListView,
        practiceAnalysisView,
        aDTRequestView,
        drillMusicView
      ];
}
