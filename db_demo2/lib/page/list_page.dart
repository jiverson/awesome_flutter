import 'package:flutter/material.dart';
import 'package:dbdemo2_app/main.dart';
import 'package:dbdemo2_app/model/model.dart';
import 'package:dbdemo2_app/page/edit_page.dart';
import 'package:dbdemo2_app/page/note_page.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'NotePad sqflite',
      )),
      body: StreamBuilder<List<DbNote?>>(
        stream: noteProvider.onNotes(),
        builder: (context, snapshot) {
          var notes = snapshot.data;
          if (notes == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                var note = notes[index]!;
                return ListTile(
                  title: Text(note.title.v ?? ''),
                  subtitle: note.content.v?.isNotEmpty ?? false
                      ? Text(LineSplitter.split(note.content.v!).first)
                      : null,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NotePage(
                        noteId: note.id.v,
                      );
                    }));
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditNotePage(
              initialNote: null,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
