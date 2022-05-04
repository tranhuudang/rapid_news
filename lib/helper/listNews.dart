import 'dart:convert';

import '../object/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class ListNews {
  ListNews({required this.topic});
  String topic;
  int oldRandomNumber=0;
  List<String> availableCategory = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
  ];
  Random randomChoice= Random();

  List<ArticleModel> listGotNews = <ArticleModel>[];
  Future<void> getNews() async {
    int randomNumber = randomChoice.nextInt(availableCategory.length-1);
    Uri sourceUrl;
    if(topic=="headlines") {
      sourceUrl = Uri.parse("https://saurav.tech/NewsAPI/top-headlines/category/"+availableCategory[randomNumber]+"/us.json");
    }
    else if(availableCategory.contains(topic.toLowerCase()))
      {
        sourceUrl = Uri.parse("https://saurav.tech/NewsAPI/top-headlines/category/"+topic.toLowerCase()+"/us.json");
      }
    else {
      sourceUrl = Uri.parse("https://newsapi.org/v2/everything?q=" + topic +
          "&apiKey=6e9d9069fd6d4fad98e12e7e08d4967f");
    }

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
          listGotNews.add(articleModel);
        }
      });
    }
  }
}
