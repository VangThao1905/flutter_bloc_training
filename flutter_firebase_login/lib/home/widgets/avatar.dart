import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _avatarSize = 48.0;

class Avatar extends StatelessWidget {
  Avatar({Key? key, required this.photo}) : super(key: key);

  String? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null
          ? Icon(Icons.percent_outlined, size: _avatarSize)
          : null,
    );
  }
}
