import 'package:hacker_news/article.dart';

class Favorites {
  final _favorites = <Article>[];

  List<Article> get favorites => _favorites;
  int get articleCount => _favorites.length;

  void add(Article article) {
    bool articleNotInFavorites = true;
    for(Article favorite in _favorites) {
      if(favorite.title == article.title){
        articleNotInFavorites = false;
      }
    }
    if(articleNotInFavorites) {
      _favorites.add(article);
    }
  }

  void remove(Article article) {
    for(int i = 0; i < _favorites.length; i++) {
      if(_favorites[i].title ==article.title) {
        _favorites.removeAt(i);
      }
    }
  }
}