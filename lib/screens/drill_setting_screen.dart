import 'package:application/main.dart';
import 'package:application/models/convertors/cursor_convertor.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/models/entity/drill_info.dart';
import 'package:application/models/views/drill_list_view.dart';
import 'package:application/router.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/shadow_styles.dart';
import 'package:application/widgets/delete_confirm_dialog.dart';
import 'package:application/widgets/drill_setting/section.dart';
import 'package:application/widgets/music_sheet_viewer_widget.dart';
import 'package:application/widgets/positioned_container.dart';
import 'package:application/widgets/show_snackbar.dart';
import 'package:application/widgets/white_thin_app_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum DrillSettingMode { select, add, delete }

class Measure extends Cursor {
  final int idx;
  final List<String?> drillList = [
    for (var i = 0; i < SectionType.count; i++) null
  ];
  Measure({
    required super.h,
    required super.ts,
    required super.w,
    required super.x,
    required super.y,
    required this.idx,
  });

  Measure.fromCursor(Cursor c, int idx)
      : this(h: c.h, ts: c.ts, w: c.w, x: c.x, y: c.y, idx: idx);

  int addDrill(String drillId) {
    for (var i = 0; i < SectionType.count; i++) {
      if (drillList[i] == null) {
        drillList[i] = drillId;
        return i;
      }
    }
    return -1;
  }

  void clearSection() {
    for (var i = 0; i < SectionType.count; i++) {
      drillList[i] = null;
    }
  }
}

class DrillSettingScreen extends StatefulWidget {
  final String? projectId;
  const DrillSettingScreen({super.key, this.projectId});

  @override
  State<DrillSettingScreen> createState() => _DrillSettingScreenState();
}

class _DrillSettingScreenState extends State<DrillSettingScreen> {
  DrillSettingMode mode = DrillSettingMode.select;
  DrillListData? data;
  bool isDrillSelectPopupVisible = false;
  Cursor? popupAnchor;

  late List<Measure> measureList;
  final List<Section> sectionList = [];
  final List<String?> selectedList = [
    for (var i = 0; i < SectionType.count; i++) null
  ];
  late int start, end;
  int selectedCnt = 0;
  String guideText = "구간 연습장";
  String get leftText =>
      (mode != DrillSettingMode.select || data?.projectTitle == null
          ? '취소'
          : data!.projectTitle);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  /// 초기화 - drill 목록 및 악보 정보 불러오기, 이미 존재하는 drill 렌더링, 선택 초기화
  void _initialize() async {
    data = await database.getDrillList(widget.projectId!);

    _resetSelection();
    _calculateSection();
    setState(() {});
  }

  /// 선택 초기화 하기
  void _resetSelection() {
    end = -1;
    start = data!.measureList.length - 1;
    selectedCnt = 0;
  }

  /// 구간 추가 - 기존 선택된 마디를 기준으로 새로선택/앞(뒤) 연장 선택
  void _setSelection(int idx) {
    setState(() {
      if (selectedCnt == 2) {
        _resetSelection();
      }
      switch (selectedCnt) {
        case 0:
          start = end = idx;
          selectedCnt = 1;
          break;
        case 1:
          if (idx < start) {
            start = idx;
          } else {
            end = idx;
          }
          selectedCnt = 2;
          break;
      }
    });
  }

  /// 모드 수정 및 appbar title 업데이트
  void _changeMode(DrillSettingMode to) {
    if (mode == to) {
      return;
    }
    _removeDrillSelectPopup();
    _resetSelection();

    mode = to;

    switch (to) {
      case DrillSettingMode.select:
        guideText = "구간 연습장";
        break;
      case DrillSettingMode.add:
        guideText = "구간의 첫(끝)마디를 선택해주세요";
        break;
      case DrillSettingMode.delete:
        guideText = "삭제할 구간을 선택해주세요";
        break;
    }
    setState(() {});
  }

  /// section list에 새로운 추가
  void _addNewSection(
    String id,
    int start,
    int end,
    double width,
    int typeIdx, {
    required bool hasLeftBorder,
    required bool hasRightBorder,
  }) {
    final section = Section(
      id: id,
      start: start,
      end: end,
      hasLeftBorder: hasLeftBorder,
      hasRightBorder: hasRightBorder,
    );
    section.type = SectionType.values[typeIdx];
    section.cursor = measureList[start].copyWith(w: width);
    sectionList.add(section);
  }

