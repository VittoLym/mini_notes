import 'package:flutter/material.dart';
import 'package:mini_notes/components/log/my_button.dart';
import 'package:mini_notes/components/log/my_textfield.dart';
import 'package:mini_notes/components/log/square_tile.dart';
import 'package:mini_notes/models/note_database.dart';
import 'package:mini_notes/models/user.dart';
import 'package:mini_notes/pages/login_page.dart';
import 'package:mini_notes/pages/perfil_page.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class MySigninPage extends StatefulWidget {
  const MySigninPage({super.key});

  @override
  State<MySigninPage> createState() => _MySigninPageState();
}

class _MySigninPageState extends State<MySigninPage> {
  
  bool isEmail = true;

  bool isUser = true;

  bool isPassword = true;

  final unController = TextEditingController();

  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  @override
  void initState(){
    super.initState();
    readUser();
  }

  void signUp() {
    readUser();
    if(unController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty){
      if(unController.text.isEmpty){
        isUser = false;
        Vibration.vibrate(duration: 500, amplitude: 128);
      }
      if(emailController.text.isEmpty){
        isEmail = false;
        Vibration.vibrate(duration: 500, amplitude: 128);
      }
      if(passwordController.text.isEmpty){
        isPassword = false;
        Vibration.vibrate(duration: 500, amplitude: 128);
      }
      return;
    }
    List<User> users =  context.read<NoteDatabase>().currentUser;
    if(users.isEmpty){
      if(unController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
        List<String> ctl = unController.text.split(' ');
        context.read<NoteDatabase>().addUser(ctl[0], emailController.text,passwordController.text);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => PerfilPage(data: ctl[0], email: emailController.text,)                
            )
          );
      }
    }
    if(users.isNotEmpty){
      List<User> isCreated = users.where((u) => u.email!.toLowerCase() == emailController.text.toLowerCase()).toList();
      if(isCreated.isEmpty){
        //there is not match to db
        List<String> ctl = unController.text.split(' ');
        context.read<NoteDatabase>().addUser(ctl[0].trim(), emailController.text,passwordController.text);
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => PerfilPage(data: ctl[0], email: emailController.text,)                
            )
          );
      }
      else{
        isEmail= false;
        emailController.clear();
        unController.clear();
        passwordController.clear();
      }
    }
  }

  void readUser(){
    context.read<NoteDatabase>().fetchUser();
  }
  
  
  @override
  Widget build(BuildContext context) {

    context.watch<NoteDatabase>();
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Icon(
                  Icons.lock_open, 
                  size: 100, 
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 50,),
                Text(
                  'Welcome new user!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16
                    ),
                  ),
                const SizedBox(height: 25,),
                MyTextfield(
                  controller: unController,
                  hintText: 'Username',
                  obscureText: false,
                  validate: isUser,
                  onValidationChanged: (newValue){
                    setState((){
                        isUser = newValue;
                    });
                  }
                ),
                const SizedBox(height: 10,),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  validate: isEmail,
                    onValidationChanged: (newValue){
                    setState((){
                        isEmail = newValue;
                    });
                  }
                  ),
                const SizedBox(height: 10,),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validate: isPassword,
                    onValidationChanged: (newValue){
                    setState((){
                        isPassword= newValue;
                    });
                  }
                  ),
                const SizedBox(height: 25,),
                MyButton(onTap: signUp, text: 'Sign Up'),
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
                const SizedBox(height: 40,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySquareTile(imgPath: 'lib/image/google.png'),
                    SizedBox(width: 25,),
                    MySquareTile(imgPath: 'lib/image/apple.png')
                  ]),
                  
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Are you already register?'),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => const MyLoginPage()                
                          )
                        );
                      },
                      child: const Text(
                        'Login Now', 
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                          )
                        ),
                    )
                  ],
                )
                ])
              )
            )
          )
        );
  }
}