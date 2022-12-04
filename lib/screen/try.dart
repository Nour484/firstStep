import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTrying extends StatefulWidget {
  const MyTrying({super.key});

  @override
  State<MyTrying> createState() => _MyTryingState();
}

class _MyTryingState extends State<MyTrying> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(showPassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
            obscureText: showPassword,
          ),
        ),
      ),
    );
  }
}
