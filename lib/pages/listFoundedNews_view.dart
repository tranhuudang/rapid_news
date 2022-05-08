import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/object/article_model.dart';
import 'package:rapid/pages/readingSpace_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../rapidProp.dart';
import 'package:google_fonts/google_fonts.dart';


//https://newsapi.org/v2/everything?q=computer&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f for everything
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f for headline only
class ListFoundedNews extends StatefulWidget {
  const ListFoundedNews(this.searchTopic);
  final String searchTopic;
  //const CategoryNews({Key? key}) : super(key: key);

  @override
  State<ListFoundedNews> createState() => _ListFoundedNewsState();
}

class _ListFoundedNewsState extends State<ListFoundedNews> {
  List<ArticleModel> listNewsInHome = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    ListNews listNews = ListNews(topic: widget.searchTopic);
    await listNews.getNews();
    // Shuffle all the element inside list so we have a better experience when using the app. Because all the new always seem to look new :))
    listNews.listGotNews.shuffle();
    listNewsInHome = listNews.listGotNews;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: RapidProp.darkMode
              ? RapidProp.darkModeProp.appBarBackgroundColor
              : RapidProp.lightModeProp.appBarBackgroundColor,
          elevation: 0.5,
          title: Text(
            widget.searchTopic,
            style: TextStyle(
              color: RapidProp.darkMode
                  ? RapidProp.darkModeProp.appBarTextColor
                  : RapidProp.lightModeProp.appBarTextColor,
            ),
          ),
          iconTheme: IconThemeData(
            color: RapidProp.darkMode
                ? RapidProp.darkModeProp.appBarIconColor
                : RapidProp.lightModeProp.appBarIconColor,
          ),
        ),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: listNewsInHome.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlogTile(
                          imageUrl: listNewsInHome[index].imageUrl,
                          title: listNewsInHome[index].title,
                          description: listNewsInHome[index].description,
                          url: listNewsInHome[index].url);
                    }),
              ));
  }
}

/// Article Frame
class BlogTile extends StatelessWidget {
  final String imageUrl, description, title, url;
  const BlogTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReadingSpaceView(url, title)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
          height: !RapidProp.dataSaver? 350: 130,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                !RapidProp.dataSaver?  Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 400,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ): Container (),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: GoogleFonts.tinos(textStyle: TextStyle(fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
