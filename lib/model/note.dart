import 'dart:typed_data';

class Note {
  int id;
  String title;
  String description;
  DateTime date;
  int status;
  Uint8List picture;

  Note(this.title, this.description, this.status, this.picture);

  Note.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    date = DateTime.parse(map["date"]);
    status = map["status"];
    picture = map["picture"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        // "date": date,
        "status": status,
        "picture": picture,
      };
}
