import 'dart:typed_data';

import 'package:application/main.dart';
import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/widgets/report/report_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatelessWidget {
  static const double headerHeight = 312;
  final String? practiceId;
  const ReportScreen({super.key, required this.practiceId});

  @override
  Widget build(BuildContext context) {
    if (practiceId == null) {
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
      body: FutureBuilder<List<PracticeReportViewData>>(
        future: database.getPracticeReport(practiceId!),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            Future.microtask(() => context.pop());
          } else if (snapshot.hasData && snapshot.data![0].isNew) {
            database.readPracticeReport(practiceId!);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: headerHeight,
                color: ColorStyles.background,
                child: ReportHeader(
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ? snapshot.data![0]
                      : PracticeReportViewData(
                          id: "",
                          musicTitle: "",
                          musicArtist: "",
                          isNew: false,
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
                          sheetImage: Uint8List(0),
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
                          child: snapshot.hasData && snapshot.data!.isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Center(
                                    child: Image.memory(
                                      snapshot.data![0].sheetImage,
                                      width: 1024,
                                    ),
                                  ),
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
