import 'dart:math';

import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/router.dart';
import 'package:application/sample_music.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/time_utils.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late final AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

// TODO: 우선 디버깅 용으로, 재 실행시 테스트 데이터 있는지 확인하고 넣도록 수정 필요함.
  Random random = Random();
  for (var i = 0; i < 25; i++) {
    MusicInfo music = await database.into(database.musicInfos).insertReturning(
          MusicInfosCompanion.insert(
              title: '이름이 엄청나게 무지막지하게 굉장히 긴 악보 $i!!!!',
              bpm: 240,
              artist: '아티스트 $i',
              sheetSvg: (await rootBundle.load('assets/music/stay-with-me.svg'))
                  .buffer
                  .asUint8List(),
              cursorList: List<Cursors>.from(
                  sheetInfo["cursorList"].map((v) => Cursors.fromJson(v))),
              measureList: List<Cursors>.from(
                      sheetInfo["cursorList"].map((v) => Cursors.fromJson(v)))
                  .sublist(0, 10),
              type: MusicType.ddm,
              lengthInSec: TimeUtils.getTotalDurationInSec(
                240,
                10,
              ),
              sourceCount: {
                DrumComponent.hihat.name: 100,
                DrumComponent.snareDrum.name: 10,
                DrumComponent.smallTom.name: 0,
                DrumComponent.kick.name: 30,
                DrumComponent.total.name: 300,
              }),
        );

    ProjectInfo project = await database
        .into(database.projectInfos)
        .insertReturning(ProjectInfosCompanion.insert(
            title: '이름이 무지막지 굉장히 매우 긴 프로젝트 $i', musicId: music.id));

    for (var j = 0; j < i; j++) {
      var score = random.nextInt(101);
      await database
          .into(database.practiceInfos)
          .insert(PracticeInfosCompanion.insert(
            score: Value(score),
            // bpm: const Value(100),
            speed: const Value(0.75),
            projectId: project.id,
            accuracyCount: {
              AccuracyType.correct.name: 186,
              AccuracyType.wrongComponent.name: 56,
              AccuracyType.wrongTiming.name: 48,
              AccuracyType.wrong.name: 20,
              AccuracyType.miss.name: 16,
            },
            componentCount: {
              DrumComponent.hihat.name: 80,
              DrumComponent.snareDrum.name: 9,
              DrumComponent.smallTom.name: 0,
              DrumComponent.kick.name: 5
            },
          ));
    }
  }

  // final tempId =
  //     await (database.select(database.practiceInfos)..limit(1)).getSingle();
  // final temp = await database.getPracticeReport(tempId.id);
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
          listTileTheme: ListTileThemeData(
            visualDensity: const VisualDensity(vertical: -3),
            dense: true,
            minLeadingWidth: 200,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leadingAndTrailingTextStyle: TextStyles.bodyMedium.copyWith(
              color: Colors.black,
            ),
            iconColor: Colors.black,
          ),
          popupMenuTheme: PopupMenuThemeData(
            position: PopupMenuPosition.under,
            surfaceTintColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          )),
      color: ColorStyles.primary,
      routerConfig: goRouter,
      // home: const Scaffold(body: MusicListScreen()),
    );
  }
}
