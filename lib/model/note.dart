import 'dart:typed_data';

class Note {
  int id;
  String title;
  String description;
  DateTime date;
  int status;
  String picture;

  Note(this.title, this.description, this.status, this.picture, {this.id, this.date});

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
        "date": date.toString(),
        "status": status,
        "picture": picture,
      };
}
