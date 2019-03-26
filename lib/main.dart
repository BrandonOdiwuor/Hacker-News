import 'package:flutter/material.dart';
import 'package:hacker_news/favorites_page.dart';
import 'package:hacker_news/article.dart';
import 'package:hacker_news/hn_bloc.dart';

void main() {
  HackerNewsBloc hackerNewsBloc = HackerNewsBloc();

  runApp(
    MaterialApp(
      title: 'Hacker News',
      home: HomePage(bloc: hackerNewsBloc),
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      routes: {
        '/favorites': (context) => FavoritesPage(bloc: hackerNewsBloc),
      },
      debugShowCheckedModeBanner: false,
    )
  );
}

class HomePage extends StatelessWidget {
  HackerNewsBloc bloc;

  HomePage({this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  AppBar _appBar(BuildContext context){
    return AppBar(
      title: Text(
        'Hacker News',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
      ],
    );
  }

  Widget _body() {
    return StreamBuilder<List<Article>>(
      stream: bloc.articles,
      initialData: List<Article>(),
      builder: (context, snapshot) {
        if(snapshot.data.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children:snapshot.data.map(_buildArticles).toList(),
          );
        }
      },
    );
  }

  Widget _buildArticles(Article article) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        onPressed: () {
          print('Favorite');
          bloc.favoritesAddition.add(article);
        },
      ),
      title: Text(article.title),
      subtitle: Text('${article.score} points by ${article.by} | ${article.descendants} comments'),
    );
  }
}