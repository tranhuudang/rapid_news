import 'dart:ui';
import 'package:flutter/material.dart';
import '../helper/listCategory.dart';
import '../model/category_model.dart';
import 'category_news.dart';
import 'user_view.dart';

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
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            Text(
              "Rapid",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Text(
              "News",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            /// Category
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListView.builder(
                      itemCount: category.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: category[index].imageUrl,
                          categoryName: category[index].categoryName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom menu bar
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.bubble_chart),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.view_module),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserView()));
                  },
                ),
              ],
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(categoryName)));
      },
      child: Container(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 120,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.only(left: 40),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              alignment: Alignment.centerLeft,
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
