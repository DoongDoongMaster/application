// 각 악기별 위치, headType 정의해야 함
enum NoteType {
  // cymbals
  crashCymbal, //A5
  rideCymbal, //F5
  rideCymbalBell, //F5

  hiHat, //G5
  hiHatOpen, //G5
  hiHatClose, //G5
  hihatFoot, //F4

  snareDrum, //C5
  snareDrumRimShot, //C5

  bassDrum, //F4
  smallTom, //E5
  middleTom, //D5
  floorTom, //A5

  rest
}

class Chord {
  // 기준음
  late final List<NoteType> notes;
  // 박자
  late final int duration;
  // 생김새 - 미정
  // type(몇분음표), beam, stem(up 고정), dot
  // notation -> n잇단음표 (tuplet)
  // time modification
}
