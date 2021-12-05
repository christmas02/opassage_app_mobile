import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}

Color violet = getColorFromHex('#8a0cbf');
Color jaune = getColorFromHex('#F1FE00');
Color blanc = getColorFromHex('#FDFFFD');
Color gris = getColorFromHex('#919190');
Color noir = Colors.black;
