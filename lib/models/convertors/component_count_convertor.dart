import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component_count_convertor.g.dart';

DrumComponent getDrumComponentFromADTKey(int key) =>
    DrumComponent.values.where((e) => e.adtKey == key).first;

enum DrumComponent {
  hihat(label: '하이햇', adtKey: 0),
  smallTom(label: '탐', adtKey: 1),
  snareDrum(label: '스네어', adtKey: 2),
  kick(label: '킥', adtKey: 3),
  total(label: '기타', adtKey: -1);

  const DrumComponent({required this.label, required this.adtKey});

  final String label;
  final int adtKey;
}

@JsonSerializable()
class ComponentCount {
  int hihat;
  int smallTom;
  int snareDrum;
  int kick;
  int total;

  ComponentCount({
    this.hihat = 0,
    this.smallTom = 0,
    this.snareDrum = 0,
    this.kick = 0,
    this.total = 0,
  });

  factory ComponentCount.fromJson(Map<String, dynamic> json) =>
      _$ComponentCountFromJson(json);
  Map<String, dynamic> toJson() => _$ComponentCountToJson(this);

  getByType(DrumComponent type) {
    switch (type) {
      case DrumComponent.hihat:
        return hihat;
      case DrumComponent.smallTom:
        return smallTom;
      case DrumComponent.snareDrum:
        return snareDrum;
      case DrumComponent.kick:
        return kick;
      case DrumComponent.total:
        return total;
    }
  }

  setByType(DrumComponent type, int value) {
    switch (type) {
      case DrumComponent.hihat:
        return hihat = value;
      case DrumComponent.smallTom:
        return smallTom = value;
      case DrumComponent.snareDrum:
        return snareDrum = value;
      case DrumComponent.kick:
        return kick = value;
      case DrumComponent.total:
        return total = value;
    }
  }

  setWithAdtKey(Map<String, dynamic> keyMap) {
    for (var v in DrumComponent.values) {
      if (keyMap.containsKey(v.adtKey.toString())) {
        setByType(v, keyMap[v.adtKey.toString()]!);
      }
    }
  }
}

class ComponentCountConvertor extends TypeConverter<ComponentCount, String> {
  const ComponentCountConvertor();

  @override
  ComponentCount fromSql(String fromDb) {
    return ComponentCount.fromJson(json.decode(fromDb));
  }

  @override
  String toSql(ComponentCount value) {
    return json.encode(value.toJson());
  }
}
