import 'dart:ui';
import 'package:rapid/main.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: RapidProp.darkMode
            ? RapidProp.darkModeProp.appBarBackgroundColor
            : RapidProp.lightModeProp.appBarBackgroundColor,
        elevation: 0.5,
        title: Text(
          "User Settings",
          style: TextStyle(
            color: RapidProp.darkMode
                ? RapidProp.darkModeProp.appBarTextColor
                : RapidProp.lightModeProp.appBarTextColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: RapidProp.darkMode
              ? RapidProp.darkModeProp.appBarIconColor
              : RapidProp.lightModeProp.appBarIconColor,
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
              title: Text(
                "Always open sites in Reading Mode",
                style: TextStyle(),
              ),
              subtitle: Text(
                  "Unfamiliar contents will be filtered out to keep you focus on the road."),
              onChanged: (value) {
                setState(() {

                });
              },
              value: false,
            ),
            SwitchListTile(
              secondary: Icon(Icons.data_saver_on),
              title: Text(
                "Data Saver",
                style: TextStyle(),
              ),
              subtitle: Text(
                  "In this mode, we will not show up any images in articles."),
              onChanged: (value) {
                setState(() {
                  RapidProp.dataSaver = value;
                  RapidProp.settings.setDataSaver(value);
                });
              },
              value: RapidProp.dataSaver,
            ),
            SwitchListTile(
              title: const Text("Dark Mode"),
              onChanged: (bool value) {
                final snackBar = SnackBar(
                  duration: Duration(seconds: 10),
                  content: const Text("Do you want to apply it now?"),
                  action: SnackBarAction(
                    label: 'Apply',
                    onPressed: () {
                      RestartWidget.restartApp(context);
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
