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
    district = jsonDecode(response.body)['sys'][0]['name'];
    // Save to prop
    RapidProp.weatherDistrict = district;
    RapidProp.weatherDescription = describeWeather;
    RapidProp.weatherTemp = temp.toString();
    setState(() {
      _weatherLoading = false;
      print("ok boy");
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() {
        pageOffSet = pageController.page!;
      });
    });
    if (RapidProp.weatherDistrict == "") {
      getWeather();
    }
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _loading = true;
                getNews();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: /* _weatherLoading? Container (
                      child: CircularProgressIndicator(),
                    ): */
                        Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Da Lat",
                                  style: GoogleFonts.tinos(
                                    textStyle: TextStyle(
                                      fontSize: 35,
                                      color: Colors.black45,
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "16.71 °C",
                                style: GoogleFonts.tinos(
                                    textStyle: TextStyle(
                                        fontSize: 20, color: Colors.black45)),
                              ),
                            ],
                          ),
                          Text(
                            "overcast clouds",
                            style: GoogleFonts.tinos(
                                textStyle: TextStyle(
                                    fontSize: 20, color: Colors.black45)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    // height: MediaQuery.of(context).size.height,
                    //height: 500,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: listNewsInHome.length,
                        //shrinkWrap: true,
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
                                side:new  BorderSide(color: Colors.black),
                              borderRadius: new BorderRadius.all(new Radius.circular(10))),
                          color: RapidProp.darkMode
                              ? Colors.white10
                              : Colors.black12,
                                  elevation: 6,
                                  shadowColor: Colors.black,
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
                          // ):
                          // SmallBlogTile(
                          //     imageUrl: listNewsInHome[index].imageUrl,
                          //     title: listNewsInHome[index].title,
                          //     description: listNewsInHome[index].description,
                          //     url: listNewsInHome[index].url)
                          // ;
                        }),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image.asset(
                        "resources/images/bottomLine.png",
                        scale: 3,
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}

// /// Article Frame
// class BlogTile extends StatelessWidget {
//   final String imageUrl, description, title, url; final int index;
//   const BlogTile(
//       {Key? key,
//       required this.imageUrl,
//       required this.title,
//       required this.description,
//       required this.url, required this.index})
//       : super(key: key);
//   @override
//
//   Widget build(BuildContext context) {
//     // Remove publisher name out of title
//     String titleWithoutPublisher;
//     titleWithoutPublisher= title.substring(0,title.lastIndexOf('-'));
//     if(titleWithoutPublisher.length>100)
//     {
//       titleWithoutPublisher= titleWithoutPublisher.substring(0,80)+"...";
//     }
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ReadingSpaceView(url, title)));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 1),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(bottom: BorderSide(color: RapidProp.darkMode? Colors.white10: Colors.black12)),
//           ),
//           height: !RapidProp.dataSaver? 350: 130,
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               children: [
//                 !RapidProp.dataSaver? Expanded(
//                   flex: 3,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: CachedNetworkImage(
//                       alignment: Alignment(-pageOffSet.abs()+ index,0),
//                       imageUrl: imageUrl,
//                       width: 400,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ):Container(),
//                 // const SizedBox(
//                 //   height: 20,
//                 // ),
//                 Expanded(
//                   flex: 1,
//                   child: Center(
//                     child: Text(
//                       titleWithoutPublisher,
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// /// Article Small Size Frame
// class SmallBlogTile extends StatelessWidget {
//   final String imageUrl, description, title, url;
//   const SmallBlogTile(
//       {Key? key,
//         required this.imageUrl,
//         required this.title,
//         required this.description,
//         required this.url})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//    String titleWithoutPublisher;
//    titleWithoutPublisher= title.substring(0,title.lastIndexOf('-'));
//    if(titleWithoutPublisher.length>100)
//      {
//        titleWithoutPublisher= titleWithoutPublisher.substring(0,80)+"..";
//      }
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ReadingSpaceView(url, title)));
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 1),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(bottom: BorderSide(color: RapidProp.darkMode? Colors.white10: Colors.black12)),
//           ),
//           height: !RapidProp.dataSaver? 100: 100,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
//             child: Row(
//               children: [
//                 !RapidProp.dataSaver? Expanded(
//                   flex: 2,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: CachedNetworkImage(
//                       imageUrl: imageUrl,
//                       width: 120,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ):Container(),
//                 // const SizedBox(
//                 //   height: 20,
//                 // ),
//                 const SizedBox(width: 10,),
//                 Expanded(
//                   flex: 3,
//                   child: Center(
//                     child: Text(
//                       titleWithoutPublisher,
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
