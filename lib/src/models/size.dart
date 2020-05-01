class Size {
  String id;
  String name;

  Size();

  Size.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'].toString();
    name = jsonMap['name'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Size &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
