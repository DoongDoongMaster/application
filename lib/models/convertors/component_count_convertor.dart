import 'dart:convert';

import 'package:drift/drift.dart';

enum DrumComponent {
  hihat(label: '하이헷'),
  snareDrum(label: '스네어'),
  smallTom(label: '스몰탐'),
  kick(label: '킥'),
  total(label: '전체');

  const DrumComponent({required this.label});

  final String label;
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
