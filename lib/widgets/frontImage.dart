import 'package:flutter/material.dart';

class FrontImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/logo.png'),
    );
  }
}
