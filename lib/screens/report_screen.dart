import 'dart:convert';
import 'dart:math';

import 'package:application/main.dart';
import 'package:application/models/convertors/accuracy_count_convertor.dart';
import 'package:application/models/convertors/component_count_convertor.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/convertors/scored_entry_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/services/osmd_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:application/time_utils.dart';
import 'package:application/widgets/custom_dialog.dart';
import 'package:application/widgets/modal_widget.dart';
import 'package:application/widgets/music_sheet_viewer_widget.dart';
import 'package:application/widgets/report/report_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as imglib;

class ReportScreen extends StatefulWidget {
  static const double headerHeight = 312;
  final String? practiceId;
  const ReportScreen({super.key, required this.practiceId});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  PracticeReportViewData _data = PracticeReportViewData(
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
  late double _secPerMeasure;
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
      _data = practice;
      _secPerMeasure = 4 * TimeUtils.getSecPerBeat(practice.bpm!);
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
            child: ReportHeader(_data),
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
                            ? SizedBox(
                                width: 1024,
                                child: Stack(
                                  children: [
                                    MusicSheetWidget(image: markedImage!),
                                    for (var i = 0;
                                        i < _data.measureList.length;
                                        i++)
                                      _createMeasureViewButton(i)
                                  ],
                                ),
                              )
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

  _createMeasureViewButton(int idx) {
    var curr = _data.measureList[idx];
    var ts1 = (curr.ts - 0.25) * _secPerMeasure;
    var ts2 = (curr.ts + 1.25) * _secPerMeasure;
    return _MeasureViewButton(
      markedImage: markedImage,
      ts1: ts1,
      ts2: ts2,
      curr: curr,
      prev: idx == 0 ? null : _data.measureList[idx - 1],
      next: idx == _data.measureList.length - 1
          ? null
          : _data.measureList[idx + 1],
      notes: _data.result!.where((e) => e.ts > ts1 && e.ts < ts2).toList(),
    );
  }
}

// 마디 위 투명 버튼
class _MeasureViewButton extends StatelessWidget {
  const _MeasureViewButton({
    required this.markedImage,
    required this.ts1,
    required this.ts2,
    required this.notes,
    required this.curr,
    this.prev,
    this.next,
  });

  final Uint8List? markedImage;
  final double ts1, ts2;
  final Cursors curr;
  final Cursors? prev, next;
  final List<ScoredEntry> notes;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: curr.x + 1,
      top: curr.y,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return _MeasureViewModal(
                markedImage: markedImage!,
                curr: curr,
                prev: prev,
                next: next,
                notes: notes,
                ts1: ts1,
                ts2: ts2,
              );
            },
          );
        },
        child: SizedBox(
          width: curr.w - 2,
          height: curr.h,
        ),
      ),
    );
  }
}

// 마디 자세히보기 모달 창
class _MeasureViewModal extends StatelessWidget {
  const _MeasureViewModal({
    required this.markedImage,
    required this.curr,
    required this.notes,
    required this.ts1,
    required this.ts2,
    this.prev,
    this.next,
  });

