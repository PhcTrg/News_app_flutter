class NotificationModel {
  final String message;
  // final Follower follower;
  // final Article article;
  final String timestamp;

  NotificationModel(
      {required this.message,
      // required this.follower,
      // required this.article,
      required this.timestamp});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        message: json['message'] as String,
        // follower: json['follower'] as Follower,
        // article: json['article'] as Article,
        timestamp: json['timestamp'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    // data['follower'] = this.follower;
    // data['article'] = this.article;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

// class Follower {
//   final int id;
//   final String username;
//   final String firstName;
//   final String lastName;

//   Follower(
//       {required this.id,
//       required this.username,
//       required this.firstName,
//       required this.lastName});

//   factory Follower.fromJson(Map<String, dynamic> json) {
//     return Follower(
//         id: json['id'],
//         username: json['username'],
//         firstName: json['first_name'],
//         lastName: json['last_name']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     return data;
//   }
// }

// class Article {
//   final int id;
//   final String title;
//   final String content;
//   final int user;
//   final String createdAt;
//   final String updatedAt;

//   Article(
//       {required this.id,
//       required this.title,
//       required this.content,
//       required this.user,
//       required this.createdAt,
//       required this.updatedAt});

//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//         id: json['id'],
//         title: json['title'],
//         content: json['content'],
//         user: json['user'],
//         createdAt: json['created_at'],
//         updatedAt: json['updated_at']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['content'] = this.content;
//     data['user'] = this.user;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
