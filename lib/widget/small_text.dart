import 'package:flutter/material.dart';
class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  TextOverflow overflow;
  SmallText({Key? key, required this.text,  this.color, this.size=14,this.overflow=TextOverflow.ellipsis
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: size
      ),
    );
  }
}
