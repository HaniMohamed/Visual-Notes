import 'dart:developer';

import 'package:facegraph_test/database/helper.dart';
import 'package:facegraph_test/model/note.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<Note> notes;

  Future<List<Note>> getNotes() async {
    notes = await Helper().retrieveNotes();
    notifyListeners();
    return notes;
  }

  Future<int> insertNote(Note note) async {
    int result;
    result = await Helper().insertNote(note);
    await getNotes();
    return result;
  }

  Future<int> updateNote(Note note) async {
    int result;
    log(note.toMap().toString());
    result = await Helper().updateNote(note).catchError((e){
      log("Error in update : ${e.toString()}");
    });
    await getNotes();
    return result;
  }

  Future<int> deleteNote(int id) async {
    int result;
    result = await Helper().deleteNote(id);
    await getNotes();
    return result;
  }
}
