import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonGestureDetector {
  final String child;
  final String? onTap;

  JsonGestureDetector({required this.child, this.onTap});

  factory JsonGestureDetector.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonGestureDetector(child: 'const SizedBox()');

    return JsonGestureDetector(
      child: JsonUIUtil.getWidgetStringFromJson(json[key]['child']),
      onTap: json[key]['onTap'],
    );
  }

  @override
  String toString() {
    return '''
      GestureDetector(
        onTap: (){ 
          ${onTap != null ? '$onTap' : ''}
           },
        child: $child,
      )
''';
  }
}
