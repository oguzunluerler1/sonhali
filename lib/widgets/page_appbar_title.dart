import 'package:flutter/material.dart';

class PageAppBarTitle extends StatelessWidget {
  const PageAppBarTitle({
    Key? key, 
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style:TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
    );
  }
}