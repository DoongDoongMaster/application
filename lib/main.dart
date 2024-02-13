import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/router.dart';
import 'package:application/sample_music.dart';
import 'package:application/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late final AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

// TODO: 우선 디버깅 용으로, 재 실행시 테스트 데이터 있는지 확인하고 넣도록 수정 필요함.

  for (var i = 0; i < 25; i++) {
    MusicInfo music = await database.into(database.musicInfos).insertReturning(
          MusicInfosCompanion.insert(
            title: '이름이 엄청나게 무지막지하게 굉장히 긴 악보 $i!!!!',
            bpm: 87,
            artist: '아티스트 $i',
            sheetSvg: (await rootBundle.load('assets/music/stay-with-me.svg'))
                .buffer
                .asUint8List(),
            cursorList: List<Cursors>.from(
                sheetInfo["cursorList"].map((v) => Cursors.fromJson(v))),
            measureList: List<Cursors>.from(
                sheetInfo["cursorList"].map((v) => Cursors.fromJson(v))),
            type: MusicType.ddm,
          ),
        );

    ProjectInfo project = await database
        .into(database.projectInfos)
        .insertReturning(ProjectInfosCompanion.insert(
            title: '이름이 무지막지 굉장히 매우 긴 프로젝트 $i', musicId: music.id));

    for (var j = 0; j < i; j++) {
      await database.into(database.practiceInfos).insert(
          PracticeInfosCompanion.insert(bpm: 100, projectId: project.id));
    }
  }

  database.select(database.projectThumbnailView).get();

  // final temp = await database.select(database.projectThumbnailView).get();
  // print(temp);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: ColorStyles.primary,
        // scaffoldBackgroundColor: ColorStyles.background,
        canvasColor: Colors.transparent,
        fontFamily: 'NanumBarunGothic',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
        ),
        colorScheme: const ColorScheme(
          primary: ColorStyles.primary,
          onPrimary: Colors.white,
          background: ColorStyles.background,
          onBackground: Colors.black,
          brightness: Brightness.light,
          secondary: ColorStyles.secondary,
          onSecondary: Colors.white,
          error: ColorStyles.primary,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          outlineVariant: Color(0xFFCAC4D0),
        ),
        iconTheme: const IconThemeData(color: ColorStyles.primary),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          foregroundColor: ColorStyles.primary,
        )),
        chipTheme: const ChipThemeData(
          selectedColor: ColorStyles.primary,
          side: BorderSide.none,
          showCheckmark: false,
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
        ),
        dialogBackgroundColor: Colors.transparent,
      ),
      color: ColorStyles.primary,
      routerConfig: goRouter,
      // home: const Scaffold(body: MusicListScreen()),
    );
  }
}
