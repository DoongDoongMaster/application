import 'package:application/models/entity/music_infos.dart';
import 'package:drift/drift.dart';

abstract class MusicThumbnailView extends View {
  MusicInfos get musicInfos;

  @override
  Query as() => select([
        musicInfos.id,
        musicInfos.type,
        musicInfos.title,
        musicInfos.artist,
        musicInfos.sheetImage,
        musicInfos.createdAt,
      ]).from(musicInfos);
}
