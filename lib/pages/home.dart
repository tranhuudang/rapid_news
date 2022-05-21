
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'package:rapid/pages/favourite_view.dart';
import 'package:rapid/pages/listAvailableCategory_view.dart';
import 'userSettings_view.dart';
import 'headline_view.dart';
import 'package:shimmer/shimmer.dart';
import 'search_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget currentView = HeadLines();
  //Color headLineButton

  @override
  void initState() {
    super.initState();
  }



  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(backPressedTime);
        if (difference >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: 'Press back again to exit', fontSize: 14);
          backPressedTime = DateTime.now();
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
        },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: RapidProp.darkMode
              ? RapidProp.darkModeProp.appBarBackgroundColor
              : RapidProp.lightModeProp.appBarBackgroundColor,
          title: Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: RapidProp.darkMode
                    ? RapidProp.darkModeProp.logoNameBaseColor
                    : RapidProp.lightModeProp.logoNameBaseColor,
                period: const Duration(seconds: 3),
                loop: 3,
                enabled: true,
                child:  Text(
                  "Rapid",
                  style: GoogleFonts.tinos(
                    textStyle:TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  )),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    child: Text(
                      "News",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          elevation: 0.3,
          //backgroundColor: Colors.white,
          iconTheme: const IconThemeData(),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  currentView = const Search();
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            /// Place to add page to Home
            ///
            ///
            Expanded(
              child: currentView,
            ),

            /// Bottom menu bar
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color:
                          RapidProp.darkMode ? Colors.white10 : Colors.black12),
                ),
              ),
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        currentView = HeadLines();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.square_split_2x2),
                    onPressed: () {
                      setState(() {
                        currentView = const ListAvailableCategory();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        currentView = const Favourite();
                      });
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}
