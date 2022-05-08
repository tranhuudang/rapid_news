import 'package:rapid/main.dart';
import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'about_view.dart';
import 'package:google_fonts/google_fonts.dart';

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
          style: GoogleFonts.tinos(
            textStyle: TextStyle(
              color: RapidProp.darkMode
                  ? RapidProp.darkModeProp.appBarTextColor
                  : RapidProp.lightModeProp.appBarTextColor,
            ),
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
              title: Text("Sign in" ,style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18, color: Colors.black26)),),
            ),
            SwitchListTile(
              title: Text(
                "Always open sites in Reading Mode",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
              ),
              subtitle: Text(
                "Unfamiliar contents will be filtered out to keep you focus on the road.",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 16)),
              ),
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
              title: Text(
                "Enable JavaScript",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
              ),
              subtitle: Text(
                "This will allow sites fully function. But sometimes quite annoy with pop-ups and alerts conquer our views.",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 16)),
              ),
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
              title: Text(
                "Translator",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
              ),
              subtitle: Text(
                "Instantly translate after copy.",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 16)),
              ),
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
              title: Text(
                "Data Saver",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
              ),
              subtitle: Text(
                "In this mode, we will not show up any images in articles.",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 16)),
              ),
              onChanged: (value) {
                setState(() {
                  RapidProp.dataSaver = value;
                  RapidProp.settings.setDataSaver(value);
                });
              },
              value: RapidProp.dataSaver,
            ),
            SwitchListTile(
              title: Text(
                "Dark Mode",
                style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
              ),
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
              child: ListTile(
                title: Text(
                  "About",
                  style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
