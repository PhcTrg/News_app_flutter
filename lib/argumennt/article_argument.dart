import 'package:news_reading/model/news_model.dart';
import 'package:news_reading/model/user_model.dart';

class ArticleArguments {
  final NewsModel newsmodel;
  final UserModel? userModel;

  ArticleArguments(this.newsmodel, [this.userModel]);
}
