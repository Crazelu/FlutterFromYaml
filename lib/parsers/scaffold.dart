import 'package:flutter_from_yaml/parsers/floating_action_button.dart';
import 'package:flutter_from_yaml/parsers/json_ui_util.dart';
import 'package:flutter_from_yaml/parsers/text.dart';

class JsonScaffold {
  final JsonAppBar? appBar;
  final String body;
  final JsonFloatingActionButton? floatingActionButton;

  JsonScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
  });

  factory JsonScaffold.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonScaffold(body: 'const SizedBox()');

    final appBarJson = json[key]['appBar'];
    final floatingActionButtonJson = json[key]['floatingActionButton'];

    return JsonScaffold(
      appBar: appBarJson == null ? null : JsonAppBar.fronJson(appBarJson),
      body: JsonUIUtil.getWidgetStringFromJson(json[key]['body']),
      floatingActionButton: floatingActionButtonJson == null
          ? null
          : JsonFloatingActionButton.fromJson(floatingActionButtonJson),
    );
  }

  @override
  String toString() {
    return '''
      Scaffold(
        ${appBar != null ? 'appBar: $appBar,' : ''}
        body: $body,
        ${floatingActionButton != null ? 'floatingActionButton: $floatingActionButton,' : ''}
      )
''';
  }
}

class JsonAppBar {
  final JsonText title;

  JsonAppBar(this.title);

  factory JsonAppBar.fronJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonAppBar(JsonText(data: ''));

    return JsonAppBar(JsonText.fromJson(json[key]));
  }

  @override
  String toString() {
    return 'AppBar(title: $title)';
  }
}
