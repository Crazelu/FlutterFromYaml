import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonFloatingActionButton {
  final String child;
  final String? onPressed;
  final bool extended;

  JsonFloatingActionButton({
    required this.child,
    this.onPressed,
    this.extended = false,
  });

  factory JsonFloatingActionButton.fromJson(Map json) {
    if (json['child'] == null) {
      return JsonFloatingActionButton(child: 'const SizedBox()');
    }

    return JsonFloatingActionButton(
      child: JsonUIUtil.getWidgetStringFromJson(json['child']),
      onPressed: json['onPressed'],
      extended: json['extended'] ?? false,
    );
  }

  @override
  String toString() {
    if (extended) {
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
