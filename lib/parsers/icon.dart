class JsonIcon {
  JsonIcon(this.iconData);

  final JsonIconData iconData;

  factory JsonIcon.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonIcon(JsonIconData(codePoint: 0));

    return JsonIcon(JsonIconData.fromJson(json[key]['iconData']));
  }
  @override
  String toString() {
    return 'const Icon($iconData)';
  }
}

class JsonIconData {
  final int codePoint;
  final String? fontFamily;

  JsonIconData({required this.codePoint, this.fontFamily});

  factory JsonIconData.fromJson(Map json) {
    return JsonIconData(
      codePoint: json['codePoint'],
      fontFamily: json['fontFamily'] ?? "MaterialIcons",
    );
  }

  @override
  String toString() => "IconData($codePoint, fontFamily: '$fontFamily')";
}
