import 'package:flutter/material.dart';

class BuildError extends StatelessWidget {
  final String? error;
  const BuildError({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error ?? 'Error fetching data!'),
    );
  }
}
