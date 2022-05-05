import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/object/article_model.dart';
import 'package:rapid/rapidProp.dart';
import 'package:http/http.dart' as http;
import 'package:rapid/pages/readingSpace_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadLines extends StatefulWidget {
  @override
  State<HeadLines> createState() => _HeadLinesState();
}

class _HeadLinesState extends State<HeadLines> {
  List<ArticleModel> listNewsInHome = <ArticleModel>[];
  bool _loading = true;
  bool _weatherLoading = true;

  getNews() async {
    ListNews listNews = ListNews(topic: "headlines");
    await listNews.getNews();
    listNewsInHome = listNews.listGotNews;
    setState(() {
      _loading = false;
    });
  }

  late PageController pageController = PageController();
  double pageOffSet = 0;

  String APIkey = RapidProp.weatherAPIkey;
  double temp = 0;
  String describeWeather = "";
  String district = "";

  void getWeather() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied)
      print("User not alow to access their location!");
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$APIkey&units=metric"));
    print(response.body);
    temp = jsonDecode(response.body)['main']['temp'];
    describeWeather = jsonDecode(response.body)['weather'][0]['description'];
    district = jsonDecode(response.body)['name'];
    // Save to prop
    RapidProp.weatherDistrict = district;
    RapidProp.weatherDescription = describeWeather;
    RapidProp.weatherTemp = temp.toString();
    setState(() {
      _weatherLoading = false;
      print("ok boy");
    });
  }

  int _currentPage=0;
  late Timer _timer;
  bool isBackward= false;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    pageController.addListener(() {
      setState(() {

        pageOffSet = pageController.page!;
        _currentPage= pageController.page!.toInt();
      });
    });
    if (RapidProp.weatherDistrict == "") {
      getWeather();
    }
    getNews();

    _timer = Timer.periodic(Duration(seconds: 6), (Timer timer)
    {
        if(!isBackward) {
          pageController.animateToPage(
            _currentPage++,
            duration: Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,);
        }
        else
          {
            pageController.animateToPage(
              _currentPage--,
              duration: Duration(milliseconds: 1500),
              curve: Curves.fastOutSlowIn,);
          }
        if((_currentPage==listNewsInHome.length-1)||(_currentPage==0))
          {
            isBackward=!isBackward;
          }
    },);
  }




  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _weatherLoading && RapidProp.weatherDistrict==""
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Today is a good day!",
                                  style: GoogleFonts.tinos(
                                      textStyle: TextStyle(
                                          fontSize: 20, color: RapidProp.darkMode? Colors.white54: Colors.black45)),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(RapidProp.weatherDistrict,
                                        style: GoogleFonts.tinos(
                                          textStyle: TextStyle(
                                            fontSize: 35,
                                            color:  RapidProp.darkMode? Colors.white70:Colors.black45,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      RapidProp.weatherTemp+ " °C",
                                      style: GoogleFonts.tinos(
                                          textStyle: TextStyle(
                                              fontSize: 20,
                                              color: RapidProp.darkMode? Colors.white54:Colors.black45)),
                                    ),
                                  ],
                                ),
                                Text(
                                  RapidProp.weatherDescription,
                                  style: GoogleFonts.tinos(
                                      textStyle: TextStyle(
                                          fontSize: 20, color: RapidProp.darkMode? Colors.white54:Colors.black45)),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Expanded(
                    flex: 12,
                    // height: MediaQuery.of(context).size.height,
                    //height: 500,
                    child: _loading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : PageView.builder(
                        controller: pageController,
                        itemCount: listNewsInHome.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReadingSpaceView(
                                          listNewsInHome[index].url,
                                          listNewsInHome[index].title)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: RapidProp.darkMode
                                            ? Colors.black
                                            : Colors.black26),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10))),
                                color: RapidProp.darkMode
                                    ? Colors.white10
                                    : Colors.white70,
                                elevation: 5,
                                shadowColor: Colors.black87,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        alignment: Alignment(
                                            -pageOffSet.abs() + index, 0),
                                        imageUrl:
                                            listNewsInHome[index].imageUrl,
                                        width: 400,
                                        height: 270,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: RapidProp.darkMode
                                            ? Colors.white10
                                            : Colors.black12,
                                      ),
                                    ),
                                    Positioned(
                                      top: 270,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          //color: Colors.black45,
                                          height: 100,
                                          width: 240,
                                          child: Text(
                                            listNewsInHome[index]
                                                        .title
                                                        .substring(
                                                            0,
                                                            listNewsInHome[
                                                                    index]
                                                                .title
                                                                .lastIndexOf(
                                                                    '-'))
                                                        .length >
                                                    100
                                                ? listNewsInHome[index]
                                                        .title
                                                        .substring(0, 80) +
                                                    ".."
                                                : listNewsInHome[index]
                                                    .title
                                                    .substring(
                                                        0,
                                                        listNewsInHome[index]
                                                            .title
                                                            .lastIndexOf('-')),
                                            style: GoogleFonts.tinos(
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: RapidProp.darkMode
                                                        ? Colors.white
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                      flex: 2,
                      child:Container(),)
                ],
              ),
            );
  }
}

