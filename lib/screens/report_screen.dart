import 'dart:typed_data';

import 'package:application/main.dart';
import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/widgets/report/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatelessWidget {
  static const double headerHeight = 312;
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: context.canPop()
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
      body: FutureBuilder<PracticeReportViewData>(
        future: database.getPracticeReport(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: headerHeight,
                color: ColorStyles.background,
                child: ReportHeader(
                  snapshot.hasData
                      ? snapshot.data!
                      : PracticeReportViewData(
                          id: "",
                          musicTitle: "",
                          musicArtist: "",
                          accuracyCount: {
                            for (var k in AccuracyType.values) k.name: 0
                          },
                          componentCount: {
                            for (var k in DrumComponent.values) k.name: 0
                          },
                          sourceCount: {
                            for (var k in DrumComponent.values) k.name: 0
                          },
                          score: 0,
                          bestScore: 0,
                          sourceBPM: 0,
                          bpm: 0,
                          sheetSvg: Uint8List(0),
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - headerHeight,
                child: OverflowBox(
                  maxHeight: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: headerHeight),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [ShadowStyles.shadow200],
                          ),
                          child: snapshot.hasData
                              ? Stack(
                                  children: [
                                    Center(
                                      child: SvgPicture.memory(
                                        snapshot.data!.sheetSvg,
                                        width: 1024,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        headerHeight,
                                    child: const UnconstrainedBox(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
