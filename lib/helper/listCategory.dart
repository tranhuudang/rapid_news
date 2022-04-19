import 'package:rapid/model/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category= <CategoryModel>[];
  CategoryModel categoryModel= CategoryModel();

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Art";
  categoryModel.imagePath = "resources/images/art.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imagePath = "resources/images/business.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Books";
  categoryModel.imagePath = "resources/images/book.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imagePath = "resources/images/entertainment.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Fitness";
  categoryModel.imagePath = "resources/images/fitness.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.imagePath = "resources/images/general.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imagePath = "resources/images/health.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Movies";
  categoryModel.imagePath = "resources/images/movie.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Music";
  categoryModel.imagePath = "resources/images/music.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Photography";
  categoryModel.imagePath = "resources/images/photography.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imagePath = "resources/images/technology.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Security";
  categoryModel.imagePath = "resources/images/security.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imagePath = "resources/images/science.jpg";
  category.add(categoryModel);

  categoryModel = CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imagePath = "resources/images/sports.jpg";
  category.add(categoryModel);

  return category;
}