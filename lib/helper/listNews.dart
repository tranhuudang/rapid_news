import 'dart:convert';

import '../model/article_model.dart';
import 'package:http/http.dart' as http;

class ListNews {
  ListNews({required this.topic});
  String topic;
  List<ArticleModel> listNews = <ArticleModel>[];
  Future<void> getNews() async {
    Uri sourceUrl=Uri.parse("https://newsapi.org/v2/everything?q="+topic+"&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f");

    var response = await http.get(sourceUrl);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if(element["urlToImage"]!= null && element["description"]!= null && element["content"]!=null && element["title"]!= null) {
          ArticleModel articleModel = ArticleModel(
               imageUrl: element["urlToImage"],
               title: element["title"],
               description: element["description"],
               content: element["content"],
                url: element["url"]);
          listNews.add(articleModel);
        }
      });
    }
  }
}
