import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonReactiveBuilder {
  final String? listenable;
  final String? builder;

  JsonReactiveBuilder({
    this.listenable,
    this.builder,
  });

  factory JsonReactiveBuilder.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonReactiveBuilder();

    final buffer = StringBuffer();

    final listenable = json[key]['value'];

    if (listenable is List) {
      buffer.write('Listenable.merge([');
      for (final item in listenable) {
        final state = JsonUIUtil.getState(item ?? "");
        buffer.write('$state,');
      }
      buffer.write('])');
    } else {
      buffer.write(JsonUIUtil.getState(listenable ?? ""));
    }

    return JsonReactiveBuilder(
      listenable: '$buffer',
      builder: '''
        (context, _){
          return ${JsonUIUtil.getWidgetStringFromJson(json[key]['child'])};
        }
''',
    );
  }

  @override
  String toString() {
    if (listenable == null || builder == null) {
      return 'const SizedBox()';
    }
    return '''ListenableBuilder(
      listenable: $listenable,
      builder: $builder,
    )
''';
  }
}