  /// drill list를 section list로 가공
  void _calculateSection() {
    if (data == null) {
      return;
    }
    measureList = data!.measureList
        .mapIndexed((idx, cursor) => Measure.fromCursor(cursor, idx))
        .toList();

    final drillList = List<DrillInfo>.from(data!.drillList);

    // 구간 정렬
    drillList.sort((a, b) {
      if (a.start == b.start) {
        return a.end.compareTo(b.end);
      }
      return a.start.compareTo(b.start);
    });

    sectionList.clear();

    // 정렬 순서대로 색 부여하기.
    for (final drill in drillList) {
      // 첫마디를 기준으로 type 배정 받기
      var start = drill.start;
      final typeIdx = measureList[start].addDrill(drill.id);

      var width = measureList[start].w;
      for (var i = drill.start + 1; i <= drill.end; i++) {
        measureList[i].drillList[typeIdx] = drill.id;

        if (measureList[start].y != measureList[i].y) {
          _addNewSection(
            drill.id,
            start,
            i - 1,
            width,
            typeIdx,
            hasLeftBorder: start == drill.start,
            hasRightBorder: false,
          );
          start = i;
          width = 0;
        }
        width += measureList[i].w;
      }

      _addNewSection(
        drill.id,
        start,
        drill.end,
        width,
        typeIdx,
        hasLeftBorder: start == drill.start,
        hasRightBorder: true,
      );
    }
  }

  /// 마디 선택시 팝업
  void _showDrillSelectPopup() {
    setState(() {
      isDrillSelectPopupVisible = true;
    });
  }

  void _removeDrillSelectPopup() {
    setState(() {
      selectedList.fillRange(0, SectionType.count, null);
      isDrillSelectPopupVisible = false;
    });
  }

