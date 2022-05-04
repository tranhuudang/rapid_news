
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
            const ListTile(
              title: Text("Sign in"),
            ),
            SwitchListTile(
              title: const Text(
                "Always open sites in Reading Mode",
                style: TextStyle(),
              ),
              subtitle: const Text(
                  "Unfamiliar contents will be filtered out to keep you focus on the road."),
              onChanged: (value) {
                setState(() {
                  RapidProp.readingMode = value;
                  RapidProp.settings.setReadingMode(value);
                });
              },
              value: RapidProp.readingMode,
            ),
            SwitchListTile(
              //secondary: const Icon(Icons.translate),
              title: const Text(
                "Enable JavaScript",
                style: TextStyle(),
              ),
              subtitle: const Text(
                  "This will allow sites fully function. But sometimes quite annoy with pop-ups and alerts conquer our views."),
              onChanged: (value) {
                setState(() {
                  RapidProp.javaScriptEnabled = value;
                  RapidProp.settings.setJavaScriptEnabled(value);
                });
              },
              value: RapidProp.javaScriptEnabled,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.translate),
              title: const Text(
                "Translator",
                style: TextStyle(),
              ),
              subtitle: const Text(
                  "Instantly translate after copy."),
              onChanged: (value) {
                setState(() {
                  RapidProp.translator = value;
                  RapidProp.settings.setTranslator(value);
                });
              },
              value: RapidProp.translator,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.data_saver_on),
              title: const Text(
                "Data Saver",
                style: TextStyle(),
              ),
              subtitle: const Text(
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
                  duration: const Duration(seconds: 10),
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
              child: const ListTile(
                title: Text("About"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
