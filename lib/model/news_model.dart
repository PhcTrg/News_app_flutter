// class NewsModelDjango {
//   final int count;
//   Null next;
//   Null previous;
//   List<NewsModel>? results;

//   NewsModelDjango(
//       {required this.count, this.next, this.previous, this.results});

//   factory NewsModelDjango.fromJson(Map<String, dynamic> json) {
//     return NewsModelDjango(
//       count: json['id'] as int,
//       next: json['id'] as Null,
//       previous: json['id'] as Null,
//       results: json['results'] != null
//           ? (json['results'] as List<dynamic>)
//               .map((item) => NewsModel.fromJson(item))
//               .toList()
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     data['next'] = this.next;
//     data['previous'] = this.previous;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class NewsModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final int user;
  final List<Comments>? comments;

  const NewsModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      this.comments});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      user: json['user'] as int,
      // comments: json['comments'] as List<Comments>
      comments: json['comments'] != null
          ? (json['comments'] as List<dynamic>)
              .map((item) => Comments.fromJson(item))
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
    data['user'] = this.user;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  final int id;
  final String content;
  final String createdAt;
  final String updatedAt;
  final int user;
  final int article;

  Comments(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.article});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        id: json['id'],
        content: json['content'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        user: json['user'],
        article: json['article']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    data['article'] = this.article;
    return data;
  }
}
