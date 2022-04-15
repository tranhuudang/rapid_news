import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rapid/views/listAvailableCategory_view.dart';
import 'userSettings_view.dart';
import 'headline_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<CategoryModel> category = <CategoryModel>[];
  Widget currentView = HeadLines();

  @override
  void initState() {
    super.initState();
    // category = getCategories().cast<CategoryModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            Text(
              "Rapid",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Text(
              "News",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            /// Place to add page to Home
            ///
            ///
            Expanded(
              child: currentView,
            ),

            /// Bottom menu bar
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.bubble_chart),
                  onPressed: () {
                    setState(() {
                      currentView = HeadLines();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.view_module),
                  onPressed: () {
                    setState(() {
                      currentView = ListAvailableCategory();
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSettings()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
