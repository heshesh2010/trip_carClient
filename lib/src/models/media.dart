class Media {
  String id;
  String name;
  String url;
  String thumb;
  String icon;
  String size;

  Media();

  Media.fromJSON(Map<String, dynamic> jsonMap)
      : url = jsonMap['url'] != null ? jsonMap['url'] : null,
        thumb = jsonMap['thumb'] != null ? jsonMap['thumb'] : null;
}
