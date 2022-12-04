import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        //*Leading
        leading: IconButton(
            onPressed: () {
              onPressed:
              {}
              //Todo Function
            },
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(78, 58, 48, 29),
            )),
        //* Title
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Nour",
            style: TextStyle(
              color: Color.fromARGB(255, 34, 26, 23),
              fontFamily: "Dancing Script",
              fontSize: 40,
            ),
          ),
        ),
        //*  Action ,
        actions: [
          IconButton(
              onPressed: () {
                //todo  Function
              },
              icon: const Icon(
                Icons.search_outlined,
                color: Color.fromARGB(78, 58, 48, 29),
              )),
          IconButton(
              onPressed: () {
                /*  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
            */
              },
              //todo  Function

              icon: const Icon(Icons.notifications,
                  color: Color.fromARGB(78, 58, 48, 29))),
          IconButton(
              onPressed: () {
                //todo  Function
              },
              icon: const Icon(Icons.message_rounded,
                  color: Color.fromARGB(78, 58, 48, 29)))
        ],
      ),
      body: const Center(child: Text("AppBar")),
    );
  }
}
