import 'package:flutter_from_yaml/parsers/json_ui_util.dart';

class JsonListenableBuilder {
  final String? listenable;
  final String? builder;

  JsonListenableBuilder({
    this.listenable,
    this.builder,
  });

  factory JsonListenableBuilder.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonListenableBuilder();

    final buffer = StringBuffer();

    final listenable = json[key]['listenable'];

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

    return JsonListenableBuilder(
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
