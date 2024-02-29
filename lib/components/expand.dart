import 'package:flutter/material.dart';
import 'package:mini_notes/components/note_tiles.dart';
import 'package:mini_notes/models/note.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:provider/provider.dart';

class MyExpand extends StatefulWidget {
  final userNotes2;
  
  MyExpand({
    super.key,
    this.userNotes2,
    });

  @override
  State<MyExpand> createState() => _MyExpandState();
}

class _MyExpandState extends State<MyExpand> {

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
    return 
          Expanded(
            child: ListView.builder(
              itemCount: widget.userNotes2.length,
              itemBuilder: (context, index) {
                //get individual note
                final noteList = widget.userNotes2[index];
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