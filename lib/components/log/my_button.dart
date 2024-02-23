import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {

  final Function()? onTap;
  final String text;

  MyButton({
    super.key,
    required this.onTap,
    required this.text
    });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool button = true;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 200),
      builder: (context, opacityValue, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 25.0, end: button ? 25.0 : 40.0),
          duration: Duration(milliseconds: 200),
          builder: (context, sizeValue, child) {
            return GestureDetector(
              onTap: widget.onTap,
              onTapDown: (details) {
                setState(() {
                  button = false;
                });
              },
              onTapUp: (details) {
                setState(() {
                  button = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: sizeValue),
                decoration: BoxDecoration(
                  color: button
                      ? Theme.of(context).colorScheme.primary.withOpacity(opacityValue)
                      : Theme.of(context).colorScheme.inversePrimary.withOpacity(opacityValue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: button
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}