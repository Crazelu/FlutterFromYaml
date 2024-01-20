import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonRow {
  final List<String> children;
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;

  JsonRow({
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  factory JsonRow.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonRow(children: []);

    return JsonRow(
      mainAxisAlignment: _getAlignment(true, json[key]['mainAxisAlignment']),
      crossAxisAlignment: _getAlignment(false, json[key]['crossAxisAlignment']),
      children: JsonUIUtil.getWidgets(json[key]['children']),
    );
  }

  static _getAlignment(bool isMainAxisAlignment, String? alignment) {
    switch (alignment) {
      case 'start':
        if (isMainAxisAlignment) return 'MainAxisAlignment.start';
        return 'CrossAxisAlignment.start';
      case 'center':
        if (isMainAxisAlignment) return 'MainAxisAlignment.center';
        return 'CrossAxisAlignment.center';
      case 'end':
        if (isMainAxisAlignment) return 'MainAxisAlignment.end';
        return 'CrossAxisAlignment.end';
      case 'spaceEvenly':
        if (isMainAxisAlignment) return 'MainAxisAlignment.spaceEvenly';
        return 'CrossAxisAlignment.center';
      case 'baseline':
        if (!isMainAxisAlignment) return 'CrossAxisAlignment.baseline';
        return 'MainAxisAlignment.start';
      case 'stretch':
        if (!isMainAxisAlignment) return 'CrossAxisAlignment.stretch';
        return 'MainAxisAlignment.start';
      case 'spaceAround':
        if (isMainAxisAlignment) return 'MainAxisAlignment.spaceAround';
        return 'CrossAxisAlignment.center';
      case 'spaceBetween':
        if (isMainAxisAlignment) return 'MainAxisAlignment.spaceBetween';
        return 'CrossAxisAlignment.center';
      default:
        if (isMainAxisAlignment) return 'MainAxisAlignment.start';
        return 'CrossAxisAlignment.start';
    }
  }

  @override
  String toString() {
    return '''
 Row(
      mainAxisAlignment: ${mainAxisAlignment ?? 'MainAxisAlignment.start'},
      crossAxisAlignment: ${crossAxisAlignment ?? 'CrossAxisAlignment.center'},
      children: $children,
    )
''';
  }
}
