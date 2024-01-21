import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonGestureDetector {
  final String child;
  final String? onTap;
  final bool bind;

  JsonGestureDetector({
    required this.child,
    this.onTap,
    this.bind = false,
  });

  factory JsonGestureDetector.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonGestureDetector(child: 'const SizedBox()');

    return JsonGestureDetector(
      child: JsonUIUtil.getWidgetStringFromJson(json[key]['child']),
      onTap: json[key]['onTap'],
      bind: json[key]['bind'] ?? false,
    );
  }

  @override
  String toString() {
    return '''
      GestureDetector(
        onTap: (){ 
          ${bind ? '${JsonUIUtil.getFunction(onTap ?? '')}' : onTap != null ? '$onTap' : ''}
           },
        child: $child,
      )
''';
  }
}
