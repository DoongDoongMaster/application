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
  for (var i = 0; i < 4; i++) {
    MusicInfo music = await database.into(database.musicInfos).insertReturning(
          MusicInfosCompanion.insert(
            title: const Value('Stay with me'),
            bpm: const Value(90),
            artist: const Value('자우림'),
            sheetSvg: Value(
                (await rootBundle.load('assets/music/stay-with-me.svg'))
                    .buffer
                    .asUint8List()),
            cursorList: Value(List<Cursors>.from(
                sheetInfo["cursorList"].map((v) => Cursors.fromJson(v)))),
            measureList: Value(List<Cursors>.from(
                    sheetInfo["cursorList"].map((v) => Cursors.fromJson(v)))
                .sublist(0, 20)),
            measureCount: const Value(50),
            // type: Value(MusicType.values[random.nextInt(2)]),
            type: const Value(MusicType.ddm),
            sourceCount: Value(
              {
                DrumComponent.hihat.name: random.nextInt(101),
                DrumComponent.snareDrum.name: random.nextInt(40),
                DrumComponent.smallTom.name: random.nextInt(20),
                DrumComponent.kick.name: random.nextInt(10),
                DrumComponent.total.name: random.nextInt(300) + 100,
                // DrumComponent.hihat.name: 104,
                // DrumComponent.snareDrum.name: 52,
                // DrumComponent.smallTom.name: 10,
                // DrumComponent.total.name: 346,
                // DrumComponent.kick.name: 80,
              },
            ),
          ),
        );

    final projectTitle = ["스테이윗미", "스테이윗미-다시", "한페이지", "항해"];

    ProjectInfo project = await database
        .into(database.projectInfos)
        .insertReturning(ProjectInfosCompanion.insert(
            title: projectTitle[i], musicId: music.id));

    // final scoreList = [48, 56, 57, 60, 65, 68, 77, 80, 82, 89];
    // final list1 = [150, 160, 170, 180, 190, 200, 250, 270, 300, 310];
    // final list2 = [10, 8, 6, 5, 4, 3, 1, 1, 0, 1];
    // final list3 = [40, 30, 20, 10, 15, 9, 9, 8, 8, 4];
    // final list4 = [20, 19, 17, 13, 10, 9, 4, 4, 2, 0];
    // final speedList = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2];

    // for (var j = 0; j < 10; j++) {
    //   await database.into(database.practiceInfos).insert(
    //         PracticeInfosCompanion.insert(
    //           createdAt: Value(
    //               DateTime.now().subtract(Duration(minutes: 2 * (10 - j)))),
    //           title: Value(DateTime.now()
    //               .subtract(Duration(minutes: 2 * (10 - j)))
    //               .toString()
    //               .replaceAll(RegExp(r':\d\d\.\d+'), '')
    //               .replaceAll('-', '.')),
    //           score: Value(scoreList[j]),
    //           isNew: Value(j > 8),
    //           // bpm: const Value(100),
    //           speed: Value([0.5, 0.75, 1.0, 1.25, 1.5][speedList[j]]),
    //           projectId: project.id,
    //           accuracyCount: Value({
    //             AccuracyType.correct.name: list1[j],
    //             AccuracyType.wrongComponent.name: list2[j],
    //             AccuracyType.wrongTiming.name: list3[j],
    //             AccuracyType.wrong.name: list4[j],
    //             AccuracyType.miss.name:
    //                 music.sourceCount[DrumComponent.total.name]! -
    //                     list1.last -
    //                     list2.last -
    //                     list3.last -
    //                     list4.last,
    //           }),
    //           componentCount: Value({
    //             for (var k in DrumComponent.values)
    //               k.name: music.sourceCount[k.name]! == 0
    //                   ? 0
    //                   : (music.sourceCount[k.name]! *
    //                           (0.6 + random.nextDouble() * 0.4))
    //                       .toInt(),
    //           }),
    //         ),
    //       );

    // await database.into(database.practiceInfos).insert(
    //       PracticeInfosCompanion.insert(
    //         score: const Value(null),
    //         isNew: const Value(false),
    //         // bpm: const Value(100),
    //         speed: const Value(1.0),
    //         projectId: project.id,
    //         accuracyCount: const Value.absent(),
    //         componentCount: const Value.absent(),
    //       ),
    //     );

    for (var j = 0; j < i; j++) {
      final isNull = random.nextBool();
      await database.into(database.practiceInfos).insert(
            PracticeInfosCompanion.insert(
              score: isNull ? const Value(null) : Value(random.nextInt(101)),
              isNew: isNull ? const Value(false) : Value(random.nextBool()),
              // bpm: const Value(100),
              speed: Value([0.5, 0.75, 1.0, 1.25, 1.5][random.nextInt(5)]),
              projectId: project.id,
              accuracyCount: isNull
                  ? const Value.absent()
                  : Value({
                      AccuracyType.correct.name: random.nextInt(
                          music.sourceCount[DrumComponent.total.name]!),
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
            ),
          );
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
          secondary: ColorStyles.background,
          onSecondary: Colors.black,
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
