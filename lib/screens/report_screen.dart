import 'dart:convert';

import 'package:application/main.dart';
import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/services/osmd_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/widgets/music_sheet_viewer_widget.dart';
import 'package:application/widgets/report/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatefulWidget {
  static const double headerHeight = 312;
  final String? practiceId;
  const ReportScreen({super.key, required this.practiceId});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  PracticeReportViewData _practiceReportViewData = PracticeReportViewData(
    id: "",
    musicTitle: "",
    musicArtist: "",
    isNew: false,
    accuracyCount: AccuracyCount(),
    componentCount: ComponentCount(),
    sourceCount: ComponentCount(),
    score: 0,
    bestScore: 0,
    sourceBPM: 0,
    bpm: 0,
    xmlData: Uint8List(0),
    result: [],
    hitCount: 0,
    measureList: [],
  );
  Uint8List? markedImage;
  @override
  void initState() {
    super.initState();
    getPracticeReport();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPracticeReport() async {
    var practice = await database.getPracticeReport(widget.practiceId!);
    if (practice == null) {
      Future.microtask(() => context.pop());
      return;
    }

    // 처음 읽는 레포트의 경우 읽기 처리.
    if (practice.isNew) {
      database.readPracticeReport(practice.id);
    }

    // // HACK: 여기서부터 다시 계산!!!!!
    // await Future.wait([
    //   (database.practiceInfos.select()
    //         ..where((tbl) => tbl.id.equals(widget.practiceId!)))
    //       .getSingle(),
    //   (database.musicInfos.select()
    //         ..where((tbl) => tbl.id.equals(practice!.musicId!)))
    //       .getSingle()
    // ]).then((value) {
    //   var newResult = ADTResultModel(
    //       transcription: (value[0] as PracticeInfo).transcription!);
    //   newResult.calculateWithAnswer((value[1] as MusicInfo).musicEntries,
    //       (value[0] as PracticeInfo).bpm!);
    //   practice = practice!.copyWith(
    //     score: drift.Value(newResult.score),
    //     accuracyCount: drift.Value(newResult.accuracyCount),
    //     componentCount: drift.Value(newResult.componentCount),
    //     result: drift.Value(newResult.result),
    //   );
    // });
    // // HACK: 여기서부터 다시 계산!!!!!

    setState(() {
      _practiceReportViewData = practice;
    });

    // OSMD - 악보에 답 표기
    OSMDService osmd = OSMDService(
      callback: (base64Image, json) {
        setState(() {
          markedImage = base64Decode(base64Image);
        });
      },
    );

    osmd.run(
      xmlData: practice.xmlData,
      transcription: practice.result,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.practiceId == null) {
      Future.microtask(() => context.pop());
    }
    return Scaffold(
      floatingActionButton: !context.canPop()
          ? TextButton(
              onPressed: () {}, // TODO: 다시 시작 버튼 로직 구현
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1C1C25),
                shadowColor: ShadowStyles.shadow300.color,
                elevation: 8,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.replay_rounded, size: 24),
                  SizedBox(width: 4),
                  Text("다시 시작"),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: ReportScreen.headerHeight,
            color: ColorStyles.background,
            child: ReportHeader(_practiceReportViewData),
          ),
          SizedBox(
            height:
                MediaQuery.of(context).size.height - ReportScreen.headerHeight,
            child: OverflowBox(
              maxHeight: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: ReportScreen.headerHeight),
                    MusicSheetBox(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height -
                              ReportScreen.headerHeight,
                        ),
                        alignment: markedImage != null
                            ? Alignment.topCenter
                            : Alignment.center,
                        child: markedImage != null
                            ? MusicSheetWidget(image: markedImage!)
                            : const CircularProgressIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
