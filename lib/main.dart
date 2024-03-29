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
            title: Value('악보 $i'),
            bpm: const Value(90),
            artist: Value('아티스트 $i'),
            sheetSvg: Value(
                (await rootBundle.load('assets/music/stay-with-me.svg'))
                    .buffer
                    .asUint8List()),
            cursorList: Value(List<Cursors>.from(
                    sheetInfo["cursorList"].map((v) => Cursors.fromJson(v)))
                .sublist(0, 10)),
            measureList: Value(List<Cursors>.from(
                    sheetInfo["cursorList"].map((v) => Cursors.fromJson(v)))
                .sublist(0, 3)),
            measureCount: const Value(3),
            type: Value(MusicType.values[random.nextInt(2)]),
            sourceCount: Value(
              {
                DrumComponent.hihat.name: random.nextInt(101),
                DrumComponent.snareDrum.name: random.nextInt(40),
                DrumComponent.smallTom.name: random.nextInt(20),
                DrumComponent.kick.name: random.nextInt(10),
                DrumComponent.total.name: random.nextInt(300) + 100,
              },
            ),
          ),
        );

    ProjectInfo project = await database
        .into(database.projectInfos)
        .insertReturning(
            ProjectInfosCompanion.insert(title: '프로젝트 $i', musicId: music.id));

    for (var j = 0; j < i; j++) {
      final isNull = random.nextBool();
      await database
          .into(database.practiceInfos)
          .insert(PracticeInfosCompanion.insert(
            score: isNull ? const Value(null) : Value(random.nextInt(101)),
            isNew: isNull ? const Value(false) : Value(random.nextBool()),
            // bpm: const Value(100),
            speed: Value([0.5, 0.75, 1.0, 1.25, 1.5][random.nextInt(5)]),
            projectId: project.id,
            accuracyCount: isNull
                ? const Value.absent()
                : Value({
                    AccuracyType.correct.name: random
                        .nextInt(music.sourceCount[DrumComponent.total.name]!),
                    AccuracyType.wrongComponent.name: random.nextInt(50),
                    AccuracyType.wrongTiming.name: random.nextInt(60),
                    AccuracyType.wrong.name: random.nextInt(20),
                    AccuracyType.miss.name: random.nextInt(10),
                  }),
            componentCount: isNull
                ? const Value.absent()
                : Value({
                    for (var k in DrumComponent.values)
                      k.name: music.sourceCount[k.name]! == 0
                          ? 0
                          : random.nextInt(music.sourceCount[k.name]!)
                  }),
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
          ),
        ),
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
          visualDensity: const VisualDensity(vertical: -3, horizontal: 3),
          dense: true,
          minLeadingWidth: 150,
          leadingAndTrailingTextStyle: TextStyles.bodyMedium.copyWith(
            color: Colors.black,
          ),
          iconColor: Colors.black,
        ),
        popupMenuTheme: PopupMenuThemeData(
          position: PopupMenuPosition.under,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      color: ColorStyles.primary,
      routerConfig: goRouter,
      // home: const Scaffold(body: MusicListScreen()),
    );
  }
}
