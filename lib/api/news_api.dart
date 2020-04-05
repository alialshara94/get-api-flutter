import 'package:get_data_api/api/api_key.dart';
import 'package:get_data_api/modals/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class NewsApi { 
  Map<String,String> header = {
    'accept' : 'application/json',
  };

  Future<List<Article>> fetchArticles(int page) async{
    String news= 'http://newsapi.org/v2/everything?q=apple&from=2020-04-02&to=2020-04-02&sortBy=popularity&apiKey='+ApiKeys.NEWS_API_KEY+'&page='+page.toString();

    http.Response response = await http.get(news, headers: header);

    if ( response.statusCode != 200) {
      return null;
    }
    var body = jsonDecode(response.body);
    var jsonArticles = body['articles'];
    List<Article> articles = [];
    for (var item in jsonArticles) {
      articles.add(Article.fromJson(item));
    }
    return articles;

  }

}