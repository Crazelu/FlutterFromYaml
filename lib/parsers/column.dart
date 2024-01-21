import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonColumn {
  final List<String> children;
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;

  JsonColumn({
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  factory JsonColumn.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonColumn(children: []);

    return JsonColumn(
      children: JsonUIUtil.getWidgets(json[key]['children']),
      mainAxisAlignment: json[key]['mainAxisAlignment'],
      crossAxisAlignment: json[key]['crossAxisAlignment'],
    );
  }

  @override
  String toString() {
    return '''
    Column(
      ${mainAxisAlignment != null ? 'mainAxisAlignment: MainAxisAlignment.$mainAxisAlignment,' : ''}
       ${crossAxisAlignment != null ? 'crossAxisAlignment: CrossAxisAlignment.$crossAxisAlignment,' : ''}
      children: $children,
    )
''';
  }
}
