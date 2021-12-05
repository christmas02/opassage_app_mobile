import 'package:flutter/material.dart';

Widget buildImage(String urlImage, int index) => Container(
    color: Colors.grey, child: Image.network(urlImage, fit: BoxFit.cover));
