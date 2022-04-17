import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool darkMode;
  bool loadSetting = true;
  @override
  void initState() {
    super.initState();
    load();
    print("load");
  }

  load() async {
    darkMode = await RapidProp.settings.getDarkMode();
    setState(() {
      loadSetting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadSetting
        ? const Center()
        : darkMode
            ? MainDarkApp()
            : MainLightApp();
  }
}

class MainDarkApp extends StatelessWidget {
  const MainDarkApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
      title: 'Rapid',
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Colors.black,
      // ),

      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme,
     ThemeMode.light for light theme,
     ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainLightApp extends StatelessWidget {
  const MainLightApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
      title: 'Rapid',
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Colors.black,
      // ),

      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      /* ThemeMode.system to follow system theme,
     ThemeMode.light for light theme,
     ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
    );
  }
}
