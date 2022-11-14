// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:HPCS_app/Pages/landing.dart';

final FlutterBlue flutterBlue = FlutterBlue.instance;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Home Plant Care',
        home: LandingPage(),
        debugShowCheckedModeBanner: false);
  }
}

