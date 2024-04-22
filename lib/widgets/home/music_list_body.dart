import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/home/add_new_button.dart';
import 'package:application/widgets/home/add_new_modal.dart';
import 'package:application/widgets/home/n_column_grid_view.dart';
import 'package:application/widgets/home/home_header.dart';
import 'package:application/widgets/no_content_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:drift/drift.dart' as drift;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MusicListBody extends StatefulWidget {
  static const colCount = 5;

  const MusicListBody({super.key});

  @override
  State<MusicListBody> createState() => _MusicListBodyState();
}

class _MusicListBodyState extends State<MusicListBody> {
  MusicType? selectedType;

  changeType(MusicType type) {
    setState(() {
      selectedType = type;
    });
  }

  closeMusicList() {
    setState(() {
      selectedType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          if (selectedType == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(label: '악보 목록'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "연습하고 싶은 악보를 선택하거나, 추가하세요.",
                    style: TextStyles.bodyMedium.copyWith(
                      color: ColorStyles.onSurfaceBlackVariant,
                      letterSpacing: 0.25,
                    ),
                  ),
                ),
                _TopMusicPreview(
                  musicType: MusicType.ddm,
                  label: '기본 악보',
                  onPressed: () => changeType(MusicType.ddm),
                ),
                _TopMusicPreview(
                  musicType: MusicType.user,
                  label: '나의 악보',
                  onPressed: () => changeType(MusicType.user),
                ),
              ],
            )
          else
            MusicListDetail(
              filter: selectedType,
              closeList: closeMusicList,
            )
        ],
      ),
    );
  }
}

class MusicListDetail extends StatelessWidget {
  static const colCount = 5;
  final MusicType? filter;
  final void Function() closeList;

  const MusicListDetail({super.key, this.filter, required this.closeList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: closeList,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24,
                  color: ColorStyles.primary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: const VisualDensity(horizontal: -4),
              ),
              Text(
                filter == MusicType.ddm ? '기본 악보' : '나의 악보',
                style: TextStyles.bodyLarge,
              ),
              const SizedBox(width: 32),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<MusicThumbnailViewData>>(
            future: (database.select(database.musicThumbnailView)
                  ..orderBy([
                    (u) => drift.OrderingTerm.desc(
                        database.musicThumbnailView.createdAt)
                  ]))
                .get(),
            builder: (context, snapshot) {
              List<Widget> gridList = [
                if (filter == MusicType.user)
                  const UnconstrainedBox(
                    child: _AddNewMusicButton(),
                  ),
                if (snapshot.hasData)
                  ...snapshot.data!.where((tbl) => tbl.type == filter).map(
                      (data) =>
                          UnconstrainedBox(child: MusicPreview(music: data))),
              ];

              if (gridList.length <= 1) {
                return Column(
                  children: [
                    NColumnGridView(
                      colCount: colCount,
                      gridList: gridList,
                    ),
                    const SizedBox(height: 20),
                    const NoContentWidget(
                      title: "나의 악보가 비어 있음",
                      subTitle: "새로운 악보를 추가하세요.",
                    ),
                  ],
                );
              }

              return NColumnGridView(
                colCount: colCount,
                gridList: gridList,
                spacing: 20,
              );
            },
          ),
        )
      ],
    );
  }
}

/// 악보 미리보기 타일
class MusicPreview extends StatelessWidget {
  /// 미리보기 크기
  static const Size size = Size(128, 154);

  final MusicThumbnailViewData music;
  const MusicPreview({
    super.key,
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
          context: context,
          builder: (context) => NewProjectModal(music: music)),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(2),
        fixedSize: size,
        backgroundColor: Colors.white,
        shadowColor: ColorStyles.blackShadow16,
        elevation: 8,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: size.width,
            child: Image.memory(
              music.sheetImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 28,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AutoSizeText(
                      music.title,
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: AutoSizeText(
                      music.artist,
                      style: TextStyles.bodysmall.copyWith(
                        color: ColorStyles.darkGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 악보 분류 라벨 및 바로가기
class SubClassLabelWithArrow extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const SubClassLabelWithArrow({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16)
        ],
      ),
    );
  }
}

/// 해당 type의 상단 n(5)개의 악보 미리보기 타일을 한 줄로 배치.
class _TopMusicPreview extends StatelessWidget {
  final MusicType musicType;
  final String label;
  final void Function() onPressed;

  const _TopMusicPreview({
    required this.musicType,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubClassLabelWithArrow(
            label: label,
            onPressed: onPressed,
          ),
          FutureBuilder<List<MusicThumbnailViewData>>(
            future: database.getTopMusicsByType(
                musicType,
                musicType == MusicType.ddm
                    ? MusicListBody.colCount
                    : MusicListBody.colCount - 1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> gridList = [
                  if (musicType == MusicType.user) const _AddNewMusicButton(),
                  ...snapshot.data!.map((data) => MusicPreview(music: data))
                ];

                for (var i = gridList.length; i < MusicListBody.colCount; i++) {
                  gridList.add(SizedBox.fromSize(size: MusicPreview.size));
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: gridList,
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AddNewMusicButton extends StatelessWidget {
  const _AddNewMusicButton();

  @override
  Widget build(BuildContext context) {
    return AddNewButton(
      label: '악보 추가',
      size: MusicPreview.size,
      onPressed: () {
        // 파일 선택기 - 파일 경로 및 확장자 뗀 파일명 확보
        FilePicker.platform
            .pickFiles(type: FileType.any, withData: false)
            .then((result) {
          if (result == null) {
            return;
          }
          // 파일 경로
          String filePath = result.files.single.path!;
          RegExp regex = RegExp(r'^(.+?)(\..+)?$');
          String title =
              regex.firstMatch(result.files.single.name)?.group(1) ?? "";

          context.pushNamed(RouterPath.newMusic.name, queryParameters: {
            "fileName": title,
            "filePath": filePath,
          });
        });
      },
    );
  }
}
