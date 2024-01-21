class JsonSizedBox {
  final num? width;
  final num? height;

  JsonSizedBox({this.width, this.height});

  factory JsonSizedBox.fromJson(Map json) {
    final key = json.keys.first;
    if (key == null) return JsonSizedBox();

    return JsonSizedBox(
      width: json[key]['width'],
      height: json[key]['height'],
    );
  }

  @override
  String toString() {
    if (width == null && height == null) {
      return 'const SizedBox.shrink()';
    }

    return '''
    const SizedBox(
      ${width != null ? 'width: $width,' : ''}
      ${height != null ? 'height: $height,' : ''}
    )
  ''';
  }
}
