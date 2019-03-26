import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hacker_news/article.dart';
import 'package:hacker_news/article_model.dart';
import 'package:hacker_news/favorites.dart';

class HackerNewsBloc {
  var _articles = <Article>[];
  final _favorites = Favorites();

  HackerNewsBloc() {
    _favoritesAdditionController.stream.listen(_handleAddition);
    _favoritesRemovalController.stream.listen(_handleRemoval);
    _getArticles().then((_) {
      _articlesBS.add(_articles);
    });
  }

  final StreamController<Article> _favoritesAdditionController = StreamController<Article>();
  Sink<Article> get favoritesAddition => _favoritesAdditionController.sink;

  final StreamController<Article> _favoritesRemovalController = StreamController<Article>();
  Sink<Article> get favoritesRemoval => _favoritesRemovalController.sink;

  final BehaviorSubject<List<Article>> _favoritesBS = BehaviorSubject.seeded(<Article>[]);
  Stream<List<Article>> get favorites => _favoritesBS.stream;

  final BehaviorSubject<List<Article>> _articlesBS = BehaviorSubject.seeded(<Article>[]);
  Stream<List<Article>> get articles => _articlesBS.stream;

  Future<Null> _getArticles() async {
    final model = ArticleModel();
    final articles = await model.getArticles('topstories', 8);
    _articles = articles;
  }

  void _handleAddition(Article article) {
    _favorites.add(article);
    _favoritesBS.add(_favorites.favorites);
  }

  void _handleRemoval(Article article) {
    _favorites.remove(article);
    _favoritesBS.add(_favorites.favorites);
  }

  void dispose() {
    _favoritesAdditionController.close();
    _favoritesRemovalController.close();
    _favoritesBS.close();
    _articlesBS.close();
  }
}