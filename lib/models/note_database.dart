import 'package:mini_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mini_notes/models/user.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // INICIALIZE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema,UserSchema], directory: dir.path);
  }
  //List notes
  final List<Note> currentNotes = [];

    // list user
  final List<User> currentUser = [];


  //CREATE (create and save notes to db)
  Future<void> addNote(String textFromUser) async {

  //create a new note object
  final newNote = Note()..text = textFromUser;

  //save to db
  await isar.writeTxn(() => isar.notes.put(newNote));

  // re-read from db
  fetchNotes();
  }

  //READ
  Future<void> fetchNotes() async{
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes); 
    notifyListeners();
  }

  //UPDATE
  Future<void> updateNotes(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE
  Future<void> deleteNotes(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }

  // CREATE user & save to db
  Future<void> addUser(String name, String email, String password) async{
    
    final newuser = User()
      ..name = name
      ..email = email
      ..password = password;

    await isar.writeTxn(() => isar.users.put(newuser));

      fetchUser();
  }

  //READ users
  Future<void> fetchUser() async{
    List<User> fetchedUsers = await isar.users.where().findAll();
    currentUser.clear();
    currentUser.addAll(fetchedUsers);
    notifyListeners();
  }

  //UPDATE user
  Future<void> updateUser(int id, {String? name, String? email, String? password}) async{
    final existingUser = await isar.users.get(id);
    if(existingUser != null){
      if(name != null){
        existingUser.name = name;
      }
      if(email != null){
        existingUser.email = email;
      }
      if(password != null){
        existingUser.password = password;
      }
      await isar.writeTxn(() => isar.users.put(existingUser));
      await fetchUser();
    }
  }

  //DELETE user
  Future<void> deleteUser(int id) async{
    await isar.writeTxn(() => isar.users.delete(id));
    fetchUser();
  }
}
