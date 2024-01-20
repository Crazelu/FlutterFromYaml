import 'dart:io';
import 'package:flutter_from_yaml/parsers/json_ui_util.dart';
import 'package:yaml/yaml.dart';

const stateKey = '@@state.reactive';

main() async {
  final yamlFile = File("example2.yaml");
  final yamlString = yamlFile.readAsStringSync();

  var doc = loadYaml(yamlString);
  final json = Map<String, dynamic>.from(doc);

  _parse(json);

  //format generated dart code
  await Process.run('dart', ['format', 'lib/main.dart']);
}

void _parse(Map<String, dynamic> json) {
  final codeFile = File('lib/main.dart');
  final buffer = StringBuffer();

  String homeWidgetName;

  final statefulWidget = json['StatefulWidget'];
  late final statelessWidget = json['StatelessWidget'];

  if (statefulWidget != null) {
    homeWidgetName = statefulWidget['name'];
    buffer.write(_generateAppTemplate(homeWidgetName));
    buffer.write(_generateStatefulWidgetTemplate(statefulWidget['name']));
    buffer.write(_generateStateTemplate(json));
  } else {
    homeWidgetName = statelessWidget['name'];
    buffer.write(_generateAppTemplate(homeWidgetName));
    buffer.write(_generateStatelessWidgetTemplate(json));
  }

  codeFile.writeAsString(buffer.toString());
}

String _generateStateTemplate(Map json) {
  final statefulWidget = json["StatefulWidget"];
  final state = statefulWidget['state'];
  JsonUIUtil.setState(stateKey, state);
  return '''


 class _${statefulWidget['name']}State extends State<${statefulWidget['name']}> {

    ${_parseState(state)}

    ${_generateBuildTemplate(statefulWidget['build'])}

  }

''';
}

String _generateBuildTemplate(Map json) {
  return '''
  @override
  Widget build(BuildContext context) {
   return
    ${JsonUIUtil.getWidgetStringFromJson(json)}
    ;
  }
''';
}

String _parseState(Map json) {
  return '''
    final ValueNotifier<${json['type']}> ${json['name']} = ValueNotifier(${json['defaultValue']});

${_generateStateMethods(json)}

${_generateDisposeMethod(json)}
''';
}

String _generateStateMethods(Map json) {
  final methods = json['methods'] as Map;
  final buffer = StringBuffer();
  for (final entry in methods.entries) {
    final functionBody = '''
${entry.key}() {
  ${entry.value}
}
''';
    buffer.write(functionBody);
  }
  return buffer.toString();
}

String _generateDisposeMethod(Map json) {
  final calls = json['onDispose'] as List;
  final buffer = StringBuffer();

  buffer.write('@override\nvoid dispose() {');

  for (final call in calls) {
    buffer.write('$call\n');
  }

  buffer.write('super.dispose();\n}');
  return buffer.toString();
}

String _generateStatefulWidgetTemplate(String name) {
  return '''
  class $name extends StatefulWidget {
    const $name({super.key});

    @override
    State<$name> createState() => _${name}State();
  }
''';
}

String _generateStatelessWidgetTemplate(Map json) {
  final widget = json["StatelessWidget"];
  return '''
 class ${widget['name']} extends StatelessWidget {

  const ${widget['name']}({super.key});

    ${_generateBuildTemplate(widget['build'])}

  }
''';
}

String _generateAppTemplate(String homeWidgetName) {
  return '''
import 'package:flutter/material.dart';

void main() {
  runApp(const YAMLApp());
}

class YAMLApp extends StatelessWidget {
  const YAMLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter From YAML Demo',
      theme: ThemeData(),
      home: const $homeWidgetName(),
    );
  }
}
''';
}
