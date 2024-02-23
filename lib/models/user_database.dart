import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mini_notes/models/note.dart';
import 'package:mini_notes/models/user.dart';
import 'package:path_provider/path_provider.dart';

class UserDB extends ChangeNotifier{
  static late Isar isar;

  //INITIALIZE
  static Future<void> initialize() async{
    final dir = await getApplicationCacheDirectory();
    print(dir.path);
    isar = await Isar.open([UserSchema,NoteSchema], directory: dir.path);
  }

  // list user
  final List<User> currentUser = [];

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
    print(currentUser);
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