  final Uint8List markedImage;
  final Cursors curr;
  final Cursors? prev, next;
  final List<ScoredEntry> notes;
  final double ts1, ts2;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      width: 700,
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ModalHeader(
            title: "자세히 보기",
            left: "",
            right: "닫기",
            onComplete: () => context.pop(),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prev != null)
                _CroppedMeasureImage(
                  image: markedImage,
                  x: prev!.x + prev!.w * 3 / 4,
                  y: prev!.y,
                  w: prev!.w / 4,
                  h: prev!.h,
                  isBlur: true,
                ),
              _CroppedMeasureImage(
                image: markedImage,
                x: curr.x,
                y: curr.y,
                w: curr.w + 1,
                h: curr.h,
              ),
              if (next != null)
                _CroppedMeasureImage(
                  image: markedImage,
                  x: next!.x + 1,
                  y: next!.y,
                  w: next!.w / 4,
                  h: next!.h,
                  isBlur: true,
                ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(height: 0),
          Expanded(
            child: Container(
              color: ColorStyles.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("나의 연주 기록",
                      style:
                          TextStyles.bodyMedium.copyWith(letterSpacing: 1.25)),
                  CustomPaint(
                    painter:
                        _ScoredMeasurePaint(notes: notes, ts1: ts1, ts2: ts2),
                    size: const Size(630, 150),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// 마디 단위로 악보 자르기
class _CroppedMeasureImage extends Image {
  _CroppedMeasureImage({
    required Uint8List image,
    required double x,
    required double y,
    required double w,
    required double h,
    bool isBlur = false,
  }) : super.memory(
          imglib.encodePng(
            imglib.copyCrop(
              imglib.decodeImage(image)!,
              x: (x * 2).toInt(),
              y: ((y - (100 - h)) * 2).toInt(),
              width: (w * 2).toInt(),
              height: 100 * 2,
              antialias: true,
            ),
          ),
          fit: BoxFit.contain,
          height: 100,
          color: isBlur ? Colors.transparent.withOpacity(0.4) : null,
        );
}

/// 사용자 연주 기록 시각화
class _ScoredMeasurePaint extends CustomPainter {
  static const double width = 630;
  static const double lineHeight = 20;
  static const double labelHeight = lineHeight - 2;
  static const double labelWidth = 60;

  static const double lineStart = labelWidth + 15;
  static const double lineEnd = width;
  static const double cellWidth = (lineEnd - lineStart) / 6; // 전체 6마디

  static const double noteHeadWidth = labelHeight * 1.2;
  static const double noteHeadHeight = labelHeight;

  static double pitchToPosY(pitch) => lineHeight * (pitch == -1 ? 6 : pitch);

  List<ScoredEntry> notes;
  double ts1, ts2;

  _ScoredMeasurePaint({
    required this.notes,
    required this.ts1,
    required this.ts2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = ColorStyles.panelCard;
    // 배경 + 기본 선 그리기
    _paintBackground(canvas, paint, 0, lineHeight * 4);
    _paintBackground(canvas, paint, lineHeight * 6, lineHeight);

    _drawVerticalLine(canvas, paint, 0, lineHeight * 4);
    _drawVerticalLine(canvas, paint, lineHeight * 6, lineHeight);

    for (var i = 1; i <= 3; i++) {
      canvas.drawLine(
        Offset(lineStart, i * lineHeight),
        Offset(lineEnd, i * lineHeight),
        paint,
      );
    }

    for (var drum in DrumComponent.values) {
      _drawLabel(canvas, paint, drum.label, pitchToPosY(drum.adtKey));
    }

    // 사용자 연주 그리기
    for (var note in notes) {
      var top = pitchToPosY(note.pitch) + 1;
      var x = (note.ts - ts1) / (ts2 - ts1) * (lineEnd - lineStart) + lineStart;
      if (x + noteHeadWidth > lineEnd) {
        continue;
      }
      paint.color =
          note.type == AccuracyType.correct ? Colors.black : note.type.color;

      canvas.drawOval(
        Rect.fromLTWH(x, top, noteHeadWidth, noteHeadHeight),
        paint,
      );
    }
  }

  /// 악보 배경색 넣기
  void _paintBackground(Canvas canvas, Paint paint, double top, double height) {
    var padding = 10.0;
    canvas.drawRRect(
        RRect.fromLTRBR(lineStart, top - padding, width, top + height + padding,
            const Radius.circular(6)),
        paint);
  }

  /// 라벨 그리기
  void _drawLabel(Canvas canvas, Paint paint, String text, double top) {
    var path = Path();
    path.addArc(
        Rect.fromLTWH(0, top + 1, labelHeight, labelHeight), pi / 2, pi);
    path.lineTo(labelWidth - labelHeight / 2, top + 1);
    path.lineTo(labelWidth, top + lineHeight / 2);
    path.lineTo(labelWidth - labelHeight / 2, top + lineHeight - 1);
    canvas.drawPath(path, paint);
    _drawText(canvas, labelWidth / 2, top + lineHeight / 2, text);
  }

  /// 마디 선 그리기
  void _drawVerticalLine(
      Canvas canvas, Paint paint, double top, double height) {
    paint.color = Colors.black;
    paint.strokeWidth = 2;

    canvas.drawLine(Offset(lineStart + cellWidth, top),
        Offset(lineStart + cellWidth, top + height), paint);
    canvas.drawLine(Offset(lineEnd - cellWidth, top),
        Offset(lineEnd - cellWidth, top + height), paint);

    paint.strokeWidth = 1;
    var gap = 2;

    for (var i = 0; i < 3; i++) {
      double y = top;
      var x = lineStart + cellWidth * (i + 2);
      while (y + gap < top + height) {
        canvas.drawLine(Offset(x, y), Offset(x, y + gap), paint);
        y += 2 * gap;
      }
    }
  }

  /// 텍스트 그리기
  void _drawText(Canvas canvas, double centerX, double centerY, String text) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyles.bodysmall.copyWith(color: Colors.white),
    );

    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final xCenter = (centerX - textPainter.width / 2);
    final yCenter = (centerY - textPainter.height / 2);
    final offset = Offset(xCenter, yCenter);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
