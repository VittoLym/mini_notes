import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  
  String? name;
  
  String? email;

  String? password;

  String? token;
}