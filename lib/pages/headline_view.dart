import 'package:flutter/material.dart';
import 'package:rapid/helper/listNews.dart';
import 'package:rapid/object/article_model.dart';
import 'package:rapid/rapidProp.dart';
import 'package:rapid/pages/readingSpace_view.dart';

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
                    return index==0? BlogTile(
                        imageUrl: listNewsInHome[index].imageUrl,
                        title: listNewsInHome[index].title,
                        description: listNewsInHome[index].description,
                        url: listNewsInHome[index].url):
                    SmallBlogTile(
                        imageUrl: listNewsInHome[index].imageUrl,
                        title: listNewsInHome[index].title,
                        description: listNewsInHome[index].description,
                        url: listNewsInHome[index].url)
                    ;
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
    // Remove publisher name out of title
    String titleWithoutPublisher;
    titleWithoutPublisher= title.substring(0,title.lastIndexOf('-'));
    if(titleWithoutPublisher.length>100)
    {
      titleWithoutPublisher= titleWithoutPublisher.substring(0,80)+"...";
    }
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
                      titleWithoutPublisher,
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
/// Article Small Size Frame
class SmallBlogTile extends StatelessWidget {
  final String imageUrl, description, title, url;
  const SmallBlogTile(
      {Key? key,
        required this.imageUrl,
        required this.title,
        required this.description,
        required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   String titleWithoutPublisher;
   titleWithoutPublisher= title.substring(0,title.lastIndexOf('-'));
   if(titleWithoutPublisher.length>100)
     {
       titleWithoutPublisher= titleWithoutPublisher.substring(0,80)+"..";
     }
   print(titleWithoutPublisher);
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
          height: !RapidProp.dataSaver? 100: 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
            child: Row(
              children: [
                !RapidProp.dataSaver? Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ):Container(),
                // const SizedBox(
                //   height: 20,
                // ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      titleWithoutPublisher,
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
