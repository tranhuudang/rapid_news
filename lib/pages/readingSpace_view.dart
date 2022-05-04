import 'dart:async';
import 'dart:ui';
import 'package:clipboard_monitor/clipboard_monitor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rapid/rapidProp.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:rapid/blockAdsModule/hostList.dart';
import 'package:translator/translator.dart';

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
  late Map<String, dynamic> fileContent;
  bool websiteLoading = true;
  bool _isHearted = false;
  final translator = GoogleTranslator();
  bool isBottomSheetOpen = false;

  /// Timer = 10 so CircularProgressIndicator is only allowed to run on 10 second
  late Timer _timer;

  /// Initial State of ReadingSpace Widget
  @override
  void initState() {
    super.initState();
    // Monitor Clipboard to get selected text
    RapidProp.translator
        ? ClipboardMonitor.registerCallback(onClipboardChanged)
        : print("not enable translator");
    // Get local document directory to open or save hearted page in it
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      fileContent = json.decode(jsonFile.readAsStringSync());
      if (fileContent.containsKey(widget.title)) {
        setState(() {
          _isHearted = true;
        });
      }
    });

    // Timer for loading icon automatically close after 10 seconds
    timerStart();
  }

  /// Other function
  void onClipboardChanged(String textInClipBoard) {
    // Because we have an error here and this app will try to open more than one bottomSheet,
    // so we need this "isBottomSheetOpen" to make sure that we only open one bottomSheet at a time.
    if (!isBottomSheetOpen) translateBox(context, textInClipBoard);
    isBottomSheetOpen = true;
  }

  double bottomSheetHeight = 200;

  @override
  void dispose() {
    ClipboardMonitor.unregisterCallback(onClipboardChanged);
    super.dispose();
  }

  /// Translate procedure and bottomSheet
  void translateBox(context, String rawText) async {
    var translatedText =
        await translator.translate(rawText, from: 'auto', to: 'vi');
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Definitions",
                      style: TextStyle(
                          color: RapidProp.darkMode
                              ? Colors.white54
                              : Colors.black45),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SingleChildScrollView(
                    child: Center(
                      child: Text(
                        // Upper case the first letter
                        translatedText
                                .toString()
                                .substring(0, 1)
                                .toUpperCase() +
                            translatedText
                                .toString()
                                .substring(1, translatedText.toString().length),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).whenComplete(() => isBottomSheetOpen = false);
  }

  /// Force to stop loading indicator after 10 seconds
  void timerStart() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (websiteLoading == true) {
        setState(() {
          websiteLoading = false;
        });
      }
      _timer.cancel();
    });
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

  void removeItemInFavourite(String title, String url) {
    if (fileExists) {
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.removeWhere((key, value) => key == title);

      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    }
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
                  /// reload button
                  color: RapidProp.darkMode
                      ? RapidProp.darkModeProp.appBarIconColor
                      : RapidProp.lightModeProp.appBarIconColor,
                  icon: Icon(Icons.restart_alt),
                  onPressed: () {
                    setState(() {
                      websiteLoading = true;
                      reloadWebsite();
                    });
                  },
                ),
          IconButton(
            /// heart button
            color: _isHearted
                ? Colors.red
                : RapidProp.darkMode
                    ? RapidProp.darkModeProp.appBarIconColor
                    : RapidProp.lightModeProp.appBarIconColor,
            icon: Icon(_isHearted ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _isHearted = !_isHearted;
              });
              if (_isHearted) {
                writeToFile(widget.title, widget.url);
              } else {
                removeItemInFavourite(widget.title, widget.url);
              }
              ;
            },
          ),
          IconButton(
            /// reload button
            color: RapidProp.darkMode
                ? RapidProp.darkModeProp.appBarIconColor
                : RapidProp.lightModeProp.appBarIconColor,
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.url);
            },
          ),
        ],
      ),
      body: Container(
        child: InAppWebView(
          androidShouldInterceptRequest: (controller, request) async {
            List<String> adblockList = HostList.urls;
            var url = request.url.toString();
            var i = 0;
            while (i < adblockList.length) {
              if (url.contains(adblockList.elementAt(i))) {
                return WebResourceResponse();
              }
              i++;
            }
          },
          onLoadStop: (controller, url) {
            setState(() {
              websiteLoading = false;
            });
          },
          onWebViewCreated: ((controller) {
            _controller = controller;
          }),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(

                /// Javascript disable will block pop up
                javaScriptEnabled: RapidProp.javaScriptEnabled,
                ),
            ios: IOSInAppWebViewOptions(),
            android: AndroidInAppWebViewOptions(
              /// Intercept while loading a url to fill out unwanted content ex: ads ( enabled when readingMode enabled )
              useShouldInterceptRequest: RapidProp.readingMode,
              useHybridComposition: true,
              forceDark: RapidProp.darkMode
                  ? AndroidForceDark.FORCE_DARK_ON
                  : AndroidForceDark.FORCE_DARK_OFF,
              blockNetworkImage: RapidProp.dataSaver ? true : false,
            ),
          ),
          initialUrlRequest: URLRequest(
              url: Uri.parse(widget.url.contains("http")
                  ? (widget.url.contains("https")
                      ? widget.url
                      : widget.url.replaceAll("http://", "https://"))
                  : "https://" + widget.url)),
        ),
      ),
    );
  }
}
