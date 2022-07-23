import 'package:flutter/material.dart';

class ProductLabelHeadline6 extends StatelessWidget {
  const ProductLabelHeadline6({
    Key? key,
    required this.text,
  }) : super(key: key);
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style:Theme.of(context).textTheme.headline6);
  }
}