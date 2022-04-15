import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'about_view.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text("User Settings", style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Data Saver"),
                subtitle: const Text("In this mode, we will not show up any images in articles."),
                onChanged: (value){
                  setState(() {
                    RapidProp.dataSaver= value;
                  });
                },
                value: RapidProp.dataSaver,
              ),
                  SwitchListTile(
                    title: const Text("Dark Mode"),

                    onChanged: (bool value) {
                      setState(() {
                        RapidProp.darkMode=value;
                      });
                    },
                    value: RapidProp.darkMode,
                  ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> About()));
                },
                child: ListTile(
                  title:  Text("About"),
                ),
              )
            ],
        ),
      ),
    );
  }
}
