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

    return JsonReactiveBuilder(
      listenable: '${json[key]['value']}',
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
    return '''AnimatedBuilder(
      animation: ${JsonUIUtil.getState(listenable ?? "")?['name']},
      builder: $builder,
    )
''';
  }
}
