import 'package:hacker_news/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class ArticleModel {
  final articles = <Article>[];

  Future<List> getIds(String type) async {
    final url = 'https://hacker-news.firebaseio.com/v0/$type.json';
    final response = await http.get(url);
    if(response.statusCode == 200) {
      return json.jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Ids');
    }
  }

  Future<List<Article>> getArticles(String type, int number) async {
    final articles = <Article>[];
    final ids = await getIds(type);
    for(int i = 0; i < number; i++) {
      Article article = await _getArticle(ids[i]);
      articles.add(article);
    }
    return articles;
  }

  Future<Article> _getArticle(int id) async {
    final url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final response = await http.get(url);
    if(response.statusCode == 200) {
      return Article.fromJson(json.jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Article');
    }
  }
}