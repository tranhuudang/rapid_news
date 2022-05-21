import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rapid/helper/listCategory.dart';
import 'package:rapid/object/category_model.dart';
import 'package:rapid/pages/readingSpace_view.dart';
import 'package:rapid/rapidProp.dart';
import 'listFoundedNews_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rapid/object/favouriteWebsite_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ListAvailableCategory extends StatefulWidget {
  const ListAvailableCategory({Key? key}) : super(key: key);

  @override
  State<ListAvailableCategory> createState() => _ListAvailableCategoryState();
}

class _ListAvailableCategoryState extends State<ListAvailableCategory> {
  List<CategoryModel> category = <CategoryModel>[];
  late File jsonFile;
  late Directory dir;
  String fileName = "favouriteWebsite.json";
  bool fileExists = false;
  late File fileWebsite;
  List<FavouriteWebsiteModel> listFavourite = [];
  @override
  void initState() {
    super.initState();
    category = getCategories().cast<CategoryModel>();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      if (jsonFile.existsSync()) loadJsonToList();
    });
  }

  Future<void> loadJsonToList() async {
    Map<String, dynamic> jsonData = json.decode(jsonFile.readAsStringSync());
    if (RapidProp.oldWebsiteList == {"": ""}) {
      RapidProp.oldWebsiteList = jsonData;
      jsonData.forEach((title, url) {
        if (title != "" && url != "") {
          setState(() {
            FavouriteWebsiteModel favouriteItem =
                FavouriteWebsiteModel(title: title, url: url);
            listFavourite.add(favouriteItem);
          });
        }
      });
    } else if (RapidProp.oldWebsiteList != jsonData) {
      RapidProp.oldWebsiteList = jsonData;
      listFavourite.clear();
      jsonData.forEach((title, url) {
        if (title != "" && url != "") {
          setState(() {
            FavouriteWebsiteModel favouriteItem =
                FavouriteWebsiteModel(title: title, url: url);
            listFavourite.add(favouriteItem);
          });
        }
      });
    }
  }

  List<WebsiteTile> returnFavouriteWebsite() {
    List<WebsiteTile> outputList = [];
    for (var element in listFavourite) {
      outputList.add(WebsiteTile(title: element.title, url: element.url));
    }
    return outputList;
  }

  List<Widget> returnCategory() {
    List<Widget> outputList = [];
    for (var element in category) {
      outputList.add(CategoryTile(
          imageUrl: element.imagePath, categoryName: element.categoryName));
    }

    return outputList;
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    File file = File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      createFile(content, dir, fileName);
    }
  }

  final titleTextController = TextEditingController();
  final urlTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                    "Favourite Publishers",
                    style:TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 12,
                  children: returnFavouriteWebsite()),

              /// Default add button to add more website to the page
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: (context),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                     Expanded(
                                      flex: 3,
                                      child: Text(
                                          "Add your favourite publisher here, so we never miss anything interesting", style:TextStyle(fontSize: 15)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          listFavourite.add(
                                              FavouriteWebsiteModel(
                                                  title:
                                                      titleTextController.text,
                                                  url: urlTextController.text));
                                        });
                                        writeToFile(titleTextController.text,
                                            urlTextController.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Add"),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: titleTextController,
                                  decoration: const InputDecoration(
                                    labelText: "Title",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: urlTextController,
                                  decoration: const InputDecoration(
                                    labelText: "URL",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Text("Add a website"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                    "Categories",
                    style:TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
         Column(
            children: returnCategory(),

        ),
      ],
    );
  }
}

class WebsiteTile extends StatelessWidget {
  final String title, url;
  WebsiteTile({required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadingSpaceView(url, title)));
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: CachedNetworkImage(
                  imageUrl: "https://www.google.com/s2/favicons?sz=128&domain_url=" + url,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover, errorWidget: (BuildContext context,
                      String exception, dynamic stackTrace) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: Container(
                    color: Colors.white,
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.public,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                );
              }),
            ),
            Text(title)
          ],
        ));
  }
}

/// Category Frame
class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({required this.imageUrl, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 6, right: 15, bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListFoundedNews(categoryName)));
          },
          child: Stack(
            children: [
              Image.asset(
                imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 70,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40),
                height: 70,
                decoration: BoxDecoration(
                  color: RapidProp.darkMode? Colors.black54: Colors.black26,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  categoryName,
                  style: GoogleFonts.tinos( textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
