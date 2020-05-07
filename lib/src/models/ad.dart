import 'media.dart';

class Ad {
  int id;
  String title;
  bool hasMedia;
  List<Media> media;

  Ad({
    this.id,
    this.title,
    this.hasMedia,
    this.media,
  });

  factory Ad.fromMap(Map<String, dynamic> json) => Ad(
        id: json["id"],
        title: json["title"],
        hasMedia: json["has_media"],
        media: List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
      );
}
