import 'package:flutter/material.dart';

class MySquareTile extends StatelessWidget {
  final String imgPath;
  const MySquareTile({
    super.key,
    required this.imgPath
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.background),
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primary
      ),
      child: Image.asset(
        imgPath,
        height: 40,

        ),
    );
  }
}