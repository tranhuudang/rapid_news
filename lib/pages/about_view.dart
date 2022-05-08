import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rapid/rapidProp.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';


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


  final messengerUrl = Uri.parse('https://m.me/D11000111111101');
  final websiteUrl = Uri.parse('https://www.zeroclub.one');
  final githubUrl = Uri.parse('https://github.com/tranhuudang');

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
            style: GoogleFonts.tinos(textStyle:TextStyle(
              fontWeight: FontWeight.bold,
              color: RapidProp.darkMode
                  ? RapidProp.darkModeProp.appBarTextColor
                  : RapidProp.lightModeProp.appBarTextColor,
            ),),
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
                          child:  Text(
                            "Rapid",
                            style:GoogleFonts.tinos(textStyle: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 26,
                            ),),
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
                    Text("Version: " + _packageInfo.version, style: GoogleFonts.tinos(textStyle: TextStyle()),),
                    Text("Build: " + _packageInfo.buildNumber, style: GoogleFonts.tinos(textStyle: TextStyle()),),
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
                        style: GoogleFonts.tinos(textStyle:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children:  [
                            IconButton(icon: const FaIcon(FontAwesomeIcons.facebookMessenger), onPressed: () async {
                              if(await canLaunchUrl(messengerUrl))
                                {
                                  await launchUrl(messengerUrl, mode: LaunchMode.externalApplication);
                                }
                            },),
                            const SizedBox(width: 10,),
                            IconButton(icon: const Icon(Icons.language, size: 30,), onPressed: () async{
                              if(await canLaunchUrl(websiteUrl))
                              {
                              await launchUrl(websiteUrl, mode: LaunchMode.externalApplication);
                              }
                            },),
                            const SizedBox(width: 10,),
                            IconButton(icon: const FaIcon(FontAwesomeIcons.github), onPressed: () async  {
                              if(await canLaunchUrl(githubUrl))
                              {
                              await launchUrl(githubUrl, mode: LaunchMode.externalApplication);
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
               Expanded(
                flex: 1,
                child: Text(
                  "ZeroClub",
                  style: GoogleFonts.tinos(textStyle:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ));
  }
}
