

import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/model/article_model.dart';
import 'package:rapid/views/readingSpace_view.dart';
///https://newsapi.org/v2/everything?q=computer&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f for everything
///https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f for headline only
class ListFoundedNews extends StatefulWidget {
  const ListFoundedNews(this.searchTopic) ;
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
    listNewsInHome = listNews.listNews;
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
          backgroundColor: Colors.blue,
          title: Text(widget.searchTopic),
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
      {Key? key, required this.imageUrl, required this.title, required this.description, required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ReadingSpaceView(url)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 400,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
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
