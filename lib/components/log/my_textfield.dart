import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final  TextEditingController controller;
  final String hintText;
  final bool obscureText;
  bool validate;
  final ValueChanged<bool> onValidationChanged;

  
  MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validate,
    required this.onValidationChanged
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  onChanged: (text) {
                  Future.delayed(const Duration(milliseconds: 100),(){
                    onValidationChanged(true);
                  });
                  
                  },
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: validate ? Theme.of(context).colorScheme.secondary : Colors.red
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:validate ? Theme.of(context).colorScheme.inversePrimary : Colors.red)
                      ),
                    fillColor: Theme.of(context).colorScheme.primary,
                    filled: true,
                    hintText: hintText, hintStyle: TextStyle(color: validate ? Theme.of(context).colorScheme.secondary : Colors.red),
                  ),
                ),
              );
  }
}