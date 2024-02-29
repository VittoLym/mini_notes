import 'package:flutter/material.dart';
import 'package:mini_notes/components/log/my_button.dart';
import 'package:mini_notes/components/log/my_textfield.dart';
import 'package:mini_notes/components/log/square_tile.dart';
import 'package:mini_notes/models/note.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:mini_notes/models/user.dart';
import 'package:mini_notes/pages/perfil_page.dart';
import 'package:mini_notes/pages/signin_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}


class _MyLoginPageState extends State<MyLoginPage> {
  //text edit controller
  final unController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmail = true;
  bool isPassword = true;
  late String nameUser ;


  @override
  void initState(){
    super.initState();

    readUser();
  }

  void signUserIn() {
    readUser();
      List<User> users =  context.read<NoteDatabase>().currentUser;
      List<Note> notes = context.read<NoteDatabase>().currentNotes;
      if(unController.text.isEmpty){
        isEmail = false;
        Vibration.vibrate(duration:500, amplitude: 128);
      }
      if(passwordController.text.isEmpty){
        isPassword= false;
        Vibration.vibrate(duration:500, amplitude: 128);
      }
      if(users.isEmpty && unController.text.isNotEmpty && passwordController.text.isNotEmpty){
        Navigator.pop(context);
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) =>  const MySigninPage()                
            )
        );
      }
      if(users.isNotEmpty){
        List<User> isUsere = users.where((u)=> u.email!.toLowerCase() == unController.text.toLowerCase()).toList();
        List<User> isUserpw = users.where((i)=> i.password == passwordController.text).toList();
          
        if(isUsere.isEmpty && unController.text.isNotEmpty && passwordController.text.isNotEmpty){
          Navigator.pop(context);
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) =>  const MySigninPage()                
            )
          );
        }
        if(isUsere.isEmpty) {
          isEmail = false;
          unController.clear();
          Vibration.vibrate(duration:500, amplitude: 128);
        }
        if(isUserpw.isEmpty){
          isPassword = false;
          passwordController.clear();
          Vibration.vibrate(duration:500, amplitude: 128);
        }
        if(isUsere.isNotEmpty && isUserpw.isNotEmpty){
          nameUser = isUsere[0].name!;
          String v5 = const  Uuid().v5(Uuid.NAMESPACE_URL, isUsere[0].name);
          context.read<NoteDatabase>().updateUser(isUsere[0].id, token: v5, );
          Navigator.pop(context);
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) =>  PerfilPage(data: nameUser ,email: unController.text,)                
            )
          );
        }
      }
  }

  void readUser(){
    context.read<NoteDatabase>().fetchUser();
    
  }
  @override
  Widget build(BuildContext context) {

    context.watch<NoteDatabase>();

    return  Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Icon(
                  Icons.lock, 
                  size: 100, 
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 50,),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16
                    ),
                  ),
                const SizedBox(height: 25,),
                MyTextfield(
                  controller: unController,
                  hintText: 'Email',
                  obscureText: false,
                  validate: isEmail,
                  onValidationChanged: (newValue){
                    setState((){
                        isEmail= newValue;
                    });
                  }
                ),
                const SizedBox(height: 10,),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password' ,
                  obscureText: true,
                  validate: isPassword,
                  onValidationChanged: (newValue){
                    setState((){
                      isPassword = newValue;
                    });
                  }
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?', 
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                      ,),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25,),
          
                MyButton(onTap: signUserIn, text: 'Sign in',),
          
                const SizedBox(height: 50,),
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child:Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        ), 
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or continue with',
                        style:TextStyle(color: Theme.of(context).colorScheme.inversePrimary) 
                        ,),
                      ),
                  
                      Expanded(
                        child:Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        ), 
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySquareTile(imgPath: 'lib/image/google.png'),
          
                    SizedBox(width: 25,),
                    
                    MySquareTile(imgPath: 'lib/image/apple.png')
                  ],
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => const MySigninPage()                
                          )
                        );
                      },
                      child: const Text(
                        'Register Now', 
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                          )
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}