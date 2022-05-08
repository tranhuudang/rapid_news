import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/object/article_model.dart';
import 'package:rapid/rapidProp.dart';
import 'package:http/http.dart' as http;
import 'package:rapid/pages/readingSpace_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shake/shake.dart';
// this package control the vibration
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeadLines extends StatefulWidget {
  @override
  State<HeadLines> createState() => _HeadLinesState();
}

class _HeadLinesState extends State<HeadLines> {
  bool _weatherLoading = true;
  bool _loading = true;
  late ShakeDetector detector;
  double _pageOffSet=0;

  /// Get random quotation from HELPER
  //String randomQuote = Quotation().getRandomQuote();

  /// Get list new in HELPER
  List<ArticleModel> listNewsInHome = <ArticleModel>[];
  getNews() async {
    ListNews listNews = ListNews(topic: "headlines");
    await listNews.getNews();
    // Shuffle all the element inside list so we have a better experience when using the app. Because all the new always seem to look new :))
    listNews.listGotNews.shuffle();
    listNewsInHome = listNews.listGotNews;
    setState(() {
      _loading = false;
    });
  }

  /// Get weather base on current location
  String apiKey = RapidProp.weatherAPIkey;
  double temp = 0;
  String describeWeather = "";
  String district = "";

  void getWeather() async {
    // Request permission to access phone's location
    await Geolocator.requestPermission();
    Position location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric"));
    //print(response.body);
    temp = jsonDecode(response.body)['main']['temp'];
    describeWeather = jsonDecode(response.body)['weather'][0]['description'];
    district = jsonDecode(response.body)['name'];
    // Save to prop
    RapidProp.weatherDistrict = district;
    RapidProp.weatherDescription = describeWeather;
    RapidProp.weatherTemp = temp.toString();
    setState(() {
      _weatherLoading = false;
    });
  }

  /// Auto scroll page using timer and pageViewController
  late PageController pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  bool isBackward = false;

  void autoScrollPageView() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (!isBackward) {
          pageController.animateToPage(
            _currentPage++,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,
          );
        } else {
          pageController.animateToPage(
            _currentPage--,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,
          );
        }
        if ((_currentPage == listNewsInHome.length - 1) ||
            (_currentPage == 0)) {
          isBackward = !isBackward;
        }
      },
    );
  }

  void disableAutoScrollPageView() {
    if (_timer.isActive) _timer.cancel();
  }

  /// determine the phone shake and reload the page when the force equal to a value
  void enableDetermineShake() {
    detector = ShakeDetector.autoStart(
        minimumShakeCount: 3,
        shakeSlopTimeMS: 200,
        shakeCountResetTime: 2000,
        shakeThresholdGravity: 1.1,
        onPhoneShake: () {
          setState(() {
            HapticFeedback.vibrate();
            _loading = true;
            getNews();
            getWeather();
          });
        });
  }

  /// Initial State of this widget
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() {
        _pageOffSet = pageController.page!;
        _currentPage = pageController.page!.toInt();
      });
    });
    // If weatherDistrict blank, it means that the weather is never got. In other cases, we will load the got-weather to better performance.
    if (RapidProp.weatherDistrict == "") {
      getWeather();
    }
    getNews();
    autoScrollPageView();
    enableDetermineShake();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: _weatherLoading && RapidProp.weatherDistrict == ""
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [FaIcon(FontAwesomeIcons.cloudMoon)],
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(RapidProp.weatherDistrict,
                                style: GoogleFonts.tinos(
                                  textStyle: TextStyle(
                                    fontSize: 35,
                                    color: RapidProp.darkMode
                                        ? Colors.white70
                                        : Colors.black45,
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              RapidProp.weatherTemp + " °C",
                              style: GoogleFonts.tinos(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: RapidProp.darkMode
                                          ? Colors.white54
                                          : Colors.black45)),
                            ),
                          ],
                        ),
                        Text(
                          RapidProp.weatherDescription,
                          style: GoogleFonts.tinos(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: RapidProp.darkMode
                                      ? Colors.white54
                                      : Colors.black45)),
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
                : GestureDetector(
                    onTapDown: (value) {
                      disableAutoScrollPageView();
                    },
                    child: PageView.builder(
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
                                    side: BorderSide(
                                        color: RapidProp.darkMode
                                            ? Colors.black
                                            : Colors.black26),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                color: RapidProp.darkMode
                                    ? Colors.white10
                                    : Colors.white70,
                                elevation: 5,
                                shadowColor: Colors.black87,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        alignment: Alignment(-_pageOffSet.abs() + index,0),
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
                                        child: SizedBox(
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
          ),
          Expanded(flex: 2, child: Container())
        ],
      ),
    );
  }
}
