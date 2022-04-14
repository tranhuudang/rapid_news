import 'package:rapid/model/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category= <CategoryModel>[];
  CategoryModel categoryModel= CategoryModel();

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Art";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/art.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Books";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/book.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/entertainment.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Movies";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/movie.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Music";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/music.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Photography";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/photography.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/technology.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Security";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/security.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Fitness";
  categoryModel.imageUrl = "http://zeroclub.one/Rapid/images/fitness.jpg";
  category.add(categoryModel);

  return category;
}