import 'package:flutter_from_yaml/parsers/center.dart';
import 'package:flutter_from_yaml/parsers/column.dart';
import 'package:flutter_from_yaml/parsers/floating_action_button.dart';
import 'package:flutter_from_yaml/parsers/gesture_detector.dart';
import 'package:flutter_from_yaml/parsers/icon.dart';
import 'package:flutter_from_yaml/parsers/reactive_builder.dart';
import 'package:flutter_from_yaml/parsers/row.dart';
import 'package:flutter_from_yaml/parsers/scaffold.dart';
import 'package:flutter_from_yaml/parsers/sized_box.dart';
import 'package:flutter_from_yaml/parsers/text.dart';

class JsonUIUtil {
  JsonUIUtil._();
  static final Map<String, String> _functions = {};

  static String? getFunction(String key) {
    return _functions[key];
  }

  static void setFunction(String key, String body) {
    _functions[key] = body;
  }

  static final Map<String, String> _states = {};

  static String? getState(String key) {
    return _states[key];
  }

  static void setState(String key, String state) {
    _states[key] = state;
  }

  static List<String> getWidgets(List json) {
    List<String> widgets = <String>[];

    for (var widget in json) {
      final widgetString = getWidgetStringFromJson(widget);
      if (widgetString.isEmpty) continue;
      widgets.add(widgetString);
    }
    return widgets;
  }

  static String getWidgetStringFromJson(Map? json) {
    final key = json?.keys.first;
    if (json == null || key == null) return 'const SizedBox()';

    switch (key) {
      case 'Text':
        return JsonText.fromJson(json).toString();
      case 'Column':
        return JsonColumn.fromJson(json).toString();
      case 'Row':
        return JsonRow.fromJson(json).toString();
      case 'Center':
        return JsonCenter.fromJson(json).toString();
      case 'Scaffold':
        return JsonScaffold.fromJson(json).toString();
      case 'Icon':
        return JsonIcon.fromJson(json).toString();
      case 'floatingActionButton':
        return JsonFloatingActionButton.fromJson(json).toString();
      case 'ReactiveBuilder':
        return JsonReactiveBuilder.fromJson(json).toString();
      case 'GestureDetector':
        return JsonGestureDetector.fromJson(json).toString();
      case 'SizedBox':
        return JsonSizedBox.fromJson(json).toString();

      default:
        return 'const SizedBox()';
    }
  }
}
