import 'package:flutter/material.dart';

class AppTexts {
  static final TextStyle h4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xff08233d),
  );

  static final TextStyle h5 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff0e1d2c));

  static final TextStyle h6 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff0e1d2c));

  static final TextStyle h7 = TextStyle(
      fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xff3e5061));

  static final TextStyle p4 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff3e5061));
}

class EmptyVerticalBox extends StatelessWidget {
  final double height;
  EmptyVerticalBox({this.height = 20});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class EmptyHorizontalBox extends StatelessWidget {
  final double width;
  EmptyHorizontalBox({this.width = 20});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
