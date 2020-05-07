import 'dart:convert';

class Media {
  int id;
  String url;
  String thumb;
  String icon;

  Media({
    this.id,
    this.url,
    this.thumb,
    this.icon,
  });

  factory Media.fromMap(Map<String, dynamic> json) => Media(
        id: json["id"],
        url: json["url"],
        thumb: json["thumb"],
        icon: json["icon"],
      );
  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "thumb": thumb,
        "icon": icon,
      };
}
