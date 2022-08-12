import 'package:flutter/material.dart';
import 'package:teste_pokedex/constants/colors.dart';

Widget TextComponent(String text, {
  Color textColor = colorWhite,
  double fontSize = 18,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w500,
}) {
  return Text(text,
    style: TextStyle(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
    ),
    textAlign: textAlign,
    softWrap: true,
  );
}