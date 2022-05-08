import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late bool darkMode;
  late bool dataSaver;
  late bool readingMode;
  late bool translator;
  late bool javaScript;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  loadSettings() async {
    // load up Settings to app
    darkMode = await RapidProp.settings.getDarkMode();
    dataSaver = await RapidProp.settings.getDataSaver();
    readingMode = await RapidProp.settings.getReadingMode();
    translator = await RapidProp.settings.getTranslator();
    javaScript = await RapidProp.settings.getJavaScriptEnabled();
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center()
         : MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
      },
      title: 'Rapid',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: darkMode? Brightness.dark: Brightness.light,
      ),
      themeMode: darkMode? ThemeMode.dark: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// this one use to restart application by wrap it outside a wanted-to-restart-widget
class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}




