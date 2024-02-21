import 'package:mini_notes/components/drawer_tile.dart';
import 'package:mini_notes/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
        //header
        const DrawerHeader(
          child:Icon(Icons.edit)
        ),

        const SizedBox(height: 25,),
        //list note
        DrawerTile(
          title: 'Notes', 
          leading: const Icon(Icons.home), 
          onTap: () =>Navigator.pop(context),
          ),
        //list settings
        DrawerTile(
          title: 'Settings', 
          leading: const Icon(Icons.settings), 
          onTap: () =>{
            Navigator.pop(context),
            Navigator.push(context, 
              MaterialPageRoute(
              builder: (context) => const SettingsPage(),
              )
            )
          }
        )
      ],
      ),
    );
  }
}