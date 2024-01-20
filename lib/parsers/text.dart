class JsonText {
  final String data;
  final JsonTextStyle? style;
  final String? textAlign;

  JsonText({
    required this.data,
    this.style,
    this.textAlign,
  });

  factory JsonText.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonText(data: '');

    dynamic value = json[key];
    if (value is! String) {
      value = value['value'];
    }

    dynamic style = json['style'];
    if (json[key] is Map) {
      style ??= json[key]['style'];
    }

    dynamic textAlign = json['textAlign'];
    if (json[key] is Map) {
      textAlign ??= json[key]['textAlign'];
    }

    return JsonText(
      data: value,
      textAlign: textAlign,
      style: style != null ? JsonTextStyle.fromJson(style) : null,
    );
  }

  @override
  String toString() {
    return '''
Text('$data'
${textAlign != null ? ', textAlign: TextAlign.$textAlign' : ''}
${style != null ? ', style: $style,' : ''}
)
''';
  }
}

class JsonTextStyle {
  final num fontSize;
  final num weight;

  JsonTextStyle({required this.fontSize, required this.weight});

  factory JsonTextStyle.fromJson(Map json) {
    return JsonTextStyle(
      fontSize: json['fontSize'],
      weight: json['fontWeight'] ?? 400,
    );
  }

  @override
  String toString() {
    return '''
  const TextStyle(fontSize: $fontSize, fontWeight: FontWeight.w$weight,)
''';
  }
}
