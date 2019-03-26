import 'package:meta/meta.dart';

class Article {
  final String by;
  final String title;
  final String url;
  final int score;
  final int descendants;
  final DateTime time;

  Article({
    @required this.by,
    @required this.title,
    @required this.url,
    @required this.score,
    @required this.descendants,
    @required this.time
  }): assert(by != null),
      assert(title != null),
      assert(url != null),
      assert(score != null),
      assert(descendants != null),
      assert(time != null);

  factory Article.fromJson(Map<String, dynamic> jsonObj) {
    return Article(
      by: jsonObj['by'],
      title: jsonObj['title'],
      url: jsonObj['url'],
      score: jsonObj['score'],
      descendants: jsonObj['descendants'],
      time: DateTime.fromMillisecondsSinceEpoch(jsonObj['time'] * 1000)
    );
  }

  @override
  String toString() {
    String article = 'by: $by, title: $title, url: $url, score: $score, descendants: $descendants time: ${time.toString()}';
    return article;
  }
}