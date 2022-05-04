import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rapid/rapidProp.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: RapidProp.darkMode
                ? RapidProp.darkModeProp.appBarIconColor
                : RapidProp.lightModeProp.appBarIconColor,
          ),
          title: Text(
            "About",
            style: TextStyle(
              color: RapidProp.darkMode
                  ? RapidProp.darkModeProp.appBarTextColor
                  : RapidProp.lightModeProp.appBarTextColor,
            ),
          ),
          backgroundColor: RapidProp.darkMode
              ? RapidProp.darkModeProp.appBarBackgroundColor
              : RapidProp.lightModeProp.appBarBackgroundColor,
          elevation: 0.5,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          child: const Text(
                            "Rapid",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
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
                    Text("Version: " + _packageInfo.version),
                    Text("Build: " + _packageInfo.buildNumber),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  //padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Text(
                        "Tran Huu Dang",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children:  [
                            IconButton(icon: FaIcon(FontAwesomeIcons.facebookMessenger), onPressed: () async {
                              if(await canLaunch("https://www.messenger.com/t/2839082629435553/"))
                                {
                                  await launch("https://www.messenger.com/t/2839082629435553/");
                                }
                            },),
                            SizedBox(width: 10,),
                            IconButton(icon: Icon(Icons.language, size: 30,), onPressed: () async{
                              if(await canLaunch("https://zeroclub.one"))
                              {
                              await launch("https://zeroclub.one");
                              }
                            },),
                            SizedBox(width: 10,),
                            IconButton(icon: FaIcon(FontAwesomeIcons.github), onPressed: () async  {
                              if(await canLaunch("https://github.com/tranhuudang"))
                              {
                              await launch("https://github.com/tranhuudang");
                              }
                            },),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "ZeroClub",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
}
