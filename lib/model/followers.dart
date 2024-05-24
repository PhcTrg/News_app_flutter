import 'package:news_reading/model/user_model.dart';

class FollowersModel {
  final int id;
  final UserModel follower;

  FollowersModel({required this.id, required this.follower});

  factory FollowersModel.fromJson(Map<String, dynamic> json) {
    return FollowersModel(
        id: json['id'], follower: UserModel.fromJson(json['follower']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['follower'] = this.follower;
    return data;
  }
}
