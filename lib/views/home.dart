import 'package:flutter/material.dart';

import '../helper/listNews.dart';
import '../helper/listCategory.dart';
import '../model/article_model.dart';
import '../model/category_model.dart';
import 'category_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> category = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    category = getCategories().cast<CategoryModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rapid",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Category
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              //margin: const EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: category.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    imageUrl: category[index].imageUrl,
                    categoryName: category[index].categoryName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Category Frame
class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Image.network(
                imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 120,
                fit: BoxFit.cover,
              ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
