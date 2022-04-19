import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/model/article_model.dart';
import 'package:rapid/rapidProp.dart';
import 'package:rapid/views/readingSpace_view.dart';

class HeadLines extends StatefulWidget {
  @override
  State<HeadLines> createState() => _HeadLinesState();
}

class _HeadLinesState extends State<HeadLines> {
  List<ArticleModel> listNewsInHome = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    ListNews listNews = ListNews(topic: "headlines");
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
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(

      onRefresh: () async {
        setState(() {
          _loading=true;
          getNews();
        });

      },
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: listNewsInHome.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlogTile(
                        imageUrl: listNewsInHome[index].imageUrl,
                        title: listNewsInHome[index].title,
                        description: listNewsInHome[index].description,
                        url: listNewsInHome[index].url);
                  }),
            ),
        );
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
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: RapidProp.darkMode? Colors.white10: Colors.black12)),
          ),
          height: !RapidProp.dataSaver? 350: 130,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                !RapidProp.dataSaver? Expanded(
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
                ):Container(),
                // const SizedBox(
                //   height: 20,
                // ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 18),
                    ),
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
