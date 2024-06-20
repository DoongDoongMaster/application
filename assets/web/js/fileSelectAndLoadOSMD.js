const MARGIN_TOP = 40;

const defaultCursorWidth = 30;
const defaultCursorHeight = 40;

const cursorWidth = 20;
const cursorHeight = 100;

const cursorDisplayOffsetY = 20;

/**
 * OSMD내 표기 되는 음표 위치 -> 드럼 악기 라벨
 * @param {number} line 악보 표시 라인
 * @returns drum label
 */
function staffLineToComponent(line) {
  switch (line) {
    case 5.5: // HH
      return 0;
    case 4.5: // ST
    case 4: // MT
    case 2.5: // FT
      return 1;
    case 3.5: // SD
      return 2;
    case 1.5: // KK
      return 3;
    case 6.5: // CC
    case 6: // RC
    case 0.5: //Hihat - pedal
    default:
      return -1; // 미분류 - 모델 결과 X
  }
}

/**
 *
 * @param {*} music osmd.graphic.measureList
 * @returns measure 정보, musicEntry 정보 추출
 */
function getMusicInfo(music) {
  const measureList = [];
  const musicEntries = [];
  const sourceCount = { "-1": 0, "0": 0, "1": 0, "2": 0, "3": 0 };

  for (const [idx, measure] of music.entries()) {
    if (measureList.length > 0) {
      measureList[measureList.length - 1].e = idx; // 끝나는 인덱스
    }

    if (measure[0] == undefined) {
      continue;
    }

    const { width, height } = measure[0].boundingBox.size;
    var { x, y } = measure[0].boundingBox.absolutePosition;

    // 1. measureList
    measureList.push({
      x: 10 * x,
      y: 10 * y + MARGIN_TOP,
      w: 10 * width,
      // h: 10 * height,
      h: 40,
      ts: idx, // 이게 시작 인덱스
    });

    // 2. cursorList & musicEntries
    for (const entry of measure[0].staffEntries) {
      for (const x of entry.graphicalVoiceEntries[0].notes) {
        if (x.sourceNote.isRest()) {
          continue;
        }

        const component = staffLineToComponent(x.staffLine);
        sourceCount[component.toString()] += 1;

        musicEntries.push({
          pitch: component,
          ts: x.sourceNote.getAbsoluteTimestamp().realValue,
          key: x.sourceNote.NoteToGraphicalNoteObjectId,
        });
      }
    }
  }
  if (measureList.length > 0) {
    measureList[measureList.length - 1].e = music.length; // 끝나는 인덱스
  }

  return {
    measureList,
    musicEntries,
    sourceCount,
  };
}

/**
 * 해당하는 커서의 정보를 추출한다.
 * @param {*} cursor 커서 인스턴스 (osmd.cursor)
 * @returns timestamp, 커서 위치, 넓이 등
 */
function getCustomizedCursorInfo(cursor) {
  const cursorElement = cursor.cursorElement;

  const { height, width } = cursorElement;

  const [y, x] = [cursorElement.style.top, cursorElement.style.left].map(
    (x) => {
      return parseFloat(x.slice(0, -2));
    }
  );

  return {
    y:
      y +
      defaultCursorHeight / 2 -
      cursorHeight / 2 -
      cursorDisplayOffsetY +
      MARGIN_TOP,
    x: x + defaultCursorWidth / 2 - cursorWidth / 2,
    h: cursorHeight,
    w: cursorWidth,
    ts: cursor.iterator.currentTimeStamp.realValue,
  };
}

/**
 * 커서를 순회하면서 커서 정보, 마디 정보 수집
 * @param {*} cursor 커서 인스턴스 (osmd.cursor)
 */
function getCursorList(cursor) {
  const cursorList = [];
  cursor.show();

  try {
    while (!cursor.iterator.endReached) {
      cursorList.push(getCustomizedCursorInfo(cursor));
      cursor.next();
    }
  } catch (e) {
    console.log(e);
  }
  cursor.hide();

  return cursorList;
}

/**
 * osmd 시스템 시작
 * @param {*} fileData xml bytes data
 * @returns osmd instance
 */
async function startOSMD(fileData) {
  var osmd = new opensheetmusicdisplay.OpenSheetMusicDisplay("osmdCanvas", {
    backend: "canvas",
    resize: true,
    drawFromMeasureNumber: 1,
    drawUpToMeasureNumber: Number.MAX_SAFE_INTEGER,
    drawTitle: false,
    drawPartNames: false,
    drawingParameters: "compact",
    drawMetronomeMarks: false,
    // pageBackgroundColor: "#FFFFFF",

    drawPartNames: false,
    // drawPartAbbreviations: true,
  });

  await osmd.load(fileData, "");
  window.osmd = osmd;
  await osmd.render();
  return osmd;
}

/**
 * XML 파일을 읽어서 OSMD 시스템을 활용하여 시각화 및 정보 추출
 * @param {*} osmd osmd instance
 * @returns
 */
function extractInfoFromOSMD(osmd) {
  return {
    cursorList: getCursorList(osmd.cursor),
    ...getMusicInfo(osmd.graphic.measureList),
  };
}

/// 임시 - 채점된 악보 그려보기!!!
async function drawResult(osmd, transcription) {
  // 정답 (검정), 박자오답(주황), 음정오답(노랑), , wrong(빨강 - 나올 일 없음), miss (빨강)
  const colors = ["#000000", "#FFD977", "#FFA049", "#FF0000", "#C6C6C8"];

  for (const measure of osmd.graphic.measureList) {
    if (measure[0] == undefined) {
      // 반복되는 마디의 경우 비어있을 수 있음.
      continue;
    }
    for (const entry of measure[0].staffEntries) {
      entry.graphicalVoiceEntries[0].notes.map((note) => {
        if (note.sourceNote.isRest()) {
          return;
        }

        note.sourceNote.noteheadColor =
          colors[
            transcription[
              note.sourceNote.NoteToGraphicalNoteObjectId.toString()
            ]
          ];
      });
    }
  }

  osmd.render();
}

// inapp 준비 완료 된 경우.
window.addEventListener("flutterInAppWebViewPlatformReady", async function (_) {
  const inputJson = await window.flutter_inappwebview.callHandler(
    "sendFileToOSMD"
  );

  var args0 = null,
    args1 = null;

  try {
    const osmd = await startOSMD(inputJson.bytes);

    if (inputJson.transcription == null) {
      args1 = extractInfoFromOSMD(osmd);
    } else {
      await drawResult(osmd, inputJson.transcription);
    }

    // canvas 요소 가져오기
    var canvas = document.getElementById("osmdCanvasVexFlowBackendCanvas1");

    // 캔버스 크기 변경
    var newWidth = 1024;
    var newHeight = canvas.height / 2;

    var tempCanvas = document.createElement("canvas");
    tempCanvas.style.width = `${newWidth}px`;
    tempCanvas.style.height = `${newHeight + MARGIN_TOP}px`;

    const dpr = window.devicePixelRatio;
    var tempContext = tempCanvas.getContext("2d");

    tempCanvas.width = newWidth * dpr;
    tempCanvas.height = (newHeight + MARGIN_TOP) * dpr;

    tempContext.scale(dpr, dpr);

    tempContext.drawImage(
      canvas,
      0,
      0,
      canvas.width,
      canvas.height,
      0,
      MARGIN_TOP,
      newWidth,
      newHeight
    );

    args0 = tempCanvas.toDataURL("image/png").split(",")[1];

    window.flutter_inappwebview.callHandler("getDataFromOSMD", args0, args1);
  } catch (error) {
    console.log(error);
  }
});
