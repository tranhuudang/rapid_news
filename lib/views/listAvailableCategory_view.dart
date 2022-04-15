import 'package:flutter/material.dart';
import 'package:rapid/helper/listCategory.dart';
import 'package:rapid/model/category_model.dart';
import 'listFoundedNews_view.dart';

class ListAvailableCategory extends StatefulWidget {
  const ListAvailableCategory({Key? key}) : super(key: key);

  @override
  State<ListAvailableCategory> createState() => _ListAvailableCategoryState();
}

class _ListAvailableCategoryState extends State<ListAvailableCategory> {
  List<CategoryModel> category = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    category = getCategories().cast<CategoryModel>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: category.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CategoryTile(
            imageUrl: category[index].imagePath,
            categoryName: category[index].categoryName,
          );
        },
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
                builder: (context) => ListFoundedNews(categoryName)));
      },
      child: Container(
        child: Stack(
          children: [
            Image.asset(
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
