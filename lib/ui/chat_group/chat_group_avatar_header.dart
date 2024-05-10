import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ChatGroupAvatarHeader extends StatelessWidget {
  final String imageBase64;
  final bool isEdit;
  final VoidCallback onClicked;
  final String status;

  const ChatGroupAvatarHeader(
      {Key? key,
      required this.imageBase64,
      this.isEdit = false,
      required this.onClicked,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = status == "Online" ? Colors.green : Colors.grey;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
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
          child: InkWell(onTap: onClicked),
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
