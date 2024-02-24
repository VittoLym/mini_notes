import 'package:mini_notes/components/drawer_tile.dart';
import 'package:mini_notes/pages/login_page.dart';
import 'package:mini_notes/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../pages/perfil_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
    bool conditions = false;
  @override
  Widget build(BuildContext context){
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
                  builder: (context) => conditions ? const PerfilPage(data: 'Drawer', email: 'DrawerEmail',) : const MyLoginPage()                
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
          onTap: ()=>{}
          )
      ],
      ),
    );
  }
}