import 'dart:io';

import 'package:flutter/material.dart';

Widget getImagePreview(String uri) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    clipBehavior: Clip.hardEdge,
    child: Image.file(
      File(uri),
      fit: BoxFit.fill,
      height: 100,
      width: 90,

    ),
  );
}
