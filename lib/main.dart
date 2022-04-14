import 'package:flutter/material.dart';
import 'views/home.dart';
import 'views/category_news.dart';
import 'views/article_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) =>const Home(),
        '/read': (context) => const ArticalView(),
      },
      title: 'Rapid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}