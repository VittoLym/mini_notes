import 'package:flutter/material.dart';
import 'package:mini_notes/components/text_box.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  
  @override
  void initState(){
    super.initState();

    readUsers();
  }

  //log in & save user
  void createUser(){

  }

  //read user 
  void readUsers(){

  }



  Future<void> editField(String fiel) async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 6.0),
            child: const Icon(
            Icons.more_vert_outlined,
            size: 32,
            ),
          ),
        ],
        title: const Text('PROFILE'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),

          //profile picture
          Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 84,
            ),

          const SizedBox(height: 10,),

          // user Email
          Text(
            'juanperez@gmail.com',
            textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            
          const SizedBox(height: 50,),
          
          //user detail
          const Padding(
            padding:  EdgeInsets.only(left: 25),
            child: Text('My details'),
          ),
          MyTextBox(sectionName: 'Username:', text: 'Fito Paez', onPressed: () =>editField('username'),),
          MyTextBox(sectionName: 'Email:', text: 'fp@gmail.com', onPressed: () =>editField('Email'),)
        ],
      )
    );
  }
}