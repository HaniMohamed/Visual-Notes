import 'dart:typed_data';

import 'package:facegraph_test/model/note.dart';
import 'package:facegraph_test/ui/screen/widget/new_note.dart';
import 'package:facegraph_test/ui/screen/widget/note_card.dart';
import 'package:facegraph_test/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ByteData imageData;
  List<Note> notes;

  getData() async {
    notes = await Provider.of<HomeViewModel>(context, listen: false).getNotes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Visual notes'),
      ),
      body: notes == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<HomeViewModel>(builder: (context, homeModel, child) {
              return homeModel.notes.length > 0
                  ? ListView.builder(
                      itemCount: homeModel.notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteCard(homeModel.notes[index]);
                      },
                    )
                  : Center(child: Text("no data available !"));
            }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isDismissible: true,
              isScrollControlled: true,
              enableDrag: true,
              builder: (context) {
                return NewNote();
              });
        },
      ),
    );
  }
}
