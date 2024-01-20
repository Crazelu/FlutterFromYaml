import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonCenter {
  final String child;

  JsonCenter({required this.child});

  factory JsonCenter.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonCenter(child: 'const SizedBox()');

    return JsonCenter(
      child: JsonUIUtil.getWidgetStringFromJson(
        json[key]['child'],
      ),
    );
  }

  @override
  String toString() {
    return 'Center(child: $child)';
  }
}
