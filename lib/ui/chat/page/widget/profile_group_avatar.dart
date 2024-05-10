import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ProfileGroupAvatar extends StatelessWidget {
  final String imageBase64;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileGroupAvatar({
    Key? key,
    required this.imageBase64,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    ImageProvider image;
    if(imageBase64.isNotEmpty) {
      Uint8List bytes = base64Decode(imageBase64);
      image = MemoryImage(bytes);
    }else {
      image = Image.asset('asset/images/icon/avatar_default.png').image;
    }

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image:  image,
          fit: BoxFit.cover,
          width: 57,
          height: 57,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: GestureDetector(
        onTap: onClicked,
        child: Icon(
          isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
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