import 'package:mini_notes/components/drawer.dart';
import 'package:mini_notes/components/note_tiles.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller
  final textController = TextEditingController();


  @override
  void initState(){
    super.initState();

    readNotes();
  }
  // create a note
  void createNote(){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
      title: const Text('Create Note'),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: TextField(
      controller: textController,
      ),
    actions:
    [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          MaterialButton(
          //cancel button
            onPressed: () {
          // clear controller
            textController.clear();
          // pop dialog box
            Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
      
          // create button
          MaterialButton(
            onPressed: () {
            // add to db
            context.read<NoteDatabase>().addNote(textController.text);
            // clear controller
            textController.clear();
            // pop dialog box
            Navigator.pop(context);
          },
          child: const Text('Create'),
          )
        ],
      )
    ],
    ),
  );
  }
  // read a note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
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
  //delete a note
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNotes(id);
  }

  @override
  Widget build(BuildContext context){
  //note db
  final noteDatabase = context.watch<NoteDatabase>();

  //current notes
  List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNote,
        child:  Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //heading
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Text(
              'Notes', 
              style: GoogleFonts.dmSerifText(
                fontSize:48,
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            ),
          ),
          //list of notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                //get individual note
                final note = currentNotes [index];
            
                //list tile UI
                return NoteTile(
                  text: note.text,
                  onEditPressed: ()=> updateNote(note),
                  onDeletePressed: ()=> deleteNote(note.id),
                  );
              }
            ),
          ),
        ],
      ),
    );
  }
}