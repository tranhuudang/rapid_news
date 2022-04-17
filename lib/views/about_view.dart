import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rapid/rapidProp.dart';

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
  void initState(){
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
          title: const Text("About"),
          backgroundColor: RapidProp.darkMode? RapidProp.darkModeProp.appBarBackgroundColor: RapidProp.lightModeProp.appBarBackgroundColor,
          elevation: 0.5,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      child: Image.asset(
                        "resources/images/rapid.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children:[
                        Text(
                          "Rapid",
                          style: TextStyle(
                            color: RapidProp.darkMode? RapidProp.darkModeProp.logoNameBaseColor:RapidProp.lightModeProp.logoNameBaseColor,
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
                    Text("Version: "+ _packageInfo.version),
                    Text("Build: "+ _packageInfo.buildNumber),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Author: Tran Huu Dang"),
                       Text("Email: tranhuudang127@gmail.com"),
                       Text("Website: www.zeroclub.one"),
                    ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "ZeroClub",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }
}
