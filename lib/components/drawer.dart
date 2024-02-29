import 'package:mini_notes/components/drawer_tile.dart';
import 'package:mini_notes/models/note.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:mini_notes/models/user.dart';
import 'package:mini_notes/pages/login_page.dart';
import 'package:mini_notes/pages/notes_page.dart';
import 'package:mini_notes/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/perfil_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  void initState(){
    super.initState();

    isUser();
  }

  late bool conditions;
  late List<User> isCreated;
  late List<Note> notes; 
  void isUser(){
      context.read<NoteDatabase>().fetchUser();
      List<User> users =  context.read<NoteDatabase>().currentUser;
      if(users.isNotEmpty){
        isCreated = users.where((u)=>u.token != ' ').toList();
        
        if(isCreated.isNotEmpty){
        conditions = true;
        }
        else{
          conditions = false;
        }
      }
      else {
        conditions = false;
        return;
      }
    }
  void logout(){
    if(isCreated.isNotEmpty){
    notes = context.read<NoteDatabase>().currentNotes;
    context.read<NoteDatabase>().updateUser(isCreated[0].id, token: ' ');
    Navigator.pop(context);
    Navigator.push(context,
      MaterialPageRoute(builder:
        (context)=> const NotesPage()
        )
      );
    }
    else{
    Navigator.pop(context);
    Navigator.push(context,
      MaterialPageRoute(builder:
        (context)=> const NotesPage()
        )
      );
    }
  }
  @override
  Widget build(BuildContext context){
    isUser();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          children: [
          //header
          DrawerHeader(
            child:Icon(Icons.person,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 64,
            )
          ),

          const SizedBox(height: 25,),
        
          //list note
          DrawerTile(
            title: 'H O M E', 
            leading: const Icon(Icons.home), 
            onTap: () =>Navigator.pop(context),
          ),
          //list perfil
          DrawerTile(
            title:'P R O F I L E',
            leading: const Icon(Icons.person),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => conditions ?  PerfilPage(data: isCreated[0].name! , email: isCreated[0].email!) : const MyLoginPage()                
                )
              )
            }
          ),
          //list settings
          DrawerTile(
            title: 'S E T T I N G S', 
            leading: const Icon(Icons.settings), 
            onTap: () =>{
              Navigator.pop(context),
              Navigator.push(context, 
                MaterialPageRoute(
                builder: (context) => const SettingsPage(),
                )
              )
            }
          ),
          ],
        ),
        // list Logout
        DrawerTile(
          title: 'L O G O U T',
          leading: const Icon(Icons.logout),
          onTap: logout
          )
      ],
      ),
    );
  }
}