import 'package:flutter/material.dart';

class SunLightPage extends StatelessWidget {
  final int value;

  const SunLightPage({key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sun light detection'),
        backgroundColor: Colors.yellow[600],
      ),
    );
  }}