  /// 좌 상단 취소 버튼 로직
  void _onClickBack() {
    if (mode == DrillSettingMode.select) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed(RouterPath.home.name);
      }
    } else {
      _changeMode(DrillSettingMode.select);
    }
  }

  /// 완료 버튼 클릭시 새로운 drill 생성
  void _onClickComplete() async {
    if (mode != DrillSettingMode.add || data == null) {
      return;
    }

    for (var i = start; i <= end; i++) {
      if (measureList[i].drillList.nonNulls.length == SectionType.count) {
        showSnackbar(context, '한 마디에는 최대 4개의 구간만 설정할 수 있습니다.');
        setState(() {
          _resetSelection();
        });
        return;
      }
    }

    await database.into(database.drillInfos).insert(
          DrillInfosCompanion.insert(
            projectId: data!.projectId,
            start: start,
            end: end,
          ),
        );

    _initialize();
    _changeMode(DrillSettingMode.select);
  }

  /// 마디 선택시 범위선택 or 팝업
  void _onClickMeasure(Measure measure) {
    _removeDrillSelectPopup();
    switch (mode) {
      case DrillSettingMode.add:
        _setSelection(measure.idx);
        break;
      case DrillSettingMode.select:
      case DrillSettingMode.delete:
        if (measure.drillList.nonNulls.isEmpty) {
          return;
        }
        for (var i = 0; i < SectionType.count; i++) {
          selectedList[i] = measure.drillList[i];
        }
        popupAnchor = measure;
        _showDrillSelectPopup();
    }
  }

  /// drill 삭제 함수
  void _deleteDrill(String drillId) async {
    await (database.delete(database.drillInfos)
          ..where((tbl) => tbl.id.equals(drillId)))
        .go();

    _initialize();
    _removeDrillSelectPopup();
  }

  /// 연습 시작
  void _startDrill(String drillId) {
    if (data == null) {
      return;
    }
    context.pushNamed(RouterPath.prompt.name, pathParameters: {
      "musicId": data!.musicId,
      "projectId": data!.projectId,
    }, queryParameters: {
      "drillId": drillId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteThinAppBar(
        title: guideText,
        leftText: leftText,
        rightText: '완료',
        onPressedLeftLabel: _onClickBack,
        onPressedRightLabel: selectedCnt > 0 ? _onClickComplete : null,
        iconButton1: mode == DrillSettingMode.select
            ? _AppBarIconButton(
                icon: Icons.add_box_outlined,
                color: ColorStyles.primary,
                onPressed: () => _changeMode(DrillSettingMode.add),
              )
            : null,
        iconButton2: mode == DrillSettingMode.select
            ? _AppBarIconButton(
                icon: Icons.delete_outline_rounded,
                color: ColorStyles.red,
                onPressed: () => _changeMode(DrillSettingMode.delete),
              )
            : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  MusicSheetBox(
                    child: Center(
                      child: data == null
                          ? const CircularProgressIndicator()
                          : Stack(
                              children: [
                                ...sectionList.map(
                                  (e) => SectionWidget(
                                    data: e,
                                    isActive: mode != DrillSettingMode.add,
                                    isSelected: selectedList.contains(e.id),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 80),
                                  child: MusicSheetWidget(
                                      image: data!.sheetImage!),
                                ),
                                ...sectionList
                                    .where((element) => element.hasLeftBorder)
                                    .map((e) => SectionMarker(
                                          data: e,
                                          isActive:
                                              mode != DrillSettingMode.add,
                                        )),
                                ...measureList.map(
                                  (measure) => PositionedInkWell(
                                    cursor: measure,
                                    height: 100,
                                    onTap: (mode == DrillSettingMode.add ||
                                            measure
                                                .drillList.nonNulls.isNotEmpty)
                                        ? () => _onClickMeasure(measure)
                                        : null,
                                    decoration: BoxDecoration(
                                      color: (start <= measure.idx &&
                                              measure.idx <= end)
                                          ? ColorStyles.primary
                                              .withOpacity(0.54)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                if (isDrillSelectPopupVisible)
                                  DrillSelectPopup(
                                    cursor: popupAnchor!,
                                    selectedList: selectedList,
                                    mode: mode,
                                    deleteDrill: _deleteDrill,
                                    startDrill: _startDrill,
                                  ),
                              ],
                            ),
                    ),
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

class DrillSelectPopup extends StatelessWidget {
  const DrillSelectPopup({
    super.key,
    required this.cursor,
    required this.selectedList,
    required this.mode,
    required this.deleteDrill,
    required this.startDrill,
  });

  final Cursor cursor;
  final List<String?> selectedList;
  final DrillSettingMode mode;
  final void Function(String) deleteDrill, startDrill;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: cursor.x,
      top: cursor.y + cursor.h,
      child: Column(
        children: [
          CustomPaint(painter: _ChatBubbleNip()),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [ShadowStyles.shadow300]),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                for (var i = 0; i < SectionType.count; i++)
                  if (selectedList[i] != null)
                    DrillSelectButton(
                      mode: mode,
                      color: SectionType.values[i].color,
                      onPressed: () async {
                        switch (mode) {
                          case DrillSettingMode.add:
                            return;
                          case DrillSettingMode.select:
                            startDrill(selectedList[i]!);
                            break;
                          case DrillSettingMode.delete:
                            var response = await showDialog<DeleteConfirm>(
                              context: context,
                              builder: (ctx) => DeleteConfirmDialog(
                                  drillId: selectedList[i]!),
                            );

                            if (response == DeleteConfirm.ok) {
                              deleteDrill(selectedList[i]!);
                            }
                        }
                      },
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrillSelectButton extends IconButton {
  DrillSelectButton({
    super.key,
    required DrillSettingMode mode,
    required Color color,
    super.onPressed,
  }) : super(
          highlightColor: color.withOpacity(0.4),
          icon: Icon(
            mode == DrillSettingMode.select
                ? Icons.circle
                : Icons.remove_circle_rounded,
            size: 36,
            color: color,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 2,
                offset: const Offset(0, 2),
              )
            ],
          ),
        );
}

class _AppBarIconButton extends IconButton {
  _AppBarIconButton({
    required IconData icon,
    required Color color,
    void Function()? onPressed,
  }) : super(
            icon: Icon(icon, color: color), iconSize: 24, onPressed: onPressed);
}

class _ChatBubbleNip extends CustomPainter {
  _ChatBubbleNip();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;

    var path = Path();
    path.lineTo(-6, 0);
    path.lineTo(0, -12);
    path.lineTo(6, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
