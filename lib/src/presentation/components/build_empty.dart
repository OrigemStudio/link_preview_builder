import 'package:flutter/material.dart';

class BuildEmpty extends StatelessWidget {
  const BuildEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Don´t have data!'),
    );
  }
}
