import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonFloatingActionButton {
  final String child;
  final String? onPressed;

  JsonFloatingActionButton({required this.child, this.onPressed});

  factory JsonFloatingActionButton.fromJson(Map json) {
    if (json['child'] == null) {
      return JsonFloatingActionButton(child: 'const SizedBox()');
    }

    return JsonFloatingActionButton(
      child: JsonUIUtil.getWidgetStringFromJson(json['child']),
      onPressed: json['onPressed'],
    );
  }

  @override
  String toString() {
    if (child.contains('Row')) {
      return '''
 FloatingActionButton.extended(
        onPressed: (){ 
          ${onPressed != null ? '$onPressed' : ''}
           },
        label: $child,
      )
''';
    }
    return '''
      FloatingActionButton(
        onPressed: (){ 
          ${onPressed != null ? '$onPressed' : ''}
           },
        child: $child,
      )
''';
  }
}
