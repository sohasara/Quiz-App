class CategoryModel {
  final String name;
  final String imageurl;
  final String apiurl;
  CategoryModel({
    required this.name,
    required this.imageurl,
    required this.apiurl,
  });
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: 'Sports',
    imageurl: 'assets/football.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=21&difficulty=medium',
  ),
  CategoryModel(
    name: 'Math',
    imageurl: 'assets/math.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=19&difficulty=medium',
  ),
  CategoryModel(
    name: 'Flims',
    imageurl: 'assets/film.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=11&difficulty=hard&type=multiple',
  ),
  CategoryModel(
    name: 'Geography',
    imageurl: 'assets/geo.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=22&difficulty=medium',
  ),
  CategoryModel(
    name: 'GK',
    imageurl: 'assets/gk.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=multiple',
  ),
  CategoryModel(
    name: 'Politic',
    imageurl: 'assets/politic.png',
    apiurl:
        'https://opentdb.com/api.php?amount=10&category=24&difficulty=medium&type=multiple',
  ),
];
