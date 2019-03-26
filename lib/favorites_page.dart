import 'package:flutter/material.dart';
import 'package:hacker_news/hn_bloc.dart';
import 'package:hacker_news/article.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesPage extends StatefulWidget {
  HackerNewsBloc bloc = HackerNewsBloc();

  FavoritesPage({this.bloc});

  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Hacker News | Favorites',
        style: TextStyle(color:  Colors.black),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<List<Article>>(
      stream: widget.bloc.favorites,
      initialData: List<Article>(),
      builder: (context, snapshot) {
        return ListView(
          children:snapshot.data.map(_buildFavorite).toList(),
        );
      },
    );
  }

  Widget _buildFavorite(Article article) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          Icons.remove,
          color: Colors.black,
        ),
        onPressed: () {
          widget.bloc.favoritesRemoval.add(article);
        },
      ),
      title: Text(article.title),
      subtitle: Text('${article.score} points by ${article.by} | ${article.descendants} comments'),
      onTap: () {
        _launchInWebViewOrVC(article.url);
      },
    );
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}