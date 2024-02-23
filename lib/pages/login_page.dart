import 'package:flutter/material.dart';
import 'package:mini_notes/components/log/my_button.dart';
import 'package:mini_notes/components/log/my_textfield.dart';
import 'package:mini_notes/components/log/square_tile.dart';

class MyLoginPage extends StatelessWidget {
  MyLoginPage({super.key});

  //text edit controller
  final usernameControlller = TextEditingController();
  final passwordController = TextEditingController();

  void singUserIn() {

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
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
                controller: usernameControlller,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10,),
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
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

              MyButton(onTap: singUserIn,),

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  SizedBox(width: 4,),
                  Text(
                    'Register Now', 
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                      )
                    )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}