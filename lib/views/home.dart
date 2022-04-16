import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rapid/views/listAvailableCategory_view.dart';
import 'userSettings_view.dart';
import 'headline_view.dart';
import 'package:shimmer/shimmer.dart';

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
          children: [
            Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.black,
              period: const Duration(seconds: 30),
              loop: 10,
              enabled: true,
              child: const Text(
                "Rapid",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const Text(
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
            icon: const Icon(Icons.search),
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
                  icon: const Icon(Icons.bubble_chart),
                  onPressed: () {
                    setState(() {
                      currentView = HeadLines();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.view_module),
                  onPressed: () {
                    setState(() {
                      currentView = const ListAvailableCategory();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle),
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
