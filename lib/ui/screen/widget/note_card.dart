import 'dart:developer';

import 'package:facegraph_test/model/note.dart';
import 'package:facegraph_test/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_note.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    String status = note.status == 1 ? "Open" : "Closed";
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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${note.date.year}/${note.date.month}/${note.date.day}",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "($status)",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ],
        ),
        subtitle: Text(note.description),
        trailing: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isDismissible: true,
                  isScrollControlled: true,
                  enableDrag: true,
                  builder: (context) {
                    return NewNote(
                      isEditing: true,
                      note: note,
                    );
                  });
            },
            icon: Icon(Icons.edit)),
      )),
    );
  }
}
