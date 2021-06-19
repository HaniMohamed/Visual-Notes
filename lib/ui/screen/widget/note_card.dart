import 'package:facegraph_test/model/note.dart';
import 'package:facegraph_test/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(Icons.delete_forever),
      ),
      key: ValueKey<int>(note.id),
      onDismissed: (DismissDirection direction) async {
        await Provider.of<HomeViewModel>(context, listen: false)
            .deleteNote(note.id);
      },
      child: Card(
          child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Image.memory(note.picture),
        title: Text(note.title),
        subtitle: Text(note.description),
      )),
    );
  }
}
