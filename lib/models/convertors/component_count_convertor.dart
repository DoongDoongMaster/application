import 'dart:convert';

import 'package:drift/drift.dart';

enum DrumComponent {
  hihat(label: '하이헷', adtKey: 0),
  smallTom(label: '스몰탐', adtKey: 1),
  snareDrum(label: '스네어', adtKey: 2),
  kick(label: '킥', adtKey: 3),
  total(label: '전체', adtKey: -1);

  const DrumComponent({required this.label, required this.adtKey});

  final String label;
  final int adtKey;
}

typedef ComponentCount = Map<String, int>;

class ComponentCountConvertor extends TypeConverter<ComponentCount, String> {
  const ComponentCountConvertor();

  @override
  ComponentCount fromSql(String fromDb) {
    return ComponentCount.castFrom(json.decode(fromDb));
  }

  @override
  String toSql(ComponentCount value) {
    return json.encode(
        {for (var k in DrumComponent.values) k.name: value[k.name] ?? 0});
  }
}
