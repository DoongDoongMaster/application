import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:application/models/adt_result_model.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/music_infos.dart';
import 'package:application/models/entity/practice_infos.dart';
import 'package:application/models/entity/project_infos.dart';
import 'package:application/router.dart';
import 'package:application/sample_music.dart';
import 'package:application/services/local_storage.dart';
import 'package:application/services/osmd_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late final AppDatabase database;

insertDummyData() async {
// TODO: 우선 디버깅 용으로, 재 실행시 테스트 데이터 있는지 확인하고 넣도록 수정 필요함.
  Random random = Random();
  for (var i = 0; i < 4; i++) {
    MusicInfo music = await database.into(database.musicInfos).insertReturning(
          MusicInfosCompanion.insert(
            title: const Value('Stay with me'),
            bpm: const Value(90),
            artist: const Value('자우림'),
            sheetImage: Value(
                (await rootBundle.load('assets/music/stay-with-me.png'))
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
            sourceCount: Value(ComponentCount(
              hihat: random.nextInt(101),
              snareDrum: random.nextInt(40),
              smallTom: random.nextInt(20),
              kick: random.nextInt(10),
              total: random.nextInt(300) + 100,
              // DrumComponent.hihat.name: 104,
              // DrumComponent.snareDrum.name: 52,
              // DrumComponent.smallTom.name: 10,
              // DrumComponent.total.name: 346,
              // DrumComponent.kick.name: 80,
            )),
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

    // for (var j = 0; j < i; j++) {
    //   final isNull = random.nextBool();
    //   await database.into(database.practiceInfos).insert(
    //         PracticeInfosCompanion.insert(
    //           score: isNull ? const Value(null) : Value(random.nextInt(101)),
    //           isNew: isNull ? const Value(false) : Value(random.nextBool()),
    //           // bpm: const Value(100),
    //           speed: Value([0.5, 0.75, 1.0, 1.25, 1.5][random.nextInt(5)]),
    //           projectId: project.id,
    //           accuracyCount: isNull
    //               ? const Value.absent()
    //               : Value(AccuracyCount(
    //                   correct: random.nextInt(music.sourceCount!.total),
    //                   wrongComponent: random.nextInt(50),
    //                   wrongTiming: random.nextInt(60),
    //                   wrong: random.nextInt(20),
    //                   miss: random.nextInt(10),
    //                 )),
    //           componentCount: isNull
    //               ? const Value.absent()
    //               : Value(ComponentCount.fromJson({
    //                   for (var k in DrumComponent.values)
    //                     k.name: music.sourceCount!.getByType(k) == 0
    //                         ? 0
    //                         : random.nextInt(music.sourceCount!.getByType(k))
    //                 })),
    //         ),
    //       );
    // }
  }

  // final tempId =
  //     await (database.select(database.practiceInfos)..limit(1)).getSingle();
  // final temp = await database.getPracticeReport(tempId.id);
  // print(temp);
}

fixData() async {
  List<MusicInfo> musics = await database.musicInfos.select().get();
  var i = 1;
  for (var m in musics) {
    OSMDService osmd = OSMDService(callback: (base64Image, json) {
      var temp = MusicInfo.fromJson(
        title: m.title,
        json: json!,
        base64String: base64Image,
        xmlData: m.xmlData,
      );

      // (database.update(database.musicInfos)
      //       ..where((tbl) => tbl.id.equals(m.id)))
      //     .write(MusicInfosCompanion(
      //   cursorList: Value(temp.cursorList),
      //   hitCount: Value(temp.hitCount),
      //   sheetImage: Value(temp.sheetImage!),
      //   measureCount: Value(temp.measureCount),
      //   measureList: Value(temp.measureList),
      //   musicEntries: Value(temp.musicEntries),
      //   sourceCount: Value(temp.sourceCount!),
      // ));
    });

    osmd.run(xmlData: m.xmlData!);

    break;
    await Future.delayed(const Duration(seconds: 10));
    print("$i / ${musics.length}. ${m.id}: ${m.title}, DONE");
    i++;
  }
}

removeUnusedMusic() async {
  List<MusicInfo> musics = await database.musicInfos.select().get();
  for (var m in musics) {
    var result = await (database.select(database.projectInfos)
          ..where((tbl) => tbl.musicId.equals(m.id)))
        .get();
    if (result.isEmpty) {
      await database.musicInfos.deleteWhere((tbl) => tbl.id.equals(m.id));
    }
  }
}

changeMusicType() async {
  // List<MusicInfo> musics = await (database.musicInfos.select()
  //       ..where((tbl) => tbl.type.equalsValue(MusicType.ddm)))
  //     .get();
  // var i = 1;
  // for (var m in musics) {
  //   (database.update(database.musicInfos)..where((tbl) => tbl.id.equals(m.id)))
  //       .write(MusicInfosCompanion(title: Value("루디먼트 ${i++}")));
  // }

  (database.update(
    database.musicInfos,
  )..where((tbl) => tbl.type.equalsValue(MusicType.ddm)))
      .write(const MusicInfosCompanion(artist: Value('DDM')));
}

/// 이걸로 다시 계산하기
reCaculatePractice() async {
  List<MusicInfo> musics = await database.musicInfos.select().get();
  for (var m in musics) {
    List<ProjectInfo> projects = await (database.projectInfos.select()
          ..where((tbl) => tbl.musicId.equals(m.id)))
        .get();

    for (var proj in projects) {
      List<PracticeInfo> practices = await (database.practiceInfos.select()
            ..where((tbl) => tbl.projectId.equals(proj.id)))
          .get();

      for (var prac in practices) {
        if (prac.transcription == null || prac.transcription!.isEmpty) continue;
        var currentBPM = (prac.speed! * m.bpm).toInt();
        var updated = ADTResultModel(transcription: prac.transcription!);

        await updated.calculateWithAnswer(m.musicEntries, currentBPM);
        print("${prac.title} ${updated.result.length}");
        try {
          await (database.update(database.practiceInfos)
                ..where((tbl) => tbl.id.equals(prac.id)))
              .writeReturning(PracticeInfosCompanion(
                accuracyCount: Value(updated.accuracyCount),
                componentCount: Value(updated.componentCount),
                score: Value(updated.score),
                result: Value(updated.result),
                bpm: Value(currentBPM),
              ))
              .then((value) => print(value.first.result?.length));
        } catch (e) {
          print(e);
        }
      }
    }
  }
}

makeBackUpData() async {
  print("start backup....");
  var root = await LocalStorage.getLocalPath();
  var backupPath = "$root/backup";

  List<MusicInfo> musics = await database.musicInfos.select().get();
  for (var m in musics) {
    print("music: ${m.id}");
    List<ProjectInfo> projects = await (database.projectInfos.select()
          ..where((tbl) => tbl.musicId.equals(m.id)))
        .get();

    for (var proj in projects) {
      print("project: ${proj.id}");
      List<PracticeInfo> practices = await (database.practiceInfos.select()
            ..where((tbl) => tbl.projectId.equals(proj.id)))
          .get();

      for (var prac in practices) {
        print("practice: ${prac.id}");
        if (prac.score == null ||
            prac.transcription == null ||
            prac.transcription!.isEmpty) continue;

        var newDir = "$backupPath/${prac.id}";
        // await Directory(newDir).create(recursive: true);
        // 1. wav 파일 가져오기
        // File("$root/${prac.id}.wav").copySync("$newDir/${prac.id}.wav");
        // 2.json 파일 만들기

        /// 3, 이미지 파일 생성
        var osmd = OSMDService(
          callback: (base64Image, json) {
            // 이미지 파일 저장
            File("$newDir/sheet.png")
                .writeAsBytesSync(base64Decode(base64Image));
          },
        );

        osmd.run(xmlData: m.xmlData!, transcription: prac.result);
        await Future.delayed(const Duration(seconds: 4));
      }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();
  // await insertDummyData();
  // await fixData();
  // await removeUnusedMusic();
  // await changeMusicType();
  // await reCaculatePractice();
  // await makeBackUpData();
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
    );
  }
}
