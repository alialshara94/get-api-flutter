import 'package:flutter/material.dart';
import 'package:get_data_api/api/news_api.dart';
import 'package:get_data_api/modals/article.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NewsApi newsApi = NewsApi();
  List<Article> articles = [];
  int pages = 5;
  int currentPage = 1;
  bool loading = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    fetchNews();

    scrollController.addListener(() {
      // print(scrollController.position.pixels);
      // if (scrollController.position.pixels.floor() <=
      //     ((scrollController.position.maxScrollExtent.floor() / 2).floor())) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchNews();
      }
    });
  }

  fetchNews() {
    newsApi.fetchArticles(currentPage).then((futureArticles) {
      articles.addAll(futureArticles);
      setState(() {
        loading = false;
        if (currentPage != pages) {
          currentPage++;
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Api'),
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: scrollController,
                itemCount: articles.length +1,
                itemBuilder: (context, int position) {
                  if (position == articles.length) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Card(
                    child: ListTile(
                      leading: (articles[position].urlToImage != null)
                          ? SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child:
                                  Image.network(articles[position].urlToImage),
                            )
                          : SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: Container(),
                            ),
                      title: Text(articles[position].title),
                    ),
                  );
                }),
      ),
    );
  }
}
