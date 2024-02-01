import 'package:application/main.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/widgets/home/add_new_button.dart';
import 'package:application/widgets/home/navigation_panel.dart';
import 'package:application/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MusicListScreen extends StatefulWidget {
  const MusicListScreen({super.key});

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const NavigationPanel(currentPath: RouterPath.musicList),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(label: '악보 목록'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "연습하고 싶은 악보를 선택하거나, 추가하세요.",
                      style: TextStyles.bodysmall.copyWith(
                        color: ColorStyles.onSurfaceBlackVariant,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  const TopMusicPreview(
                    musicType: MusicType.ddm,
                    label: '기본 악보',
                  ),
                  const TopMusicPreview(
                    musicType: MusicType.user,
                    label: '나의 악보',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
      onPressed: () {},
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
            child: SvgPicture.memory(
              music.sheetSvg,
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          Text(
            music.title,
            style: TextStyles.bodyMedium.copyWith(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Text(
            music.artist,
            style: TextStyles.bodysmall.copyWith(
              color: const Color(0xFF9F9F9F),
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          const Spacer(),
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
class TopMusicPreview extends StatelessWidget {
  /// 미리보기 개수
  static const int _previewCount = 5;
  final MusicType musicType;
  final String label;

  const TopMusicPreview({
    super.key,
    required this.musicType,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubClassLabelWithArrow(label: label, onPressed: () {}),
          FutureBuilder<List<MusicThumbnailViewData>>(
            future: database.getTopMusicsByType(musicType,
                musicType == MusicType.ddm ? _previewCount : _previewCount - 1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> gridList = [
                  if (musicType == MusicType.user)
                    AddNewButton(
                      label: '악보 추가',
                      size: MusicPreview.size,
                      onPressed: () {},
                    ),
                  ...snapshot.data!.map((data) => MusicPreview(music: data))
                ];

                for (var i = gridList.length; i < _previewCount; i++) {
                  gridList.add(const Spacer());
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

/// 현재 미사용.
// class BackButtonWithText extends StatelessWidget {
//   const BackButtonWithText({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => context.pop(),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.arrow_back_ios_rounded,
//               size: 24,
//             ),
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//             style: const ButtonStyle(
//                 tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//           ),
//           const SizedBox(width: 4),
//           Text("연습장",
//               style: TextStyles.bodyMedium.copyWith(color: ColorStyles.primary))
//         ],
//       ),
//     );
//   }
// }
