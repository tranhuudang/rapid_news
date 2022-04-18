import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rapid/rapidProp.dart';

import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ReadingSpaceView extends StatefulWidget {
  ReadingSpaceView(this.url, this.title);
  final String url;
  final String title;
  //const ArticleView({Key? key}) : super(key: key);

  @override
  State<ReadingSpaceView> createState() => _ReadingSpaceViewState();
}

class _ReadingSpaceViewState extends State<ReadingSpaceView> {
  late File jsonFile;
  late Directory dir;
  String fileName = "favourite.json";
  bool fileExists = false;
  Map<String, dynamic>? fileContent;
  bool websiteLoading = true;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
    });
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    print(fileContent);
  }

  late InAppWebViewController _controller;
  void reloadWebsite() {
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: RapidProp.darkMode
              ? RapidProp.darkModeProp.appBarIconColor
              : RapidProp.lightModeProp.appBarIconColor,
        ),
        backgroundColor: RapidProp.darkMode
            ? RapidProp.darkModeProp.appBarBackgroundColor
            : RapidProp.lightModeProp.appBarBackgroundColor,
        actions: [
          websiteLoading
              ? const SizedBox(
                  width: 56,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  ))
              : IconButton(
                  color: RapidProp.darkMode
                      ? RapidProp.darkModeProp.appBarIconColor
                      : RapidProp.lightModeProp.appBarIconColor,
                  icon: Icon(Icons.restart_alt),
                  onPressed: () {
                    setState(() {
                      websiteLoading = false;
                      reloadWebsite();
                    });
                  },
                ),
          IconButton(
            color: RapidProp.darkMode
                ? RapidProp.darkModeProp.appBarIconColor
                : RapidProp.lightModeProp.appBarIconColor,
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              writeToFile(widget.title, widget.url);
            },
          ),
        ],
      ),
      body: Container(
        child: InAppWebView(
          onProgressChanged: (controller, percent){
            if(percent==0)
              {
                websiteLoading = false;
              }
          },
          onLoadStop: (controller, url) {
            setState(() {

            });
          },
          onWebViewCreated: ((controller) {
            _controller = controller;
          }),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(),
            ios: IOSInAppWebViewOptions(),
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
              forceDark: RapidProp.darkMode
                  ? AndroidForceDark.FORCE_DARK_ON
                  : AndroidForceDark.FORCE_DARK_OFF,
              blockNetworkImage: RapidProp.dataSaver ? true : false,
            ),
          ),
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.url),
          ),
        ),
      ),
    );
  }
}
