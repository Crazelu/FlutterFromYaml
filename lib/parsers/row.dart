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
      mainAxisAlignment: json[key]['mainAxisAlignment'],
      crossAxisAlignment: json[key]['crossAxisAlignment'],
      children: JsonUIUtil.getWidgets(json[key]['children']),
    );
  }

  @override
  String toString() {
    return '''
    Row(
       ${mainAxisAlignment != null ? 'mainAxisAlignment: MainAxisAlignment.$mainAxisAlignment,' : ''}
       ${crossAxisAlignment != null ? 'crossAxisAlignment: CrossAxisAlignment.$crossAxisAlignment,' : ''}
      children: $children,
    )
''';
  }
}
