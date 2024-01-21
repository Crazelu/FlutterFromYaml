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

    final style = json[key]['style'];

    return JsonText(
      data: json[key]['value'],
      textAlign: json[key]['textAlign'],
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
  final num? weight;

  JsonTextStyle({required this.fontSize, this.weight});

  factory JsonTextStyle.fromJson(Map json) {
    return JsonTextStyle(
      fontSize: json['fontSize'],
      weight: json['fontWeight'],
    );
  }

  @override
  String toString() {
    return '''
  const TextStyle(
    fontSize: $fontSize 
    ${weight != null ? ', fontWeight: FontWeight.w$weight,' : ''}
    )
''';
  }
}
