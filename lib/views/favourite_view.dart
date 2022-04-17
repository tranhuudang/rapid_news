import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rapid/rapidProp.dart';
import 'package:rapid/views/readingSpace_view.dart';
import 'package:path_provider/path_provider.dart';
import '../model/favouriteSite_model.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

List<FavouriteSiteModel> listFavourite = [];

class _FavouriteState extends State<Favourite> {
  late File jsonFile;
  late Directory dir;
  String fileName = "favourite.json";
  bool fileExists = false;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) loadJsonToList();
    });
  }

  Future<void> loadJsonToList() async {
    Map<String, dynamic> jsonData = json.decode(jsonFile.readAsStringSync());
    // print(json.decode(jsonFile.readAsStringSync()));
    if (RapidProp.oldFavouriteList == {":":""}) {
      RapidProp.oldFavouriteList = jsonData;
      int index = 0;
      jsonData.forEach((title, url) {
        if (title != "" && url != "") {
          setState(() {
            FavouriteSiteModel favouriteItem =
                FavouriteSiteModel(title: title, url: url);
            listFavourite.add(favouriteItem);
          });
          index++;
        }
      });
    } else if (RapidProp.oldFavouriteList != jsonData) {
      RapidProp.oldFavouriteList = jsonData;
      listFavourite.clear();
      int index = 0;
      jsonData.forEach((title, url) {
        if (title != "" && url != "") {
          setState(() {
            FavouriteSiteModel favouriteItem =
                FavouriteSiteModel(title: title, url: url);
            listFavourite.add(favouriteItem);
          });
          index++;
        }
      });
    }
  }

  void removeItemInFavourite(String title, String url) {
    print("Removing item!");
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.removeWhere((key, value) => key == title);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
    }
    //print(fileContent);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: listFavourite.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(listFavourite[index].title),
              child: FavouriteTile(
                  title: listFavourite[index].title,
                  url: listFavourite[index].url),
              background: Container(
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      )),
                ),
                color: Colors.red,
              ),
              onDismissed: (direction) {
                listFavourite.removeAt(index);
                removeItemInFavourite(
                    listFavourite[index].title, listFavourite[index].url);
              },
            );
          },
        ));
  }
}

/// List Item model
class FavouriteTile extends StatelessWidget {
  FavouriteTile({required this.title, required this.url});
  String title, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReadingSpaceView(url, title)));
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: Colors.grey, width: 1.0, style: BorderStyle.solid),
        )),
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
