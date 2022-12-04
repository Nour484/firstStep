import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningfirebase/widget/my_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
