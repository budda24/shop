import 'package:flutter/material.dart';

class CircularndIcator extends StatelessWidget {
  const CircularndIcator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}