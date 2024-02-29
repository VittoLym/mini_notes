import 'package:isar/isar.dart';
import 'package:mini_notes/models/user.dart';

part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
  late String user;
}