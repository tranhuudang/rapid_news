import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rapid/rapidProp.dart';

class ReadingSpaceView extends StatefulWidget {
  ReadingSpaceView(this.url);
  final String url;
  //const ArticleView({Key? key}) : super(key: key);

  @override
  State<ReadingSpaceView> createState() => _ReadingSpaceViewState();
}

class _ReadingSpaceViewState extends State<ReadingSpaceView> {

  @override
  Widget build(BuildContext context) {
    int zoomFactor= 100;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
            IconButton(icon: const Icon(Icons.zoom_in), onPressed: () {
              setState(() {
                zoomFactor+= 10;
              });
            },),
            IconButton(icon: const Icon(Icons.zoom_out), onPressed: () {  },),

        ],
      ),
      body: Container(
            child: InAppWebView(
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(),
                  ios: IOSInAppWebViewOptions(),
                  android: AndroidInAppWebViewOptions(
                    useHybridComposition: true,
                    forceDark: RapidProp.darkMode? AndroidForceDark.FORCE_DARK_ON: AndroidForceDark.FORCE_DARK_OFF ,
                  )),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.url),
              ),
            ),
          ),
    );
  }
}
