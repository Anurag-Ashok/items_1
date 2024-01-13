import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:items_1/firebase_options.dart';
import 'package:items_1/firstPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: firstPage(),
  ));
}
