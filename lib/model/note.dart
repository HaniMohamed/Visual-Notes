import 'dart:typed_data';

class Note {
  int? id;
  String? title;
  String? description;
  DateTime? date;
  int? status;
  Uint8List? picture;

  Note(this.id, this.title, this.description, this.date, this.status,
      this.picture);

  Note.fromMap(Map map) {
    id = map[id];
    title = map[title];
    description = map[description];
    date = map[date];
    status = map[status];
    picture = map[picture];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "status": status,
        "picture": picture,
      };
}
