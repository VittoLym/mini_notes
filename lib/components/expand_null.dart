import 'package:flutter/material.dart';
import 'package:mini_notes/components/note_tiles.dart';
import 'package:mini_notes/models/note.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:provider/provider.dart';

class MyExpandNull extends StatefulWidget {
  final noteNull;
  const MyExpandNull({
    super.key,
    this.noteNull
    });

  @override
  State<MyExpandNull> createState() => _MyExpandNullState();
}

class _MyExpandNullState extends State<MyExpandNull> {
  
  final textController = TextEditingController();
  //delete a note
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNotes(id);
  }
  //update a note
  void updateNote(Note note) {
    //pre-fill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Update Note'),
        content: TextField(controller: textController),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                //Cancel butto
                onPressed: () {
                //clear contoller
                  textController.clear();
                //pop dialog box
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
                ),
                // update button
                MaterialButton(
                onPressed: () {
                 //update note in db
                  context
                    .read<NoteDatabase>()
                    .updateNotes(note.id, textController.text);
                //clear contoller
                  textController.clear();
                //pop dialog box
                  Navigator.pop(context);
                },
                child: const Text('Update'),
                ),
              ],
          )
        ],
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ListView.builder(
              itemCount: widget.noteNull.length,
              itemBuilder: (context, index) {
                //get individual note
                final noteList = widget.noteNull[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NoteTile(
                    text: noteList.text,
                    onEditPressed: () => updateNote(noteList),
                    onDeletePressed: () => deleteNote(noteList.id)  ,
                    ),
                  ],
                );
              }
            ),
          );
  }
}