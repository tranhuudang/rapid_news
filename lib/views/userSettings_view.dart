
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'about_view.dart';
import 'package:rapid/rapidProp.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {



  @override void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: RapidProp.darkMode? RapidProp.darkModeProp.appBarBackgroundColor: RapidProp.lightModeProp.appBarBackgroundColor,
        elevation: 0.5,
        title: Text(
          "User Settings",
          style: TextStyle(
            color:  RapidProp.darkMode? RapidProp.darkModeProp.appBarTextColor:RapidProp.lightModeProp.appBarTextColor,
        ),
        ),
        iconTheme: IconThemeData(
          color: RapidProp.darkMode? RapidProp.darkModeProp.appBarIconColor:RapidProp.lightModeProp.appBarIconColor,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ListTile(

              title: Text("Sign in"),
            ),
            SwitchListTile(

              title: Text("Data Saver",style: TextStyle(
              ),),
              subtitle: Text(
                  "In this mode, we will not show up any images in articles."),
              onChanged: (value) {
                setState(() {
                  RapidProp.dataSaver = value;
                });
              },
              value: RapidProp.dataSaver,
            ),
            SwitchListTile(
              title: Text("Dark Mode"),
              onChanged: (bool value) {
                setState(() {
                  RapidProp.darkMode = value;
                  RapidProp.settings.setDarkMode(value);
                });
              },
              value: RapidProp.darkMode,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
              child: ListTile(
                title: Text("About"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
