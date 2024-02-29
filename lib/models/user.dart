import 'package:isar/isar.dart';
import 'package:mini_notes/models/note.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  
  String? name;
  
  String? email;

  String? password;

  String? token;
  
  List<String>? userNotes;

}
