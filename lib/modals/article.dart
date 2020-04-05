class Article {
  String author,title,description,url,urlToImage,content;
  Article(this.author,this.title,this.description,this.url,this.urlToImage,this.content);

  Article.fromJson( Map<String,dynamic> map){
    this.author = map['author'];
    this.title = map['title'];
    this.description = map['description'];
    this.url = map['url'];
    this.urlToImage = map['urlToImage'];
    this.content = map['content'];
  }
}