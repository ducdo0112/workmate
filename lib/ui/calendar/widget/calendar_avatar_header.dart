import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CalendarAvatarHeader extends StatelessWidget {
  final String imageBase64;

  const CalendarAvatarHeader({
    Key? key,
    required this.imageBase64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    ImageProvider image;
    if (imageBase64.isNotEmpty) {
      Uint8List bytes = base64Decode(imageBase64);
      image = MemoryImage(bytes);
    } else {
      image = Image.asset('asset/images/icon/avatar_default.png').image;
    }

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 45,
          height: 45,
          child: Container(),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: color,
        all: 3,
        child: buildCircle(
          color: color,
          all: 3,
          child: const SizedBox(),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
