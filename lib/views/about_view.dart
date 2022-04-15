import 'dart:ui';

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.5 ,
      ),
      body: Center(
        child: Column(
          children:[
            Image.asset("resources/images/rapid.png"),
            Text("Rapid News"),

          ],
        ),),
    );
  }
}
