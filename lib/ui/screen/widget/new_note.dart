import 'dart:io';
import 'dart:math';

import 'package:facegraph_test/model/note.dart';
import 'package:facegraph_test/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  Note note;
  bool isEditing;

  NewNote({this.note, this.isEditing = false});

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String _radioValue = "Open";
  int status = 1;
  File file;
  bool isLoading = false;

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Open':
          status = 1;
          break;
        case 'Closed':
          status = 0;
          break;
        default:
          status = null;
      }
      debugPrint(status.toString()); //Debug the choice in console
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      setState(() {
        status = widget.note.status;
        if (status == 0) {
          _radioValue = "Closed";
        } else if (status == 1) {
          _radioValue = "Open";
        }
        titleController.text = widget.note.title;
        descriptionController.text = widget.note.description;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.isEditing ? "Edit note:" : "New Note:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var image = await ImagePicker()
                            .getImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            file = File(image.path);
                          });
                        }
                      },
                      child: file == null && !widget.isEditing
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.15,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[800],
                                  ),
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image_search,
                                size: 30,
                              ))
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.15,
                              margin: EdgeInsets.all(5),
                              child: file == null
                                  ? Image.memory(widget.note.picture)
                                  : Image.file(file),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please type note\'s title';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey[400]),
                          ),
                          prefixIcon: Icon(Icons.title),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 5,
                            borderSide: new BorderSide(color: Colors.black),
                          ),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 22),
                          alignLabelWithHint: true,
                          labelText: 'Title',
                          hintText: "note title",
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        style: new TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Status:"),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Radio(
                            value: 'Open',
                            groupValue: _radioValue,
                            onChanged: radioButtonChanges,
                          ),
                          Text(
                            "Open",
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10)),
                          Radio(
                            value: 'Closed',
                            groupValue: _radioValue,
                            onChanged: radioButtonChanges,
                          ),
                          Text(
                            "Closed",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        controller: descriptionController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please type note\'s description';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.grey[400]),
                          ),
                          prefixIcon: Icon(Icons.title),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 5,
                            borderSide: new BorderSide(color: Colors.black),
                          ),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 10),
                          // alignLabelWithHint: true,
                          labelText: 'Description',
                          hintText: "note description",
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                        style: new TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  debugPrint(file.path);
                                  int result;
                                  Note note = Note(
                                      titleController.text,
                                      descriptionController.text,
                                      status,
                                      file.readAsBytesSync());

                                  if (widget.isEditing) {
                                    result = await Provider.of<HomeViewModel>(
                                            context,
                                            listen: false)
                                        .updateNote(note);
                                  } else {
                                    result = await Provider.of<HomeViewModel>(
                                            context,
                                            listen: false)
                                        .insertNote(note);
                                  }
                                  if (result != null) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Container(
                                width: 293,
                                height: 47,
                                child: Align(
                                    child: Text("Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ))),
                                decoration: BoxDecoration(
                                  color: Color(0xff2E3192),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
