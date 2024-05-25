class NewsModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final String category;
  final int user;
  final List<CommentsModel>? comments;

  const NewsModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.category,
      this.comments});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      user: json['user'] as int,
      category: json['category'] as String,
      // comments: json['comments'] as List<Comments>
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>)
              .map((item) => CommentsModel.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    data['user'] = this.user;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentsModel {
  final int id;
  final String username;
  final String content;
  final String createdAt;
  final String updatedAt;
  final int user;
  final int article;

  CommentsModel(
      {required this.id,
      required this.username,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.article});

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
        id: json['id'],
        username: json['username'],
        content: json['content'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        user: json['user'],
        article: json['article']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    data['article'] = this.article;
    return data;
  }
}
